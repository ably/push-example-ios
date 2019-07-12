This app provides an interactive interface to test the various methods and actions available in Ably's Push Notifications product.

## Pre-requisites

Make sure you have the following installed on your system:

1. [Xcode](https://developer.apple.com/xcode/) 
2. [CocoaPods](https://cocoapods.org/)
3. An apple device as Push Notifications cannot be tested on an emulator

## How to use this app?

1. Clone this project locally.
2. `$ cd` to the folder where you cloned this project.
3. Run `$ pod install` to install the dependencies from the Podfile.
4. Run `$ open push-interactive-app.xcworkspace` to open the project in Xcode.
5. Connect your iPhone and choose it to be your target build device in Xcode.
6. Host the `server.js` file on a server like [Glitch](https://glitch.com)
7. Run the project in Xcode. It will install the app on your phone.

Make sure that your `server.js` has your API keys with required permission:
- `push-subscribe`: Allows you to activate push on device, subscribe to push to receive notifications
- `push-admin`: Has `push-subscribe` rights plus rights to publish notifications directly using various credentials or via a realtime channel.

## Screenshots

![1](https://user-images.githubusercontent.com/5900152/61132907-3ca49b80-a4b4-11e9-8982-94f9b7ddb96c.jpg)
![2](https://user-images.githubusercontent.com/5900152/61132906-3ca49b80-a4b4-11e9-842b-659d925acb2a.jpg)