//
//  UnexpectedError.swift
//  BeyondCTAProject
//
//  Created by Tomoya Tanaka on 2022/04/21.
//

import Foundation

struct UnexpectedError: Error {}

extension UnexpectedError: LocalizedError {
    var errorDescription: String? {
        return "unexpected error"
    }
}
