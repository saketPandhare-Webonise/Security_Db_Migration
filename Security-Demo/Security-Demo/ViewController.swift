//
//  ViewController.swift
//  Security-Demo

import UIKit
import RNCryptor

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
//        dataEncryption()
        tryEncryption()
        
    }
    
    func dataEncryption() {
        let data = "sample data string".data(using: String.Encoding.utf8)
        let password = "Secret password"
        let encryptedData = RNCryptor.encrypt(data: data!, withPassword: password)
        
        // Decryption
        do {
            let originalData = try RNCryptor.decrypt(data: encryptedData, withPassword: password)
            print("Original Data \(originalData)")
            let backToString = String(data: originalData, encoding: String.Encoding.utf8) as String?
            print("Back To String has \(String(describing: backToString))")
            // ...
        } catch {
            print(error)
        }
    }

   
    
    
    func testCrypt(data:Data, keyData:Data, ivData:Data, operation:Int) -> Data {
        let cryptLength  = size_t(data.count + kCCBlockSizeAES128)
        var cryptData = Data(count:cryptLength)
        
        let keyLength             = size_t(kCCKeySizeAES128)
        let options   = CCOptions(kCCOptionPKCS7Padding)
        
        
        var numBytesEncrypted :size_t = 0
        
        let cryptStatus = cryptData.withUnsafeMutableBytes {cryptBytes in
            data.withUnsafeBytes {dataBytes in
                ivData.withUnsafeBytes {ivBytes in
                    keyData.withUnsafeBytes {keyBytes in
                        CCCrypt(CCOperation(operation),
                                CCAlgorithm(kCCAlgorithmAES),
                                options,
                                keyBytes, keyLength,
                                ivBytes,
                                dataBytes, data.count,
                                cryptBytes, cryptLength,
                                &numBytesEncrypted)
                    }
                }
            }
        }
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.removeSubrange(numBytesEncrypted..<cryptData.count)
            
        } else {
            print("Error: \(cryptStatus)")
        }
        
        return cryptData;
    }
    
    func tryEncryption() {
    let message     = "Don´t try to read this text. Top Secret Stuff"
    let messageData = message.data(using:String.Encoding.utf8)!
    let keyData     = "12345678901234567890123456789012".data(using:String.Encoding.utf8)!
    let ivData      = "abcdefghijklmnop".data(using:String.Encoding.utf8)!
    let encryptedData = testCrypt(data:messageData,   keyData:keyData, ivData:ivData, operation:kCCEncrypt)
    let decryptedData = testCrypt(data:encryptedData, keyData:keyData, ivData:ivData, operation:kCCDecrypt)
    let decrypted     = String(bytes:decryptedData, encoding:String.Encoding.utf8)!
        print("Decrypted has \(decrypted)")
    }
    
    
    @IBAction func buttonPushTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SecurityVC") as UIViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func buttonDBPush(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DBVC") as UIViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


