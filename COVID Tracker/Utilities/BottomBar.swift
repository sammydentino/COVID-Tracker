//
//  BottomBar.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 4/9/21.
//  Copyright © 2021 Sammy Dentino. All rights reserved.
//

import SwiftUI

public struct BottomBar : View {
    @Binding public var selectedIndex: Int
    
    public let items: [BottomBarItem]
    
    public init(selectedIndex: Binding<Int>, items: [BottomBarItem]) {
        self._selectedIndex = selectedIndex
        self.items = items
    }
    
    func itemView(at index: Int) -> some View {
        Button(action: {
            withAnimation { self.selectedIndex = index }
        }) {
            BottomBarItemView(isSelected: index == selectedIndex, item: items[index])
        }
    }
    
    public var body: some View {
        ZStack {
            BlurView2(style: .light).frame(height: 65)
            HStack(alignment: .center) {
                self.itemView(at: 0)
                Spacer()
                self.itemView(at: 1)
                Spacer()
                self.itemView(at: 2)
                Spacer()
                self.itemView(at: 3)
                Spacer()
                self.itemView(at: 4)
            }.padding([.horizontal]).animation(.default).padding(.bottom,0).padding(.top,0)
        }
    }
}

public struct BottomBarItem {
    public let icon: String
    
    public init(icon: String) {
        self.icon = icon
    }
}

public struct BottomBarItemView: View {
    public let isSelected: Bool
    public let item: BottomBarItem
    
    public var body: some View {
        HStack {
            Image(systemName: item.icon)
                .imageScale(.large)
                .foregroundColor(isSelected ? Color.white : .primary)
                
        }
        .padding(10)
        .background(
            (Color.primary.opacity(isSelected ? 1.0 : 0)).cornerRadius(20)
        )
    }
}

struct BlurView2: UIViewRepresentable {

    let style: UIBlurEffect.Style

    func makeUIView(context: UIViewRepresentableContext<BlurView2>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            ])
        return view
    }

    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView2>) {

    }
}

