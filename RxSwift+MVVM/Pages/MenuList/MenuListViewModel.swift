//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by SUNG on 4/4/24.
//  Copyright © 2024 iamchiwon. All rights reserved.
//

import Foundation

class MenuListViewModel {
    var menus: [Menu] = [
        Menu(name: "튀김1", price: 100, count: 0),
        Menu(name: "튀김2", price: 100, count: 0),
        Menu(name: "튀김3", price: 100, count: 0),
        Menu(name: "튀김4", price: 100, count: 0)
    ]
    
    var itemsCount: Int = 5
    var totalPrice: Int = 400
}
