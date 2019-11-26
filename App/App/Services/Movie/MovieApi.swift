//
//  MovieApi.swift
//  App
//
//  Created by Paulo Ferreira de Jesus - PFR on 24/11/19.
//  Copyright © 2019 Paulo Ferreira. All rights reserved.
//

import Moya

enum MovieApi {
    case popularMovies(pageNumber: Int, language: Language)
    case details(id: Int, language: Language)
    case credits(id: Int, language: Language)
}

extension MovieApi: TargetType {
    var baseURL: URL {
        return Environment.baseUrl
    }

    var path: String {
        switch self {
        case .popularMovies:
            return "popular"
        case .details(let id):
            return "movie/\(id)"
        case .credits(let id):
            return "movie/\(id)/credits"
        }
    }

    var method: Method {
        switch self {
        case .popularMovies, .details, .credits:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .popularMovies(let pageNumber, let language):
            let parameters = getParametersFor(endpoint: .popularMovies(pageNumber: pageNumber, language: language))
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .details(_, let language):
            let parameters = getParametersFor(endpoint: .details(id: 0, language: language))
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .credits(_, let language):
            let parameters = getParametersFor(endpoint: .credits(id: 0, language: language))
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return nil
    }

}

extension MovieApi {
    func getParametersFor(endpoint: MovieApi) -> [String: Any] {
        switch endpoint {
        case .popularMovies(let pageNumber, let language):
            let parameters: [String: Any] = [
                RequestParameters.Key.apiKey.rawValue: Environment.apiKey,
                RequestParameters.Key.language.rawValue: language.rawValue,
                RequestParameters.Key.page.rawValue: pageNumber
            ]
            return parameters
        case .details(_, let language):
            let parameters: [String: Any] = [
                RequestParameters.Key.apiKey.rawValue: Environment.apiKey,
                RequestParameters.Key.language.rawValue: language.rawValue
            ]
            return parameters
        case .credits(_, let language):
            let parameters: [String: Any] = [
                RequestParameters.Key.apiKey.rawValue: Environment.apiKey,
                RequestParameters.Key.language.rawValue: language.rawValue
            ]
            return parameters
        }
    }
}
