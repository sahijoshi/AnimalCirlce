//
//  Util.swift
//  LearnAboutAnimalApp
//
//  Created by skj on 1.1.2021.
//

import Foundation

public func dLog<T>(_ object: @autoclosure () -> T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    #if DEBUG
        let value = object()
        print(value)
    #endif
}
