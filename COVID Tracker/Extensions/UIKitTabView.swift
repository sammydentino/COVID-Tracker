//
//  UIKitTabView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 4/27/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import Foundation
import SwiftUI

struct UIKitTabView: View {
    var viewControllers: [UIHostingController<AnyView>]
    @State var selectedIndex: Int = 0
    
    init(_ views: [Tab]) {
        self.viewControllers = views.map {
            let host = UIHostingController(rootView: $0.view)
            host.tabBarItem = $0.barItem
            return host
        }
    }
    
    var body: some View {
        TabBarController(controllers: viewControllers, selectedIndex: $selectedIndex)
            .edgesIgnoringSafeArea(.all)
    }
    
    struct Tab {
        var view: AnyView
        var barItem: UITabBarItem
        
        init<V: View>(view: V, barItem: UITabBarItem) {
            self.view = AnyView(view)
            self.barItem = barItem
        }
        
        // convenience
        init<V: View>(view: V, title: String?, image: String, selectedImage: String? = nil) {
            let selectedImage = selectedImage != nil ? UIImage(named: selectedImage!) : nil
            let barItem = UITabBarItem(title: title, image: UIImage(named: image), selectedImage: selectedImage)
            self.init(view: view, barItem: barItem)
        }
    }
}
