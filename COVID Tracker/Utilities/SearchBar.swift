//
//  SearchBar.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 5/13/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")

                TextField("", text: $text)
                    .foregroundColor(.primary)

                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }.padding(7.5).foregroundColor(.secondary).background(Color(.secondarySystemBackground)).cornerRadius(10.0)
        }.padding(10)
    }
}
