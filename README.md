# Default
[![Build Status](https://travis-ci.org/Nirma/Default.svg?branch=master)](https://travis-ci.org/Nirma/Default)
![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-333333.svg)
![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/Default.svg)](#cocoapods)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)

Modern interface to UserDefaults + Codable support

# What is Default?
`Default` is a library that extends what `UserDefaults` can do by providing extensions for saving custom objects that conform to `Codable` and also providing a new interface to UserDefaults described below, via the protocol `DefaultStorable`.
You can use only the `Codable` support extensions or the `DefaultStorable` protocol extensions or both. (or none)

# Features
- [x] Read and write custom objects directly to `UserDefaults` that conform to `Codable`
- [x] Provides an alternative to `UserDefaults` with `DefaultStorable`

### Dont see a feature you need?
Feel free to open an Issue requesting the feature you want or send over a pull request!

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
settings.storeToDefaults()
```

### Read it back later when ya need it!
```swift
if let settings = VisualSettings.fetchFromDefaults() {
    // Do something
}
```

## Swift 4 `Codable` Support
This library offers support for directly storing custom objects to `UserDefaults` that conform to `Codable`.
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

### Alternative to using `Codable`
```swift
// 1: Define class 
class VolumeSetting: NSObject, NSCoding {
    let sourceName: String
    let value: Double
    init(sourceName: String, value: Double) {
        self.sourceName = sourceName
        self.value = value
    }
    required init(coder decoder: NSCoder) {
        self.sourceName = decoder.decodeObject(forKey: "sourceName") as? String ?? ""
        self.value = decoder.decodeDouble(forKey: "value")
    }

    func encode(with coder: NSCoder) {
        coder.encode(sourceName, forKey: "sourceName")
        coder.encode(value, forKey: "value")
    }
}

// 2: Write

let setting = VolumeSetting(sourceName: "Super Expensive Headphone Amp", value: 0.4)
let encodedData = NSKeyedArchiver.archivedData(withRootObject: setting)
UserDefaults.standard.set(encodedData, forKey: "volume")

// 3: Read

if let data = UserDefaults.standard.data(forKey: "volume"),
   let volumeSetting = NSKeyedUnarchiver.unarchiveObject(with: data) as? VolumeSetting {
   // do something
   }
   
```

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
