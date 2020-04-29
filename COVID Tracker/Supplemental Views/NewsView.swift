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
			SearchBar(text: self.$searchQuery, placeholder: "Case Sensitive").padding(8)
			List (fetch.news.articles) { item in
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
							.frame(width: 60, height: 60)
							.padding(EdgeInsets(top: 7.5, leading: 7.5, bottom: 0, trailing: 0))
							Text(item.title)
								.font(.subheadline)
								.bold()
								.lineLimit(3)
								.padding(EdgeInsets(top: 7.5, leading: 7.5, bottom: 0, trailing: 0))
						}
						Spacer()
					}
				}
				/*Button(action: {
					self.showingDetail.toggle()
				}) {
					VStack (alignment: .leading){
						HStack {
							URLImage(URLRequest(url: URL(string: item.urlToImage)!), delay: 0.25) { proxy in
								proxy.image
									.resizable()
									.aspectRatio(contentMode: .fill)
									.clipped()
									.clipShape(Circle())
							}
							.frame(width: 60, height: 60)
							.padding(EdgeInsets(top: 7.5, leading: 7.5, bottom: 0, trailing: 0))
							Text(item.title)
								.font(.subheadline)
								.bold()
								.lineLimit(3)
								.padding(EdgeInsets(top: 7.5, leading: 7.5, bottom: 0, trailing: 0))
						}
						Spacer()
					}
				}.sheet(isPresented: self.$showingDetail) {
					NavigationView {
						 WebView(request: URLRequest(url: URL(string: item.url)!)).navigationBarTitle(Text(item.title), displayMode: .inline)
					}
				}*/
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
	@Published var news : News!
	
	init() {
		loadNews()
	}
	func loadNews() {
		let urlString = "https://newsapi.org/v2/everything?q=COVID-19&sortBy=publishedAt&language=en&apiKey=d892aab794d64e4899eb9f61129167ed&pageSize=100&page=1"
		
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode(News.self, from: d) {
					news = data
				}
			}
		}
	}
}

struct News : Codable {
	let status : String!
	let totalResults : Int!
	let articles : [Articles]!

	enum CodingKeys: String, CodingKey {
		case status = "status"
		case totalResults = "totalResults"
		case articles = "articles"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
		articles = try values.decodeIfPresent([Articles].self, forKey: .articles)
	}
}

struct Articles : Codable, Identifiable {
	let id = UUID()
	let source : Source!
	let author : String!
	let title : String!
	let description : String!
	let url : String!
	let urlToImage : String!
	let publishedAt : String?
	let content : String?

	enum CodingKeys: String, CodingKey {
		case source = "source"
		case author = "author"
		case title = "title"
		case description = "description"
		case url = "url"
		case urlToImage = "urlToImage"
		case publishedAt = "publishedAt"
		case content = "content"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		source = try values.decodeIfPresent(Source.self, forKey: .source)
		author = try values.decodeIfPresent(String.self, forKey: .author) ?? "N/A"
		title = try values.decodeIfPresent(String.self, forKey: .title) ?? "N/A"
		description = try values.decodeIfPresent(String.self, forKey: .description) ?? "N/A"
		url = try values.decodeIfPresent(String.self, forKey: .url) ?? "https://www.google.com/"
		urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage) ?? "https://www.google.com/"
		publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
		content = try values.decodeIfPresent(String.self, forKey: .content)
	}
}

struct Source : Codable {
	let id : String?
	let name : String!

	enum CodingKeys: String, CodingKey {
		case id = "id"
		case name = "name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
	}
}
