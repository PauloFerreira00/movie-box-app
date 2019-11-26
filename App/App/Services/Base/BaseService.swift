//
//  BaseService.swift
//  App
//
//  Created by Paulo Ferreira de Jesus - PFR on 24/11/19.
//  Copyright © 2019 Paulo Ferreira. All rights reserved.
//

import Foundation
import Moya

// swiftlint:disable all
class BaseService<T: TargetType>: NSObject, URLSessionDelegate {

    var provider = MoyaProvider<T>(plugins: [NetworkLoggerPlugin(verbose: true)])

    typealias ServiceResult<DataType> = NetworkResult<DataType, Error>

    typealias CompletionHandlerPlain = ((_ response: Response?, _ error: Error?) -> Void)?

    typealias CompletionHandler<CodableValue> = ((_ object: CodableValue?,
        _ response: Response?,
        _ error: Error?) -> Void)?

    typealias RequestCompletionHandler<DataType: Codable> = (ServiceResult<DataType>) -> Void

    typealias RequestCompletionHandlerPlain = (ServiceResult<URLResponse>) -> Void

    func fetch(_ target: T, completion: CompletionHandlerPlain) {
        if let error = checkConnection() {
            completion?(nil, error)
        }

        provider.request(target) { result in
            switch result {
            case .success(let response):
                completion?(response, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }

    func fetch<Value: Codable>(_ target: T,
                               dataType: Value.Type,
                               completion: CompletionHandler<Value>) {

        if let error = checkConnection() {
            completion?(nil, nil, error)
        }

        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(dataType, from: response.data)
                    completion?(model, response, nil)
                } catch {
                    print("\n❓JSONDecoder -> \(error)\n")
                    let error = BaseError.parse(error) 
                    completion?(nil, response, error)
                }
            case .failure(let error):
                completion?(nil, nil, error)
            }
        }
    }

    func fetch<Value: Codable>(_ target: T,
                                   dataType: [Value].Type,
                                   completion: RequestCompletionHandler<[Value]>?) {


        fetch(target, dataType: dataType) { (list, response, error) in
            if let error = error {
                completion?(.failure(error))
            }
            completion?(.success(list ?? []))
        }
    }
    
    func fetch<Value: Codable>(_ target: T,
                               dataType: Value.Type,
                               completion: RequestCompletionHandler<Value>?) {

        if let error = checkConnection() {
            completion?(.failure(error))
        }

        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(dataType, from: response.data)
                    completion?(.success(model))
                } catch {
                    print("\n❓JSONDecoder -> \(error)\n")
                    let error = BaseError.parse(error)
                    completion?(.failure(error))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }

}

extension BaseService {
    func checkConnection() -> Error? {
        if !Reachability.isConnectedToNetwork() {
            return BaseError.noConnectedToInternet
        }
        return nil
    }
}

public enum BaseError: Error {
    case network(Error)
    case parse(Error)
    case unknown
    case noConnectedToInternet
    case generic(Error)
}


enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}

enum NetworkResult<T, E: Error> {
    case success(T)
    case failure(E)
    case cache(T, E)
}
