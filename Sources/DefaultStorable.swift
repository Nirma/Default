//
// DefaultStorable.swift
//
// Copyright (c) 2017-2019 Nicholas Maccharoli
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

public protocol DefaultStorable {
    static var defaults: UserDefaults { get }
    static var defaultIdentifier: String { get }
    static var defaultValue: Self? { get }
    static func read(forKey key: String?) -> Self?
    func write(withKey key: String?)
    func clear(forKey key: String?)
    static func clear(forKey key: String?)
}

extension DefaultStorable where Self: Codable {
    public static var defaultIdentifier: String {
        return String(describing: type(of: self))
    }

    public static var defaults: UserDefaults {
        return UserDefaults.standard
    }

    public static var defaultValue: Self? {
        return nil
    }

    public func write(withKey key: String? = nil) {
        let key: String = key ?? Self.defaultIdentifier
        Self.defaults.df.store(self, forKey: key)
    }

    public static func read(forKey key: String? = nil) -> Self? {
        let key: String = key ?? defaultIdentifier
        return defaults.df.fetch(forKey: key, type: Self.self) ?? defaultValue
    }

    public func clear(forKey key: String? = nil) {
        type(of: self).clear(forKey: key)
    }

    public static func clear(forKey key: String? = nil) {
        let key: String = key ?? Self.defaultIdentifier
        return Self.defaults.removeObject(forKey: key)
    }
}
