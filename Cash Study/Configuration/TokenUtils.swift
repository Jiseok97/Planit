//
//  TokenUtils.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/12.
//

import Security
import Alamofire

class TokenUtils {
    func create(_ service: String, account: String, value: String) {
        
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
        ]
        
        SecItemDelete(keyChainQuery)
        
        let status: OSStatus = SecItemAdd(keyChainQuery, nil)
        assert(status == noErr, "토큰 저장에 실패했습니다. (create)")
    }
    
    func read(_ service: String, account: String) -> String? {
        let keyChainQuery: NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount : account,
            kSecReturnData : kCFBooleanTrue,
            kSecMatchLimit : kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(keyChainQuery, &dataTypeRef)
        
        if(status == errSecSuccess) {
            let retrievedData = dataTypeRef as! Data
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value
        } else {
            print("데이터를 읽는데 실패하였습니다. (read) → \(status)")
            return nil
        }
    }
    
    
    func delete(_ service: String, account: String) {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount : account
        ]
        
        let status = SecItemDelete(keyChainQuery)
        assert(status == noErr, "데이터를 삭제하는데 실패하였습니다. (delete) → \(status)")
    }
    
    
    func getAuthorizationHeader(serviceID: String) -> HTTPHeaders? {
        let serviceID = serviceID
        if let accessToken = self.read(serviceID, account: "accessToken") {
            return ["Authorization" : "brearer\(accessToken)"] as HTTPHeaders
        } else {
            return nil
        }
    }
    
}
