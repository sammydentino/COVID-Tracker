//
//  NewsView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 4/23/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI
import WebKit
import URLImage

struct NewsView: View {
    @State private var searchQuery: String = ""
	@ObservedObject var fetch = getNews()
	@State var showingDetail = false
	
	var body: some View {
		VStack(alignment: .leading) {
			List (fetch.news) { item in
				NavigationLink(destination: WebView(request: URLRequest(url: URL(string: item.url)!)).navigationBarTitle(Text(item.title), displayMode: .inline)) {
					VStack (alignment: .leading){
						HStack {
							URLImage(URLRequest(url: URL(string: item.urlToImage)!), delay: 0.25) { proxy in
								proxy.image
									.resizable()
									.aspectRatio(contentMode: .fill)
									.clipped()
									.clipShape(Circle())
							}
							.frame(width: 55, height: 55)
							.padding(EdgeInsets(top: 7.5, leading: 7.5, bottom: 0, trailing: 0))
							Text(item.title)
								.font(.subheadline)
								.bold()
								.lineLimit(3)
								.padding(EdgeInsets(top: 7.5, leading: 7.5, bottom: 0, trailing: 0))
						}
						Spacer()
						Text(item.publication)
							.font(.subheadline)
							.foregroundColor(.gray)
							.bold()
							.padding(EdgeInsets(top: 5, leading: 7.5, bottom: 7.5, trailing: 0))
					}
				}
			}
		}
	}
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

struct WebView : UIViewRepresentable {
    let request: URLRequest
      
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
      
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}

class getNews : ObservableObject {
	@Published var news : [News]!
	
	init() {
		loadNews()
	}
	func loadNews() {
		let urlString = "https://covidtracking.com/api/press"

		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([News].self, from: d) {
					news = data
				}
			}
		}
	}
}

struct News : Codable, Identifiable {
	let id = UUID()
	let title : String!
	let url : String!
	let publication : String!
	var urlToImage: String!
	let publishDate : String!

	enum CodingKeys: String, CodingKey {
		case title = "title"
		case url = "url"
		case publication = "publication"
		case publishDate = "publishDate"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title) ?? "Not Available"
		url = try values.decodeIfPresent(String.self, forKey: .url) ?? "www.google.com"
		publication = try values.decodeIfPresent(String.self, forKey: .publication) ?? "N/A"
		publishDate = try values.decodeIfPresent(String.self, forKey: .publishDate) ?? "N/A"
		urlToImage = "https://www.google.com/s2/favicons?domain_url=" + url
	}
}
