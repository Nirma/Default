//
// Default+Codable.swift
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

extension Default where Base: UserDefaults {
    public func store<T: Codable>(_ value: T,
                           forKey key: String,
                           encoder: JSONEncoder = JSONEncoder()) {
        if let data: Data = try? encoder.encode(value) {
            (base as UserDefaults).set(data, forKey: key)
        }
    }
    
    public func fetch<T>(forKey key: String,
                  type: T.Type,
                  decoder: JSONDecoder = JSONDecoder()) -> T? where T: Decodable {
        if let data = (base as UserDefaults).data(forKey: key) {
            return try? decoder.decode(type, from: data) as T
        }
        
        return nil
    }
}
