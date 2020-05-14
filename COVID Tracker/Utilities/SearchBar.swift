//
//  SearchBar.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 5/13/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var onSearchButtonClicked: (() -> Void)? = nil
	var placeholder : String? = "Case Sensitive"

    class Coordinator: NSObject, UISearchBarDelegate {

        let control: SearchBar

        init(_ control: SearchBar) {
            self.control = control
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            control.text = searchText
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            control.onSearchButtonClicked?()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
		searchBar.placeholder = placeholder
		searchBar.searchBarStyle = .minimal
        return searchBar
    }
	
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
