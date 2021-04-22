//
//  AboutKit.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 4/17/21.
//  Copyright © 2021 Sammy Dentino. All rights reserved.
//

import SwiftUI
import MessageUI

public struct AKApp {
    // The app ID string for the given app. This can be found in App Store Connect or the URL of the App Store listing
    // for the app. This should  be in the format 123456789.
    public let id: String

    // The app name string.
    public let name: String

    // An optional app icon UIImage. If an image is not specified, the app icon will be fetched from the App Store.
    public let appIcon: UIImage?

    // A custom struct container details about the developer of the app.
    public let developer: AKDeveloper

    // The email address to contact the app's support as a string.
    public let email: String

    // An optional Twitter profile handle string for the app. This should be in the format SampleApp without the @.
    public let twitterHandle: String?

    // A URL string directing to the app's website.
    public let websiteURL: String

    // An optional URL string directing to the privacy policy for the app.
    public let privacyPolicyURL: String?

    // Initializes a custom struct of data pertaining to the specified app.
    // - Parameters:
    //   - id: The app ID string for the given app. This can be found in App Store Connect or the URL of the App Store listing
    //   for the app. This should  be in the format 123456789.
    //   - name: The app name string.
    //   - email: The email address to contact the app's support as a string.
    //   - appIcon: An optional app icon UIImage. If an image is not specified, the app icon will be fetched from the App Store.
    //   - developer: A custom struct container details about the developer of the app.
    //   - twitterHandle: An optional Twitter profile handle string for the app. This should be in the format SampleApp without the @.
    //   - privacyPolicyURL: An optional URL string directing to the privacy policy for the app.
    //   - websiteURL: A URL string directing to the app's website.
    public init(id: String, name: String, appIcon: UIImage?, developer: AKDeveloper, email: String, twitterHandle: String?, websiteURL: String, privacyPolicyURL: String?) {
        self.id = id
        self.name = name
        self.appIcon = appIcon
        self.developer = developer
        self.email = email
        self.twitterHandle = twitterHandle
        self.websiteURL = websiteURL
        self.privacyPolicyURL = privacyPolicyURL
    }
    
    static let example = AKApp(
        id: "123456789",
        name: "Sample",
        appIcon: nil,
        developer: AKDeveloper.example,
        email: "sampleapp@example.com",
        twitterHandle: "SampleApp",
        websiteURL: "https://www.example.com",
        privacyPolicyURL: "https://www.example.com/privacy-policy"
    )
}

public struct AKOtherApp: Identifiable {
    // The app ID string for the given app. This can be found in App Store Connect or the URL of the App Store listing for the app. This should be in the format 123456789.
    public let id: String

    // The app name string.
    public let name: String

    // Initializes a custom struct of data to create a promoted other app list item.
    // - Parameters:
    //   - id: The app ID string for the given app. This can be found in App Store Connect or the URL of the App Store listing for the app. This should be in the format 123456789.
    //   - name: The app name string.
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    static let example = AKOtherApp(
        id: "987654321",
        name: "Other App"
    )
}

public struct AKDeveloper {
    // The developer ID string for the given developer. This can be found by locating the App Store URL for the developer. This should be in the format 123456789.
    public let id: String

    // The name of the developer as a string.
    public let name: String

    // An optional Twitter profile handle string for the developer. This should be in the format SampleDeveloper without the @.
    public let twitterHandle: String?

    // Initializes a custom struct of data pertaining to developer of an app.
    // - Parameters:
    //   - id: The developer ID string for the given developer. This can be found by locating the App Store URL for the developer. This should be in the format 123456789.
    //   - name: The name of the developer as a string.
    //   - twitterHandle: An optional Twitter profile handle string for the developer. This should be in the format SampleDeveloper without the @.
    public init(id: String, name: String, twitterHandle: String?) {
        self.id = id
        self.name = name
        self.twitterHandle = twitterHandle
    }
    
    static let example = AKDeveloper(
        id: "123456789",
        name: "App Developer",
        twitterHandle: "AppDeveloper"
    )
}

public struct AboutAppWithNavigationView: View {
    // A custom struct containing details about the current app.
    private let app: AKApp

    // An array of custom structs that contain details about other apps the developer owns.
    private let otherApps: [AKOtherApp]

    // The type of navigation title to show.
    private let titleDisplayMode: NavigationBarItem.TitleDisplayMode
    
    @Environment(\.presentationMode) var presentationMode

    // Initializes a new SwiftUI view with navigation bar that displays attributes and links relating to an app.
    // - Parameters:
    //   - app: A custom struct containing details about the current app.
    //   - otherApps: An array of custom structs that contain details about other apps the developer owns.
    //   - titleDisplayMode: The type of navigation title to show. Defaults to inline.
    public init(
        app: AKApp,
        otherApps: [AKOtherApp],
        titleDisplayMode: NavigationBarItem.TitleDisplayMode = .inline
    ) {
        self.app = app
        self.otherApps = otherApps
        
        self.titleDisplayMode = titleDisplayMode
    }
    
    private var doneToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button("Done", action: dismiss)
        }
    }
    
    public var body: some View {
        NavigationView {
            AboutAppView(app: app, otherApps: otherApps)
                .navigationBarTitle("About", displayMode: titleDisplayMode)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

// A SwiftUI view which displays attributes and links relating to an app.
public struct AboutAppView: View {
    // A custom struct containing details about the current app.
    private let app: AKApp

    // An array of custom structs that contain details about other apps the developer owns.
    private let otherApps: [AKOtherApp]
    
    private enum ActiveSheet: Identifiable {
        case mail, share
        var id: Int { hashValue }
    }
    
    @State private var activeSheet: ActiveSheet?

    private var appReviewURL: String {
        "https://apps.apple.com/us/app/id\(app.id)?action=write-review"
    }

    private var developerURL: String {
        "https://apps.apple.com/us/developer/id\(app.developer.id)"
    }

    private var debugDetails: String {
        "\n\n\nDEBUG DETAILS\n\nApp Version: \(Bundle.main.versionNumber) (\(Bundle.main.buildNumber))\niOS Version: \(UIDevice.current.systemVersion)"
    }

    // Initializes a new SwiftUI view which displays attributes and links relating to an app.
    // - Parameters:
    //   - app: A custom struct containing details about the current app.
    //   - otherApps: An array of custom structs that contain details about other apps the developer owns.
    public init(app: AKApp, otherApps: [AKOtherApp]) {
        self.app = app
        self.otherApps = otherApps
    }
    
    public var body: some View {
        List {
            Section(header: Text("\n").padding(.top, -15)) {
                HeaderView(app: app)
                    .listRowBackground(Color(UIColor.systemGroupedBackground))
            }
            
            Section(header: Text("   Contact Me").subhead().fixCase()) {
                Button(action: sendMail) {
                    HStack(spacing: 15) {
                        Image(systemName: "envelope")
                            .resizable()
                            .frame(width: 40, height: 30.0)
                            .padding(.horizontal, 7.5)
                            .padding(.trailing, 2.5)
                        Text("Email")
                            .font(.headline)
                        Spacer(minLength: 1)
                        Text("SEND")
                            .font(.headline)
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .foregroundColor(.accentColor)
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                            .background(Color(UIColor.systemGroupedBackground))
                            .clipShape(Capsule())
                            .contentShape(Capsule())
                            .hoverEffect(.lift)
                            .layoutPriority(1)
                    }.padding(.vertical)
                }.buttonStyle(PlainButtonStyle())
            }

            if otherApps.isEmpty == false {
                Section(header: Text("   App Store Apps").subhead().fixCase()) {
                    ForEach(otherApps, content: OtherAppRowView.init)
                    //Link("View All", destination: URL(string: developerURL)!)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .sheet(item: $activeSheet) { (item) in
            switch item {
            case .mail:
                MailView(app: app, debugDetails: debugDetails)
                    .edgesIgnoringSafeArea(.all)
                
            case .share:
                ShareSheetView(app: app)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    private func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            activeSheet = .mail
        } else {
            guard let subject = app.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
                  let body = debugDetails.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }

            let urlString = "mailto:info@sammydentino@hackermail.com?subject=\(subject)%20-%20Support&body=\(body)"

            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
    }

    private func getTwitterDetails(for handle: String?) -> (title: String, url: URL)? {
        if let handle = handle,
           let url = URL(string: "https://twitter.com/\(handle)") {
            let title = "Twitter (\(handle))"

            return (title, url)
        }

        return nil
    }
    
    private func showShareSheet() {
        activeSheet = .share
    }
}

extension Bundle {
    // Returns a string with the current app version number e.g. 1.0.
    var versionNumber: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    // Returns a string with the current app build number e.g. 1.
    var buildNumber: String {
        infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
}

struct MailView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode

    // The app to use for providing data to show in the mail sheet.
    private let app: AKApp

    // A string containing some debug information that will be sent to the developer.
    private let debugDetails: String

    // Initializes a UIViewControllerRepresentable that shows the default iOS mail sheet
    // with some pre-configured fields based on the current app.
    // - Parameters:
    //   - app: The app to use for providing data to show in the mail sheet.
    //   - debugDetails: A string containing some debug information that will be sent to the developer.
    init(app: AKApp, debugDetails: String) {
        self.app = app
        self.debugDetails = debugDetails
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var presentationMode: PresentationMode
        
        init(presentationMode: Binding<PresentationMode>) {
            _presentationMode = presentationMode
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            $presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let mailComposerViewController = MFMailComposeViewController()
        mailComposerViewController.mailComposeDelegate = context.coordinator
        
        mailComposerViewController.setToRecipients([app.email])
        mailComposerViewController.setSubject("\(app.name) - Support")
        mailComposerViewController.setMessageBody(debugDetails, isHTML: false)
        
        return mailComposerViewController
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {}
}

struct ShareSheetView: UIViewControllerRepresentable {
    // The app to use for showing in the download message.
    private let app: AKApp

    // Initializes a UIViewControllerRepresentable that shows the default iOS share sheet
    // with some details on how to install the current app.
    // - Parameter app: The app to use for showing in the download message.
    init(app: AKApp) {
        self.app = app
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheetView>) -> UIActivityViewController {
        let appURL = URL(string: "https://apps.apple.com/us/app/id\(app.id)")!
        let message = "Check out \(app.name) on the App Store!"
        
        let activityViewController = UIActivityViewController(activityItems: [appURL, message], applicationActivities: nil)
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareSheetView>) {}
}

struct HeaderView: View {
    let app: AKApp

    @State private var appIconURL: String?

    private var appIcon: some View {
        ZStack {
            Color.systemGroupedBackground

            if let appIcon = app.appIcon {
                Image(uiImage: appIcon)
                    .resizable()
                    .scaledToFit()

            } else if let appIconURL = appIconURL {
                RemoteImageView(url: appIconURL)
            }
        }
        .frame(width: 100, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .accessibilityLabel(appIconLabel)
    }

    private var appIconLabel: String {
        "\(app.name) App Icon"
    }
    
    var body: some View {
        VStack {
            appIcon

            Text("\(app.name) v\(Bundle.main.versionNumber)")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.top)

            Text(app.developer.name)
                .subhead()
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.vertical, 5)
        }
        .frame(maxWidth: .infinity)
        .onAppear(perform: loadAppIcon)
    }

    private func loadAppIcon() {
        if app.appIcon == nil {
            AppIconNetworkManager.shared.getURL(for: app.id) { (appIconURL) in
                DispatchQueue.main.async {
                    self.appIconURL = appIconURL
                }
            }
        }
    }
}

final class AppIconNetworkManager {
    // Creates the singleton object.
    static let shared = AppIconNetworkManager()

    // Creates the cache object for storing the app icon URL.
    private let cache = NSCache<NSString, NSString>()

    // Gets the app icon URL string for a given app ID>
    // - Parameters:
    //   - appID: The app ID string of the app to retrieve the app icon for.
    //   - completion: A completion block containing an optional string if a url value is found during the request.
    func getURL(for appID: String, completion: @escaping (String?) -> Void) {
        let urlString = "https://itunes.apple.com/lookup?id=\(appID)"
        let cacheKey = NSString(string: urlString)
        
        guard let url = URL(string: urlString) else { return }
        
        if let cachedImageURL = cache.object(forKey: cacheKey) {
            completion(cachedImageURL as String)
            return
            
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil, let data = data else {
                    completion(nil)
                    return
                }
                
                if let decodedResponse = try? JSONDecoder().decode(AppResponse.self, from: data),
                   let appIconURL = decodedResponse.results.first?.appIcon {
                    self.cache.setObject(NSString(string: appIconURL), forKey: cacheKey)
                    completion(appIconURL)
                    
                } else {
                    completion(nil)
                }
                
            }.resume()
        }
    }

    // A custom struct containing the results from the request.
    struct AppResponse: Codable {
        let results: [AppResult]
    }

    // A custom struct containing the appIcon URL string in the result.
    struct AppResult: Codable {
        let appIcon: String
        
        enum CodingKeys: String, CodingKey {
            case appIcon = "artworkUrl512"
        }
    }
}

struct RemoteImageView: View {
    private enum LoadState {
        case loading, success, failure
    }
    
    @StateObject private var imageLoader: RemoteImageLoader
    
    private var downloadedImage: Image {
        switch imageLoader.loadState {
        case .loading, .failure:
            return Image(uiImage: UIImage())
        case .success:
            return Image(uiImage: imageLoader.image ?? UIImage())
        }
    }
    
    init(url: String) {
        _imageLoader = StateObject(wrappedValue: RemoteImageLoader(url: url))
    }
    
    var body: some View {
        downloadedImage.resizable()
    }
    
    private class RemoteImageLoader: ObservableObject {
        var image: UIImage?
        var loadState = LoadState.loading
        
        private let cache = NSCache<NSString, UIImage>()
        
        init(url: String) {
            guard let imageURL = URL(string: url) else { return }
            
            let cacheKey = NSString(string: url)
            
            if let cachedImage = cache.object(forKey: cacheKey) {
                self.image = cachedImage
                self.loadState = .success
                
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
                
            } else {
                URLSession.shared.dataTask(with: imageURL) { data, response, error in
                    guard error == nil,
                          let data = data,
                          let image = UIImage(data: data) else {
                        self.loadState = .failure
                        return
                    }
                    
                    self.image = image
                    self.loadState = .success
                    
                    self.cache.setObject(image, forKey: cacheKey)
                    
                    DispatchQueue.main.async {
                        self.objectWillChange.send()
                    }
                    
                }.resume()
            }
        }
    }
}

struct OtherAppRowView: View {
    let otherApp: AKOtherApp
    @State private var appIconURL: String?

    private var appIcon: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)

            if let appIconURL = appIconURL {
                RemoteImageView(url: appIconURL)
            }
        }
        .frame(width: 60, height: 60)
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(appIconLabel)
    }

    private var appIconLabel: String {
        "\(otherApp.name) App Icon"
    }

    private var viewLabel: String {
        "View \(otherApp.name) in the App Store"
    }

    private var appURL: String {
        "https://apps.apple.com/us/app/id\(otherApp.id)"
    }

    private var viewOnAppStoreButton: some View {
        Link(destination: URL(string: appURL)!) {
            Text("VIEW")
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(1)
                .foregroundColor(.accentColor)
                .padding(.vertical, 5)
                .padding(.horizontal)
                .background(Color(UIColor.systemGroupedBackground))
                .clipShape(Capsule())
                .contentShape(Capsule())
                .hoverEffect(.lift)
                .layoutPriority(1)
                .accessibilityLabel(viewLabel)
        }
    }

    var body: some View {
        HStack(spacing: 15) {
            appIcon

            Text(otherApp.name)
                .font(.headline)
                .lineLimit(2)

            Spacer(minLength: 1)

            viewOnAppStoreButton
        }
        .padding(.vertical, 8)
        .buttonStyle(PlainButtonStyle())
        .onAppear(perform: loadAppIcon)
    }

    private func loadAppIcon() {
        AppIconNetworkManager.shared.getURL(for: otherApp.id) { (appIconURL) in
            DispatchQueue.main.async {
                self.appIconURL = appIconURL
            }
        }
    }
}
