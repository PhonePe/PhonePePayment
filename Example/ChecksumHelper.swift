//
//  ChecksumHelper.swift
//  PhonePePaymentExample
//
//  Created by Vishal Jhanjhri on 09/11/21.
//
// ***************IMPORTANT********************
// THIS IS ONLY FOR REFERENCE PURPOSES
// CALCULATE CHECKSUM AND REQUEST IS ONLY IN BACKEND

import Foundation
import CryptoKit
import CommonCrypto


public struct ChecksumHelper {
    public static func calculateChecksum(of input: String, api: String, salt: String, saltIndex: Int) -> String {
        let inputString = input + api + salt

        let finalHash = inputString.sha256() + "###" + String(saltIndex)
        return finalHash
    }
}

extension Data {
    public func sha256() -> String {
        return hexStringFromData(input: digest(input: self as NSData))
    }

    private func digest(input: NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }

    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)

        var hexString = ""
        for byte in bytes {
            hexString += String(format: "%02x", UInt8(byte))
        }

        return hexString
    }
}

extension String {
    func sha256() -> String {
        if let stringData = self.data(using: String.Encoding.utf8) {
            return stringData.sha256()
        }
        return ""
    }
}
