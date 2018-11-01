<img src="cassette.jpg" width="40%">

# Default
[![Build Status](https://travis-ci.org/Nirma/Default.svg?branch=master)](https://travis-ci.org/Nirma/Default)
![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-333333.svg)
![Swift 4.2](https://img.shields.io/badge/Swift-4.2-orange.svg)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/Default.svg)](#cocoapods)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)

Modern interface to UserDefaults + Codable support

# What is Default?
`Default` is a library that extends what `UserDefaults` can do by providing extensions for saving custom objects that conform to `Codable` and also providing a new interface to UserDefaults described below, via the protocol `DefaultStorable`.
You can use only the `Codable` support extensions or the `DefaultStorable` protocol extensions or both. (or none, that's cool too)

# Features
- [x] Read and write custom objects directly to `UserDefaults` that conform to `Codable`
- [x] Provides an alternative API to `UserDefaults` with `DefaultStorable`

### Don't see a feature you need?
Feel free to open an Issue requesting the feature you want or send over a pull request!

# Why default?
This library has 
Storing keys and values in defaults the normal way is error prone because typing out the string value for a key 
every time leaves the possibility of mistyped keys and keeping track of which keys are used and what is currently stored in 
`UserDefaults` is somewhat hard. 
Defining objects specifically for storing in user defaults makes the job of keeping track of what is currently being stored in `UserDefaults` as simple as searching the project's source code for instances that conform to `DefaultStorable`.
Using objects specifically for storing a set of data in UserDefaults allows settings for a certain piece of data to be logically grouped together.

# Usage
## `DefaultStorable` - A _better way_ of interacting with `UserDefaults`
Instead of manually adding key values to the key store or having to implement `NSCoding` manually and bloating up
object code, you can simply and clearly define _defaults_ objects with a clear intent of being used as a means of storing
defaults. 

Much like how conforming to `Codable` gets you a lot for free, so does conforming to `DefaultStorable`.
**The object conforming to `DefaultStorable` _must also conform to_ `Codable`:

Say we want to store theme settings in `UserDefaults` (fair enough right?) we first define our object conforming to `Codable`  and `DefaultStorable`.

### Define object conforming to `DefaultStorable`
```swift
struct VisualSettings: Codable, DefaultStorable {
    let themeName: String
    let backgroundImageURL: URL?
}
```

### Create & Save the object to `UserDefaults`
```swift
let settings = VisualSettings(themeName: "bright", backgroundImageURL: URL(string: "https://..."))
settings.write()
```
If you need to save the data under a different key other than the default key (the type name, in this case `"VisualSettings"`) then this can be achieved by providing the optional argument to `write(withKey:)`:
```swift
let settings = VisualSettings(themeName: "bright", backgroundImageURL: URL(string: "https://..."))
settings.write(withKey: "someUniqueKey")
```

### Read it back later when ya need it!
```swift
if let settings = VisualSettings.read() {
    // Do something
}
```
If you saved the default under a unque key then it can be read back by providing the optional argument to `read(forKey:)`:

```swift
if let settings = VisualSettings.read(forKey: "someUniqueKey") {
    // Do something
}
```



## Swift 4 `Codable` Support
This library offers support for directly storing custom objects within `UserDefaults` that conform to `Codable`.
With the release of Swift 4 comes the `Codable` protocol, which provides support for serializing objects.
`UserDefaults` has not been updated to work with Swift 4's `Codable` protocol so if saving custom objects directly to 
`UserDefaults` is necessary then that object must support `NSCoding` and inherit from `NSObject`.

```swift

// 1: Declare object (just conform to Codable, getting default encoder / decoder implementation for free)
struct VolumeSetting: Codable {
    let sourceName: String
    let value: Double
}

let setting = VolumeSetting(sourceName: "Super Expensive Headphone Amp", value: 0.4)
let key: String = String(describing: VolumeSetting.self)

// 2: Write
UserDefaults.standard.df.store(setting, forKey: key)

// 3: Read
UserDefaults.standard.df.fetch(forKey: key, type: VolumeSetting.self)

```

# Customization
If the default behaviour of `Default` does not quite fit your needs, then any of the default implementation details
can be overridden. 

The most commonly overridden properties are `defaultIdentifier` and `defaults`.

### `defaultIdentifier`

`defaultIdentifier` is the key by which your object will be stored.
This defaults to the type name of the object being stored.

```swift
  public static var defaultIdentifier: String {
        return String(describing: type(of: self))
    }
```

### `defaults`
`defaults` will return the `UserDefaults` database that your application will store defaults objects in. 
The default implementation returns `UserDefaults.standard`

```swift
    public static var defaults: UserDefaults {
        return UserDefaults.standard
    }
```

### How does this library work?
`UserDefaults` requires custom types to confrom to NSCoding and be a subclass of `NSObject`.
Doing that is a little time consuming, and conforming to `NSCoding` requires implementing Decoding / Encoding methods
that take a bit of code to implement.
The good news is that `Data` conforms to `NSCoding` so if you can find a way to convert your object to `Data` then you can store it in `UserDefaults`, The `Codable` protocol in Swift 4 does just that!
This library takes advantage of the `Codable` protocol introduced in Swift 4. 
The way it works is by taking an object that conforms to `Codable` and encoding it into 
a `Data` object which can then be stored in `UserDefaults`, then when you want to read it back out again just convert using `Codable` again!

It's that Simple!

## Installation

#### Carthage

If you use Carthage to manage your dependencies, simply add
Default to your `Cartfile`:

```
github "Nirma/Default"
```

If you use Carthage to build your dependencies, make sure you have added `Default.framework` to the "_Linked Frameworks and Libraries_" section of your target, and have included `Default.framework` in your Carthage framework copying build phase.

#### CocoaPods

If you use CocoaPods to manage your dependencies, simply add
Default to your `Podfile`:

```ruby
pod 'Default'
```

## Requirements

* Xcode 9.0
* Swift 4.0+

## Contribution
Contributions are more than welcome!

## License

Default is free software, and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE
