# PhonePePayment

[![Version](https://img.shields.io/cocoapods/v/PhonePePayment.svg?style=flat)](https://cocoapods.org/pods/PhonePePayment)
[![License](https://img.shields.io/cocoapods/l/PhonePePayment.svg?style=flat)](https://cocoapods.org/pods/PhonePePayment)
[![Platform](https://img.shields.io/cocoapods/p/PhonePePayment.svg?style=flat)](https://cocoapods.org/pods/PhonePePayment)

PhonePe Intent SDK for iOS provides a simple integration that you can use in your iOS application to process your Transactions through the PhonePe ecosystem.

If the PhonePe app is installed on the customer device, that is opened and once the user has completed the transaction they are redirected back to your application seamlessly.

If the PhonePe app is not installed, then the transaction is processed via a WKWebView embed without any intervention requirement by the merchant.

For more details [click here](https://developer.phonepe.com/v1/docs/introduction)

## Pre-requisites

1. XCode 12.4 or newer
2. Cocoapod
3. Onboarded on PhonePe as a Merchant (Given a `MerchantID`, & `Saltkeys` to generate the checksum on your servers). If missing with Onboarding Detail [Click Here](https://developer.phonepe.com/v1/docs/introduction)
4. PhonePeAppId, **To Get AppId**: Share the Apple Team Id with the integration team to generate the AppId to be used.

## Installation

__Step 1__: PhonePePayment is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PhonePePayment'
```

then run

```shell
pod install
```

## Quick Setup

__Step 1__: <span id="in_query"><span> Set LSApplicationQueriesSchemes

In your Info.plist, create or append a new Array type node LSApplicationQueriesSchemes to append the following values:

```swift
<key>LSApplicationQueriesSchemes</key>
<array>
        <string>ppemerchantsdkv1</string>
        <string>ppemerchantsdkv2</string>
        <string>ppemerchantsdkv3</string>
</array>
```
![LSApplicationQueriesSchemes](https://files.readme.io/256dde4-LSApplicationQueriesSchemes.png)

__Step 2__: <span id="in_phonepeappid"><span>Set PhonePeAppId

Add PhonePeAppId key with value as string in your app’s Info.plist as shown in the below screenshot for analytics purposes.<br>
**To Get AppId**: Share the Apple Team Id with the integration team to generate the AppId to be used.

![PhonePeAppId](https://files.readme.io/6ee690d-App_Id.png)


__Step 3__: <span id="in_deeplink"><span> Create Deeplink

Create a URLType for your app (Deeplink),
For example, we have used: **iOSIntentIntegration**. (It will be prefered to create your own identifier for your app)

![Deeplink](https://files.readme.io/8492274-URLType.png)



You can find more information about that [here](https://developer.phonepe.com/v1/docs/getting-started-6).

## Run Example App

This app demonstrates how to use the SDK to make calls, and can be run directly by entering your own `MerchantID`, `PhonePeAppId`, & `Saltkeys`. 

To execute the Example app:

__Step 1__: Clone Repo
```shell
$ git clone https://github.com/PhonePe/PhonePePayment
```

__Step 2__: Run Pod Install
We have already set the `pod PhonePePayment` in example podfile
```shell
$ cd Examples/PodExample
$ pod install
```

__Step 3__: Open Xcode Project File
```shell
$ open PhonePePaymentExample.xcworkspace
```

__Step 4__: QUICK SETUP

Flow [Setup steps](#quick-setup)

__Step 5__: Insert your client ID and client secret and Deeplink URL

Set your MERCHANT_ID, SALT_KEY and SALT_INDEX values to the sample app in the `Constant.swift` file in the sample app. If You don't have it please contact us at merchant-integration@phonepe.com
```swift
let saltIndex: Int = 0 //YOUR SALT INDEX
let salt: String = "YOUR SALT KEY GOES HERE"
let merchantId: String = "YOUR MERCHANT ID HERE GOES HERE"
```

Set your created DEEPLINK_URL value to the sample app in the `Constant.swift` 
```swift
let deeplinkSchema: String = "PhonePeExampleScheme" //YOUR CUSTOM UNIQUE DEEPLINK SCHEMA
```

__Step 6__: Run the app

<!-- ## Troubleshoot -->

## FAQ
See [FAQ](https://developer.phonepe.com/v1/docs/general-faqs) or contact us at merchant-integration@phonepe.com

## License

PhonePePayment is available under the Proprietary license. Copyright © 2021 PhonePe. All rights reserved.
