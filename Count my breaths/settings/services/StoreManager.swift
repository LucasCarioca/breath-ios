//
// Created by Lucas Desouza on 12/5/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import Foundation
import StoreKit
import SwiftUI

struct StoreManagerKey: EnvironmentKey {
    static let defaultValue = StoreManager()
}

extension EnvironmentValues {
    var storeManager: StoreManager {
        get {
            self[StoreManagerKey.self]
        }
        set {
            self[StoreManagerKey.self] = newValue
        }
    }
}

class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    @Published var myProducts = [SKProduct]()
    @Published var transactionState: SKPaymentTransactionState?
    var request: SKProductsRequest!
    static let productKey = "1001"

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                transactionState = .purchasing
            case .purchased:
                UserDefaults.standard.setValue(true, forKey: StoreManager.productKey)
                queue.finishTransaction(transaction)
                transactionState = .purchased
            case .restored:
                UserDefaults.standard.setValue(true, forKey: StoreManager.productKey)
                queue.finishTransaction(transaction)
                transactionState = .restored
            case .failed, .deferred:
                queue.finishTransaction(transaction)
                transactionState = .failed
            default:
                queue.finishTransaction(transaction)
            }
        }
    }

    func purchaseProduct(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
    }

    func restoreProduct() {
        if SKPaymentQueue.canMakePayments() {
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
    }

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if !response.products.isEmpty {
            for fetchedProduct in response.products {
                DispatchQueue.main.async {
                    self.myProducts.append(fetchedProduct)
                }
            }
        }
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        // TODO: should handle when payment fails here
    }

    func loadProducts(productIDs: [String]) {
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
}
