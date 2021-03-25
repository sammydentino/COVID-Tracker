//
//  NewsView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 4/23/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI
import URLImage

struct NewsView: View {
    @State private var searchQuery: String = ""
    let fetch: getAll!
	@State private var showingDetail = false
	
	var body: some View {
        List {
            Section(header: Text("\n").font(.system(size: 0.5)).scaleEffect(0.5)) {
                ForEach(fetch.news) { item in
                    NavigationLink(destination: WebView(request: URLRequest(url: URL(string: item.url)!)).edgesIgnoringSafeArea(.bottom).navigationBarTitle(Text(item.title), displayMode: .inline)) {
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
                    }
                }
            }
        }.fixList()
	}
}
