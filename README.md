This app provides an interactive interface to test the various methods and actions available in Ably's Push Notifications product.

## Pre-requisites

1. [Xcode](https://developer.apple.com/xcode/) 
2. A physical iOS device as Push Notifications cannot be tested on a simulator
3. [NodeJS](https://nodejs.org/en/) (to run the server locally)

## How to use this example app

- Clone this project locally

### Launch the authentication server
You can either launch it locally or run host it on a server like [Glitch](https://glitch.com)
Make sure that your `server.js` has your API keys with the required permissions:
- `push-subscribe`: Allows you to activate push on device, subscribe to push to receive notifications
- `push-admin`: Has `push-subscribe` rights plus rights to publish notifications directly using various credentials or via a realtime channel.
- Install the dependencies: `cd server && npm install` 
- Run the local server: `npm start`

### Launch the iOS application
- `$ cd` to the folder where you cloned this project.
- Run `$ open push-interactive-app.xcodeproj` to open the project in Xcode.
- Connect your iPhone and choose it to be your target build device in Xcode.
- In `AppDelegate.swift`, update `authURL` with your authentication server.
- Run the project in Xcode. It will install the app on your phone.

## Screenshots

![1](https://user-images.githubusercontent.com/5900152/61132907-3ca49b80-a4b4-11e9-8982-94f9b7ddb96c.jpg)
![2](https://user-images.githubusercontent.com/5900152/61132906-3ca49b80-a4b4-11e9-842b-659d925acb2a.jpg)
