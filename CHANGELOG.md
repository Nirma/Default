# Change Log

All notable changes to this project will be documented in this file.
`Default` adheres to [Semantic Versioning](http://semver.org/).

--- 

## [2.0.0](https://github.com/Nirma/Default/releases/tag/2.0.0) (11/20/2017)

#### Summary
The release's focus is about shortening the read / write method names and adding support for having a default
value for when the value being read is currently not stored in the users defaults.

## Changes
- Writing an object to `UserDefaults` with Default is now accomplished with: `write()` or `write(withKey:)`
- Reading an object from `UserDefaults` is now accomplished with `read()` or `read(forKey:)`
- `defaultValue` has been added to the protocol, the default implementation returns `nil` can be customized
to return a default value when nothing exists in defaults.

## [1.0.0](https://github.com/Nirma/Default/releases/tag/1.0.0) (10/19/2017)

#### Summary
This is the first release of this library!
Please see the README to learn more!

