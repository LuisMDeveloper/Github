//
//  GithubAPI.swift
//  Github
//
//  Created by Luis Manuel Ramirez Vargas on 19/05/17.
//  Copyright © 2017 Luis Manuel Ramirez Vargas. All rights reserved.
//

import Moya


private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

enum GitHub {
    case userProfile(username: String)
    case users(since: String?)
}

extension GitHub: TargetType {
    /// La URL de destino.
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    
    /// La ruta a ser añadida a `baseURL` para formar la URL completa.
    public var path: String {
        switch self {
        case .userProfile(let username):
            return "/users/\(username.URLEscapedString)"
        case .users(_):
            return "/users"
        }

    }
    
    /// El método HTTP utilizado en la solicitud.
    public var method: Moya.Method {
        switch self {
        case .userProfile, .users:
            return .get
        }
    }

    /// Los parámetros a codificar en la solicitud.
    public var parameters: [String : Any]? {
        switch self {
        case .userProfile(_):
            return nil
        case .users(let since):
            if let since = since {
                return ["since": "\(since)"]
            }
            return nil
        }

    }

    /// El método utilizado para la codificación de parámetros.
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }

    /// Proporciona datos de stub para su uso en pruebas.
    public var sampleData: Data {
        switch self {
        case .userProfile(let username):
            return "{\"login\": \"\(username)\", \"id\": 100}".data(using: .utf8)!
        case .users(_):
            return "[{\"login\": \"LuisMDeveloper\", \"id\": 100}]".data(using: .utf8)!
            
        }
    }

    /// El tipo de tarea HTTP que se realizará.
    public var task: Task {
        return .request
    }

}
