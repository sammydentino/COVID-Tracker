//
//  Banner.swift
//  COVID-19 Data
//
//  Created by Sammy Dentino on 4/19/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import GoogleMobileAds
import SwiftUI
import UIKit

struct AdBanner: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeBanner)
        let viewController = UIViewController()
        view.adUnitID = "ca-app-pub-5348114636143228/9445195007"
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        view.load(GADRequest())
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct Banner:View{
    var body: some View{
        HStack{
            Spacer()
            AdBanner().frame(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height)
            Spacer()
        }
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner()
    }
}
