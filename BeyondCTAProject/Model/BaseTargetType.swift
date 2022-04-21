//
//  BaseTargetType.swift
//  BeyondCTAProject
//
//  Created by Tomoya Tanaka on 2022/04/21.
//

import Foundation
import Moya

protocol BaseTargetType: TargetType {
    associatedtype Response: Decodable
    associatedtype ErrorResponse: Decodable
}
