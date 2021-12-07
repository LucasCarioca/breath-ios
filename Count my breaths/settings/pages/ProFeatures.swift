//
// Created by Lucas Desouza on 12/5/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import SwiftUI
import QuickComponents

struct ProFeatures: View {
    @StateObject var storeManager: StoreManager

    var body: some View {
        if let transactionState = storeManager.transactionState {
            switch transactionState {
            case .purchasing:
                VStack {
                    Text("Processing").Heading(align: .center)
                    LottieView(filename: "payment-loading")
                    Spacer()
                }
            case .purchased:
                VStack {
                    Text("Purchase complete!").Heading(align: .center)
                    Text("Pro features are now enabled. Go back to the main menu to see the new views.").Paragraph(align: .center, size: .MD)
                    LottieView(filename: "payment-confirmation")
                    Spacer()
                }
            case .restored:
                VStack {
                    Text("Purchase complete!").Heading(align: .center)
                    Text("Pro features are now enabled. Go back to the main menu to see the new views.").Paragraph(align: .center, size: .MD)
                    LottieView(filename: "payment-confirmation")
                    Spacer()
                }
            case .failed, .deferred:
                VStack {
                    Text("Purchase failed!").Heading(align: .center)
                    Text("Something went wrong while processing your payment. Please try again.").Paragraph(align: .center, size: .MD)
                    LottieView(filename: "payment-error")
                    Spacer()
                    Button(action: { storeManager.transactionState = nil }) {
                        Text("Try again")
                    }
                            .buttonStyle(SecondaryButton(variant: .contained))
                            .frame(width: 150, height: 75)
                            .padding(.bottom, 50)
                }
            default:
                VStack {
                    LottieView(filename: "payment-loading")
                    Spacer()
                }
            }
        } else {
            #if os(OSX)
            ProFeaturesMacOSTabView(action: initiatePurchase)
            #elseif os(iOS)
            #if targetEnvironment(macCatalyst)
            ProFeaturesMacOSTabView(action: initiatePurchase)
            #else
            ProFeaturesiOSTabView(action: initiatePurchase)
            #endif
            #endif
        }
    }

    func initiatePurchase(restore: Bool = false) {
        if restore {
            storeManager.restoreProduct()
        } else {
            let product = storeManager.myProducts[0]
            storeManager.purchaseProduct(product: product)
        }
    }
}

struct ProFeaturesiOSTabView: View {
    var action: (Bool) -> Void
    var body: some View {
        TabView {
            ProFeaturesPage(
                    title: "Multiple pets",
                    text: "Pro users will now have the ability to add multiple pet profiles to track the health individually.",
                    lottieAnimation: "dog")
            ProFeaturesPage(
                    title: "Members only features",
                    text: "Help fund additional member's only features.",
                    lottieAnimation: "application")
            ProFeaturesCallToAction(action: action)
        }.tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct ProFeaturesMacOSTabView: View {
    var action: (Bool) -> Void
    @State var page = 0
    var body: some View {
        VStack {
            if page == 0 {
                ProFeaturesPage(
                        title: "Multiple pets",
                        text: "Pro users will now have the ability to add multiple pet profiles to track the health individually.",
                        lottieAnimation: "dog")
            } else if page == 1 {
                ProFeaturesPage(
                        title: "Members only features",
                        text: "Help fund additional member's only features.",
                        lottieAnimation: "application")
            } else if page == 2 {
                ProFeaturesCallToAction(action: action)
            }

            HStack {
                if page > 0 {
                    Button(action: { page -= 1 }) {
                        Image(systemName: "chevron.backward")
                    }
                            .buttonStyle(PrimaryButton())
                            .frame(width: 50, height: 50)
                }
                if page < 2 {
                    Button(action: { page += 1 }) {
                        Image(systemName: "chevron.forward")
                    }
                            .buttonStyle(PrimaryButton())
                            .frame(width: 50, height: 50)
                }
            }.padding(.bottom, 50)
        }
    }
}

struct ProFeaturesPage: View {
    var title: String
    var text: String
    var lottieAnimation: String
    var body: some View {
        VStack {
            Text(title).Heading(align: .center, size: .H4)
            Text(text).Paragraph(align: .center, size: .MD)
            Spacer()
            LottieView(filename: lottieAnimation)
            Spacer()
        }
    }
}

struct ProFeaturesCallToAction: View {
    var action: (Bool) -> Void
    var body: some View {
        VStack {
            Text("Upgrade to Pro").Heading(align: .center, size: .H1)
            Text("Get all current pro features and any future pro features by upgrading. Pro membership is valid across all apple devices with a single purchase.").Paragraph(align: .center, size: .MD)
            Spacer()
            LottieView(filename: "rocket")
            Spacer()
            Button(action: {
                action(false)
            }) {
                Text("Upgrade Now")
            }
                    .buttonStyle(PrimaryButton(variant: .contained))
                    .frame(width: 150, height: 75)
            Button(action: {
                action(true)
            }) {
                Text("Restore previous purchase")
            }
                    .buttonStyle(PrimaryButton())
                    .frame(width: .infinity, height: 75)
                    .padding(.bottom, 50)

        }
    }
}
