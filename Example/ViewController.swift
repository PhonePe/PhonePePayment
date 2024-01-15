//
//  ViewController.swift
//  PhonePePaymentExample
//
//  Created by Vishal Jhanjhri on 03/11/21.
//

import UIKit
import PhonePePayment

class ViewController: UIViewController {

    var newTxnId: String {
        "\(UUID().uuidString.suffix(35))" // MAX 35 characters allowed
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        PPPayment.enableDebugLogs = true // Set to print debug logs
    }
}

extension ViewController {
    func makeDebitRequest() {
        // Change the salt and salt index as per your server
        let saltValue = salt
        let saltIndexValue = saltIndex
        let merchantID = merchantId
        let server = Environment.sandbox

        let service = "/v4/debit"
        let txnId = newTxnId // This id must be unquie for each transaction
        let amount = 200 // Amount should be in paisa
        let userId = "" // Logged in user id
        let message = "Payment towards order No. OD139924923" // Message that will be displayed to user
        let orderID = "OD139924923" // Id of oder for which payment is initiated
        let callBackURL = deeplinkSchema // callback scheme to reopen the app

        let offerInfo = ["offerId": "offerId", "offerDescription": "Amazing offer"]
        let discountInfo = ["discountId": "abc", "discountDescription": "mydescription", "someInfo": ["otherInfo": "Test"]] as [String: Any]

        var data: [String: Any] = [:]
        data["merchantId"] = merchantID
        data["transactionId"] = txnId
        data["amount"] = amount
        data["merchantOrderId"] = orderID
        data["message"] = message
        if !userId.isEmpty {
            data["merchantUserId"] = userId
        }

        data["offer"] = offerInfo
        data["discount"] = discountInfo
        data["providerName"] = "xMerchantId"
        data["paymentScope"] = "PHONEPE"

        guard let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else {
            print("Invalid Data to convert")
            return
        }

        let base64EncodedString = jsonData.base64EncodedString()
        let payloadChecksum = ChecksumHelper.calculateChecksum(of: base64EncodedString, api: service, salt: saltValue, saltIndex: saltIndexValue)

        let headers: [String: String] = ["X-CALLBACK-URL": "https://enjfktbm7ajrh.x.pipedream.net/"]

        print("Initiating Debit Request with data \(data)")
        print("Initiating Debit Request with payloadChecksum \(payloadChecksum)")
        
        let request: DPSTransactionRequest = DPSTransactionRequest(body: base64EncodedString,
                                                                  apiEndPoint: service,
                                                                  checksum: payloadChecksum,
                                                                  headers: headers,
                                                                  appSchema: callBackURL)

        // Set enableLogging = true for debug logs
        PPPayment(environment: server, enableLogging: true, appId: appId)
            .startPhonePeTransactionRequest(transactionRequest: request,
                                            on: self,
                                            animated: true) { _, result in
                let text = "\(result)"
                print(text)
                print("Completion:---------------------")
            }
    }

    func makePGRequest(type: PaymentInstrumentType) {
        let saltValue = salt
        let saltIndexValue = saltIndex
        let merchantID = merchantId
        let server = Environment.sandbox

        let service = "/pg/v1/pay"
        let txnId = newTxnId // This id must be unquie for each transaction
        let amount = 200 // Amount should be in paisa
        let userId = "U100121333" // Logged in user id
        let message = "Payment towards order No. OD139924923" // Message that will be displayed to user
        let iOSAppCallbackSchema = ""
        let callBackURL = "https://www.phonepe.com"
        let redirectURL = "https://www.phonepe.com"

        var paymentInstrument: [String: Any] = ["type": type.rawValue]
        paymentInstrument["vpa"] = type == .UPI_COLLECT ? "test@ybl" : nil

        var data: [String: Any] = [:]
        data["merchantId"] = merchantID
        data["merchantTransactionId"] = txnId
        data["amount"] = amount
        data["message"] = message
        data["merchantUserId"] = userId
        data["redirectUrl"] = redirectURL
        data["redirectMode"] = "GET"
        data["callbackUrl"] = callBackURL
        data["paymentInstrument"] = paymentInstrument

        guard let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else {
            print("Invalid Data to convert")
            return
        }

        let base64EncodedString = jsonData.base64EncodedString()
        let payloadChecksum = ChecksumHelper.calculateChecksum(of: base64EncodedString, api: service, salt: saltValue, saltIndex: saltIndexValue)

        let headers: [String: String] = [:]

        print("Initiating PG Request with data \(data)")
        print("Initiating PG Request with payloadChecksum \(payloadChecksum)")

        let request: DPSTransactionRequest = DPSTransactionRequest(body: base64EncodedString,
                                                                  apiEndPoint: service,
                                                                  checksum: payloadChecksum,
                                                                  headers: headers,
                                                                  appSchema: iOSAppCallbackSchema)

        // Set enableLogging = true for debug logs
        PPPayment(environment: server, enableLogging: true, appId: appId)
            .startPG(transactionRequest: request,
                     on: self,
                     animated: true) { _, result in
                let text = "\(result)"
                print(text)
                print("Completion:---------------------")
            }

    }
}

enum PaymentInstrumentType: String {
    case UPI_INTENT
    case UPI_COLLECT
}
