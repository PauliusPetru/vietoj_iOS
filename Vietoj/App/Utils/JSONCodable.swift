import Foundation

struct JSONCodable {
    private static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        //in case will need data someday
//        encoder.dateEncodingStrategy = .formatted(DateFormatter())
        return encoder
    }()
    
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        //in case will need data someday
//        decoder.dateDecodingStrategy = .formatted(DateFormatter())
        return decoder
    }()
    
    static func decode<T: Decodable>(fromData data: Data, logIfError: Bool = true) -> T? {
        do {
            return try decoder.decode(T.self, from: data)
        } catch let error {
            if logIfError {
                if let error = error as? DecodingError {
                    switch error {
                    case .typeMismatch(let key, let value):
                        print("🔴 error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                    case .valueNotFound(let key, let value):
                        print("🔴 error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                    case .keyNotFound(let key, let value):
                        print("🔴 error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                    case .dataCorrupted(let key):
                        print("🔴 error \(key), and ERROR: \(error.localizedDescription)")
                    default:
                        print("🔴 Error: trying to decode: \(T.self) \(error.localizedDescription)")
                    }
                }
            }
            return nil
        }
    }
    
    static func encode<T: Encodable>(fromObject object: T) -> Data? {
        do {
            return try encoder.encode(object)
        } catch let error {
            print("🔴 Error: trying to encode \(T.self)" + error.localizedDescription)
            return nil
        }
    }
}
