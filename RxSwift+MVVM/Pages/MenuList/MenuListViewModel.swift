//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by SUNG on 4/4/24.
//  Copyright © 2024 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

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
        _ = APIService.fetchAllMenusRx()
            .map { data in
                struct Response: Decodable {
                    let menus: [MenuItem]
                }
                let response = try! JSONDecoder().decode(Response.self, from: data)
                
                return response.menus
            }
            .map { menuItems -> [Menu] in
                var menus:[Menu] = []
                menuItems.enumerated().forEach{ (index, item) in
                    let menu = Menu.fromMenuItems(id: index, item: item)
                    menus.append(menu)
                }
                return menus
            }
            .take(1)
            .bind(to: menuObservable)
    }
}

extension MenuListViewModel {
    func onOrder() {
        
    }
    
    func clearAllItemSelections() {
        _ = menuObservable
            .take(1)
            .takeWhile { !$0.isEmpty }
            .subscribe(onNext: { [weak self] _ in
                self?.menuObservable.onNext([])
            })
    }
    
    func changeCount(item: Menu, increase: Int) {
        _ = menuObservable
            .map { menus in
                menus.map { m in
                    if m.id == item.id {
                        return Menu(id: m.id, name: m.name, price: m.price, count: max(m.count + increase, 0))
                    } else {
                        return Menu(id: m.id, name: m.name, price: m.price, count: m.count)
                    }
                }
            }
            .take(1)
            .takeWhile { !$0.isEmpty }
            .subscribe(onNext: {
                self.menuObservable.onNext($0)
            })
    }
}
