//
//  CardViewModelType.swift
//  BeyondCTAProject
//
//  Created by Taisei Sakamoto on 2022/06/28.
//

import Unio

protocol CardViewModelType: AnyObject {
    var input: InputWrapper<CardViewModel.Input> { get }
    var output: OutputWrapper<CardViewModel.Output> { get }
}
