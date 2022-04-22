//
//  ViewController.swift
//  PhonePePaymentExample
//
//  Created by Vishal Jhanjhri on 17/11/21.
//

import UIKit
import PhonePePayment

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        PhonePeDPSDK.enableDebugLogs = true // Set to print debug logs
    }

    @IBAction func startTransactionAction(_ sender: Any) {
        makeDebitRequest()
    }
}

extension ViewController {
    func makeDebitRequest() {
        let saltValue = salt
        let saltIndexValue = saltIndex
        let merchantID = merchantId
        let server = Environment.uat //

        let service = "/v4/debit"
        let txnId = UUID.init().uuidString // This id must be unquie for each transaction
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

        let headers: [String: String] = ["X-CALL-MODE": "POST",
                                         "X-CALLBACK-URL": "https://enjfktbm7ajrh.x.pipedream.net/"]

        print("Initiating Request wih data \(data)")
        print("Initiating Request wih payloadChecksum \(payloadChecksum)")

        let request: DPSTransactionRequest = DPSTransactionRequest(body: base64EncodedString,
                                                                  apiEndPoint: service,
                                                                  checksum: payloadChecksum,
                                                                  headers: headers,
                                                                  callBackURL: callBackURL)

        // Set enableLogging = true for debug logs
        PhonePeDPSDK.init(environment: server, enableLogging: true)
            .startPhonePeTransactionRequest(transactionRequest: request,
                                            on: self,
                                            animated: true) { _, result in
                var text = ""
                text = text + "Successful: \(result.isSuccessful)\n"
                text = text + "Message: \(result.message ?? "NA")\n"
                text = text + "Status Code: \(result.statusCode ?? "NA")\n"
                print(text)

                print("Completion:---------------------")
            }
    }
}
