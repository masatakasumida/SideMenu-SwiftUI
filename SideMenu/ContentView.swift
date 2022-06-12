//
//  ContentView.swift
//  SideMenu
//
//  Created by 住田雅隆 on 2022/06/06.
//

import SwiftUI


struct ContentView: View {
    
    let menuWidth = UIScreen.main.bounds.width * 0.8
    @State var showMenu: Bool = false
    @State var xPosition: CGFloat = 0
    @State var isDrag: Bool = false
    
    var drag: some Gesture {
        DragGesture()
            .onChanged{ value in
                isDrag = true
                // value.location.x - value.startLocation.x がドラッグしている距離
                // 移動させすぎないようにmaxとminで最大値と最小値の設定
                if showMenu {
                    xPosition = max(min(menuWidth + value.location.x - value.startLocation.x, menuWidth), 0)//画面を閉じる時
                   
                } else {
                    xPosition = max(min(value.location.x - value.startLocation.x, menuWidth), 0)//画面を開く時
                    
                }
            }
            .onEnded{ value in
                
                // Dragが終了したタイミングで開くか、閉じるかを判定したい
                if value.location.x - value.startLocation.x >= menuWidth * 0.3 {
                    showMenu = true
                } else if -(value.location.x - value.startLocation.x) >= menuWidth * 0.3 {
                    showMenu = false
                }
                isDrag = false
            }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            Button(action: {
                self.showMenu.toggle()
            },label: {
                Text("SideMenu")
                    .font(.system(size:30))
                
            })
            
            .frame(width: geometry.size.width, height: geometry.size.height)
            
            .background(Color.white)
            .gesture(drag)//画面白のViewに対してDragGesture
            // 背景を暗くする
            Color.gray.opacity(
                Double(isDrag ? xPosition / menuWidth : (showMenu ? 1.0 : 0))
            )
            .edgesIgnoringSafeArea(.all)//表示範囲を指定
            .animation(.easeInOut(duration: 0.25), value: showMenu)
            .onTapGesture {
                if showMenu {
                    showMenu = false
                }
            }
            .gesture(drag)//グレーの背景にDragGesture
            SideMenuView()
            //サイドメニューの幅を表現
                .frame(width: menuWidth, height: geometry.size.height)
            //view表示の際にオフセットしている(サイドメニューの幅分左にずらしている)
                .offset(x: isDrag ? -menuWidth + xPosition : (showMenu ? 0 : -menuWidth))
                .animation(.easeInOut(duration: 0.25), value: showMenu)
                .gesture(drag)//SideMenuViewにDragGesture
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

