//
//  SideMenuView.swift
//  SideMenu
//
//  Created by 住田雅隆 on 2022/06/07.
//

import SwiftUI

struct MenuList: Identifiable {
    var id = UUID()
    var name : String
}

struct SideMenuView: View {
    
    @State private var menuList = [
        MenuList(name: "menu1"),
        MenuList(name: "menu2"),
        MenuList(name: "menu3"),
    ]
    
    var body: some View {
        Form {
            ForEach(menuList) { index in
                Button(action: {
                    print("セルが押されました")
                }) {
                    Text(index.name)
                }
                .foregroundColor(.black)
            }
        }
        .formBackground(.white)
    }
}

extension Form {
    
    func formBackground(_ color: Color) -> some View {
        UITableView.appearance().backgroundColor = UIColor(color)
        return self
    }
}
