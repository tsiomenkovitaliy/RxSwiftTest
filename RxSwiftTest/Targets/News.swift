import Foundation
import Moya

public enum News {
    case everything(_ qwery: String)
    static var apiKey = "1b00d1de53d947f39031acd025cb94c7"
}

extension News: TargetType {
  public var baseURL: URL {
    return URL(string: "https://newsapi.org/v2")!
  }

  public var path: String {
    switch self {
    case .everything:
        return "/everything"
    }
  }

  
  public var method: Moya.Method {
    switch self {
    case .everything:
        return .get
    }
  }

  
  public var sampleData: Data {
    return Data()
  }
    
    public var parameters: [String: Any] {
        return ["apiKey": News.apiKey]
    }


    public var task: Task {
      switch self {
      case .everything(let qwery):
        return .requestParameters(
            parameters: ["q": qwery] + (parameters),
          encoding: URLEncoding.default)
      }
    }

  // 6
  public var headers: [String: String]? {
    return ["Content-Type": "application/json"]
  }

  // 7
  public var validationType: ValidationType {
    return .successCodes
  }
}
