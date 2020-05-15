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
	@ObservedObject private var fetch = getNews()
	@State private var showingDetail = false
	
	var body: some View {
		VStack(alignment: .leading) {
			List (fetch.news2) { item in
				NavigationLink(destination: WebView(request: URLRequest(url: URL(string: item.url)!)).navigationBarTitle(Text(item.title), displayMode: .inline)) {
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
							.padding(EdgeInsets(top: 7.5, leading: 7.5, bottom: 0, trailing: 0))
							Text(item.title)
								.font(.subheadline)
								.bold()
								.lineLimit(3)
								.padding(EdgeInsets(top: 7.5, leading: 7.5, bottom: 0, trailing: 0))
						}
						Spacer()
						Text(item.description)
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

struct TwitterView: View {
    @State private var searchQuery: String = ""
	@ObservedObject private var fetch = getNews()
	@State private var showingDetail = false
	
	var body: some View {
		VStack(alignment: .leading) {
			List (fetch.tweets.message.tweets) { item in
				NavigationLink(destination: WebView(request: URLRequest(url: URL(string: item.url)!)).navigationBarTitle(Text(item.full_text), displayMode: .inline)) {
					VStack (alignment: .leading){
						Text(item.full_text)
						.font(.subheadline)
						.bold()
						.lineLimit(3)
						.padding(EdgeInsets(top: 7.5, leading: 7.5, bottom: 0, trailing: 0))
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
	@Published var news2: [News2]!
	@Published var tweets: Twitter!
	
	init() {
		//loadNews()
		loadNews2()
		//loadTwitter()
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
	func loadNews2() {
		let urlString = "https://api.currentsapi.services/v1/search?keywords=Coronavirus&apiKey=I6_B_W8rEFe9iX7zxWF2La-Nc50WGQWLZWrU0hogorm-66le"

		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode(Results.self, from: d) {
					news2 = data.news
				}
			}
		}
	}
	func loadTwitter() {
		let urlString = "https://covid19-us-api.herokuapp.com/twitter"

		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode(Twitter.self, from: d) {
					tweets = data
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

struct Results : Codable {
	let status : String?
	let news : [News2]!
	let page : Int?

	enum CodingKeys: String, CodingKey {
		case status = "status"
		case news = "news"
		case page = "page"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		news = try values.decodeIfPresent([News2].self, forKey: .news)
		page = try values.decodeIfPresent(Int.self, forKey: .page)
	}
}

struct News2 : Codable, Identifiable {
	let id = UUID()
	let title : String!
	let description : String!
	let url : String!
	let author : String!
	let image : String!
	let language : String?
	let category : [String]?
	let published : String?

	enum CodingKeys: String, CodingKey {
		//case id = "id"
		case title = "title"
		case description = "description"
		case url = "url"
		case author = "author"
		case image = "image"
		case language = "language"
		case category = "category"
		case published = "published"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		//id = try values.decodeIfPresent(String.self, forKey: .id)
		title = try values.decodeIfPresent(String.self, forKey: .title) ?? "N/A"
		description = try values.decodeIfPresent(String.self, forKey: .description) ?? "N/A"
		url = try values.decodeIfPresent(String.self, forKey: .url) ?? "https://www.google.com"
		author = try values.decodeIfPresent(String.self, forKey: .author) ?? "N/A"
		image = try values.decodeIfPresent(String.self, forKey: .image) ?? "https://www.google.com"
		language = try values.decodeIfPresent(String.self, forKey: .language) ?? "N/A"
		category = try values.decodeIfPresent([String].self, forKey: .category) ?? ["N/A"]
		published = try values.decodeIfPresent(String.self, forKey: .published) ?? "N/A"
	}
}

struct Twitter: Codable {
	let success : Bool?
	let message : Message!

	enum CodingKeys: String, CodingKey {
		case success = "success"
		case message = "message"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
		message = try values.decodeIfPresent(Message.self, forKey: .message)
	}
}

struct Message : Codable {
	let username : String!
	let full_name : String!
	let tweets : [Tweets]!

	enum CodingKeys: String, CodingKey {
		case username = "username"
		case full_name = "full_name"
		case tweets = "tweets"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		username = try values.decodeIfPresent(String.self, forKey: .username) ?? "N/A"
		full_name = try values.decodeIfPresent(String.self, forKey: .full_name) ?? "N/A"
		tweets = try values.decodeIfPresent([Tweets].self, forKey: .tweets)
	}
}

struct Tweets : Codable, Identifiable {
	let id = UUID()
	let tweet_id : String!
	let full_text : String!
	let created_at : String!
	let url: String!

	enum CodingKeys: String, CodingKey {
		case tweet_id = "tweet_id"
		case full_text = "full_text"
		case created_at = "created_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		tweet_id = try values.decodeIfPresent(String.self, forKey: .tweet_id) ?? "0"
		full_text = try values.decodeIfPresent(String.self, forKey: .full_text) ?? "N/A"
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at) ?? "N/A"
		url = "https://mobile.twitter.com/user/status/" + tweet_id
	}
}
