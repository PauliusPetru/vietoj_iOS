import Foundation
import KeychainAccess

final class KeychainManager {
    
    static let shared = KeychainManager()
    
    private init() {}
    
    private let tokenKey = "tokenKey"
    private let nameKey = "nameKey"
    
    private let keychain = Keychain(service: "com.organization.vietoj")
    
    func getToken() -> String? {
        guard let authData = keychain[data: tokenKey] else {
            return nil
        }
        return JSONCodable.decode(fromData: authData)
    }
    
    func getName() -> String? {
        guard let authData = keychain[data: nameKey] else {
            return nil
        }
        return JSONCodable.decode(fromData: authData)
    }
    
    func set(token: String?) {
        if let encoded = JSONCodable.encode(fromObject: token) {
            keychain[data: tokenKey] = encoded
        }
    }
    
    func set(name: String?) {
        if let encoded = JSONCodable.encode(fromObject: name) {
            keychain[data: nameKey] = encoded
        }
    }
}
