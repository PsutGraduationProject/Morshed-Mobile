import Foundation
struct GraphQLResponse: Codable {
    var data: TokenAuthResponse
}

struct TokenAuthResponse: Codable {
    var tokenAuth: TokenDetails?
}

struct TokenDetails: Codable {
    var token: String?
}
