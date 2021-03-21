import Foundation

struct ApiConstants {
    static let defaultRequestTimeout: TimeInterval = 60

    struct Header {
        static let authorization = "Authorization"
    }
    
    struct ResponseStatusCode {
        static let unauthorized = 401
    }
    
    struct Url {
        static let apiHost = "https://app.vietoj.lt/api/"
        
        struct Auth {
            static let aa = "sdsad"
            static let registration = "checkin/user/register"
            static let phoneConfirm = "checkin/user"
        }
        
        static let chechin = "checkin/"
        
        static let place = "place/"
    }
}
