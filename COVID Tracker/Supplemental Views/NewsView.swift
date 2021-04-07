//
//  NewsView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 4/23/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI
import URLImage
import BetterSafariView

struct NewsView: View {
    @State private var searchQuery: String = ""
    let fetch: getAll!
	@State private var showingDetail = false
    @State private var presentingSafariView = false
	
	var body: some View {
        List {
            ForEach(fetch.news, id: \.id) { item in
                Button(action: {
                    presentingSafariView = true
                }) {
                    VStack (alignment: .leading){
                        HStack {
                            URLImage(URLRequest(url: URL(string: item.image)!), delay: 0.25) { proxy in
                                proxy.image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .clipShape(Circle())
                            }
                            .frame(width: 55, height: 55)
                            .padding(EdgeInsets(top: 7.5, leading: 0, bottom: 0, trailing: 5))
                            Text(item.title)
                                .font(.subheadline)
                                .bold()
                                .lineLimit(3)
                                .foregroundColor(.primary)
                                .padding(EdgeInsets(top: 7.5, leading: 0, bottom: 0, trailing: 0))
                        }
                        Spacer()
                        Text(item.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .bold()
                            .lineLimit(3)
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 7.5, trailing: 0))
                    }
                }.sheet(isPresented: $presentingSafariView) {
                    SafariView(
                        url: URL(string: item.url!)!,
                        configuration: SafariView.Configuration(
                            entersReaderIfAvailable: true,
                            barCollapsingEnabled: false
                        )
                    )
                    .preferredBarAccentColor(.white)
                    .preferredControlAccentColor(.accentColor)
                    .dismissButtonStyle(.done)
                }
            }
        }
	}
}
