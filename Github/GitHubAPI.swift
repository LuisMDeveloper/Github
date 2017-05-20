//
//  GithubAPI.swift
//  Github
//
//  Created by Luis Manuel Ramirez Vargas on 19/05/17.
//  Copyright © 2017 Luis Manuel Ramirez Vargas. All rights reserved.
//

import Foundation
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
    /// The target's base `URL`.
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .userProfile(let username):
            return "/users/\(username.URLEscapedString)"
        case .users(let since):
            return "/users"
        }

    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        case .userProfile, .users:
            return .get
        }
    }

    /// The parameters to be encoded in the request.
    public var parameters: [String : Any]? {
        switch self {
        case .userProfile(let username):
            return nil
        case .users(let since):
            if let since = since {
                return ["since": "\(since)"]
            }
            return nil
        }

    }

    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }

    /// Provides stub data for use in testing.
    public var sampleData: Data {
        switch self {
        case .userProfile(let username):
            return "{\"login\": \"\(username)\", \"id\": 100}".data(using: .utf8)!
        case .users(_):
            return "[{\"login\": \"LuisMDeveloper\", \"id\": 100}]".data(using: .utf8)!
            
        }
    }

    /// The type of HTTP task to be performed.
    public var task: Task {
        return .request
    }

}
