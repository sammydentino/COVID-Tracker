//
//  HalfModalViews.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 4/9/21.
//  Copyright © 2021 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct BottomSheetModal<Content: View>: View {
    private let modalHeight: CGFloat = 360
    private let modalWidth: CGFloat = UIScreen.main.bounds.width
    private let modalCornerRadius: CGFloat = 10
    private let backgroundOpacity = 0.65
    private let dragIndicatorVerticalPadding: CGFloat = 20
    
    @State private var offset = CGSize.zero
    @Binding var display: Bool
    
    var content: () -> Content
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if display {
                background
                modal
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private var background: some View {
        Color.black
            .fillParent()
            .opacity(backgroundOpacity)
            .animation(.spring())
    }
    
    private var modal: some View {
        VStack {
            indicator
            self.content()
        }
        .frame(width: modalWidth, height: modalHeight, alignment: .top)
        .background(Color.white)
        .cornerRadius(modalCornerRadius)
        .offset(y: offset.height)
        .gesture(
            DragGesture()
                .onChanged { value in self.onChangedDragValueGesture(value) }
                .onEnded { value in self.onEndedDragValueGesture(value) }
        )
        .transition(.move(edge: .bottom)).animation(.easeInOut(duration: 0.5))
    }
    
    private var indicator: some View {
        DragIndicator()
            .padding(.vertical, dragIndicatorVerticalPadding)
    }
    
    private func onChangedDragValueGesture(_ value: DragGesture.Value) {
        guard value.translation.height > 0 else { return }
        self.offset = value.translation
    }
    
    private func onEndedDragValueGesture(_ value: DragGesture.Value) {
        guard value.translation.height >= self.modalHeight / 2 else {
            self.offset = CGSize.zero
            return
        }
        
        withAnimation {
            self.offset = CGSize.zero
            self.display.toggle()
        }
    }
}

struct DragIndicator: View {
    private let cornerRadius: CGFloat = 4
    
    var body: some View {
        Rectangle()
            .fill(Color.black)
            .frame(width: UIScreen.screenWidth / 10, height: 6)
            .cornerRadius(cornerRadius)
    }
}

public extension View {
    func fillParent(alignment: Alignment = .center) -> some View {
        self
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: alignment
            )
    }
}

