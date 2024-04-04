//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by SUNG on 4/4/24.
//  Copyright © 2024 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift

class MenuListViewModel {
    // Subject : 외부에서 값을 만들어서 넘겨줄 수 있는 역할
    var menuObservable  = BehaviorSubject<[Menu]>(value: [])
    
    lazy var itemsCount = menuObservable.map {
        $0.map { $0.count }.reduce(0, +)
    }
    
    lazy var totalPrice = menuObservable.map {
        $0.map { $0.price * $0.count }.reduce(0, +)
    }
    
    init() {
        let menus: [Menu] = [
            Menu(name: "튀김1", price: 100, count: 0),
            Menu(name: "튀김2", price: 100, count: 0),
            Menu(name: "튀김3", price: 100, count: 0),
            Menu(name: "튀김4", price: 100, count: 0)
        ]
    
        menuObservable.onNext(menus)
    }
    
    func clearAllItemSelections() {
        _ = menuObservable
            .take(1)
            .takeWhile { !$0.isEmpty }
            .subscribe(onNext: { [weak self] _ in
                self?.menuObservable.onNext([])
            })
    }
}
