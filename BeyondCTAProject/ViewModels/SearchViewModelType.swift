//
//  SearchViewModelType.swift
//  BeyondCTAProject
//
//  Created by Taisei Sakamoto on 2022/08/24.
//

import Unio

protocol SearchViewModelType: AnyObject {
    var input: InputWrapper<SearchViewModel.Input> { get }
    var output: OutputWrapper<SearchViewModel.Output> { get }
}
