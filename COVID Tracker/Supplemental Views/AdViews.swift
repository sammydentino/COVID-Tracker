//
//  AdViews.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 5/7/21.
//  Copyright © 2021 Sammy Dentino. All rights reserved.
//

import SwiftUI
import MoPubSDK

struct MoPubBannerView: View {
    let adUnitID: String
    let adSize: CGSize
    
    var body: some View {
        HStack {
            Spacer()
            MoPubBannerViewRepresentable(adUnitID: adUnitID, adSize: adSize)
                .frame(width: adSize.width, height: adSize.height)
            Spacer()
        }.background(Color.clear)
    }
}

struct MoPubBannerViewRepresentable: UIViewRepresentable {
    let adUnitID: String
    let adSize: CGSize
    
    func makeUIView(context: Context) -> MPAdView {
        let moPubBannerView = type(of: MPAdView()).init(adUnitId:adUnitID)!
        
        //adSize needs to be defined with the exact dimensions of the desired ad, ex: 320x50.
        //Only defining the height using  something like kMPPresetMaxAdSize50Height will define a width of 0, causing the ad not to load
        moPubBannerView.frame.size = adSize
        
        moPubBannerView.delegate = context.coordinator
                        
        moPubBannerView.loadAd()
        
        return moPubBannerView
    }
    
    func updateUIView(_ uiView: MPAdView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, MPAdViewDelegate {
        
        private let parent: MoPubBannerViewRepresentable
        
        init(_ mopubView: MoPubBannerViewRepresentable) {
            self.parent = mopubView
        }
        
        func viewControllerForPresentingModalView() -> UIViewController! {
            return  UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        }
        
        //Events from MPAdViewDelegate can go here
        //These can be removed if not used
        func adViewDidLoadAd(_ view: MPAdView!, adSize: CGSize) {
            print("ad loaded with size: \(adSize)")
        }
        
        func adView(_ view: MPAdView!, didFailToLoadAdWithError error: Error!) {
            if let error = error {
                print("failed to load ad with error: \(error)")
            }
        }
        
        func adViewDidFail(toLoadAd view: MPAdView!) {
            print("failed to load ad")
        }
    }
}
