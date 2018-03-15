//
//  In App Purchase.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 2/3/18.
//  Copyright © 2018 Nathan Standage. All rights reserved.
//

import Foundation
import StoreKit

enum IAPProduct: String {
    case smallTip = "penny.wise.smallTip"
    case mediumTip = "penny.wise.mediumTip"
    case largeTip = "penny.wise.largeTip"
    
}

class IAPService: NSObject {
    
    private override init() {}
    static let shared = IAPService()
    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()
    
    func getProducts() {
        let products: Set = [IAPProduct.smallTip.rawValue,
                             IAPProduct.mediumTip.rawValue,
                             IAPProduct.largeTip.rawValue]
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        paymentQueue.add(self)
    }
    
    func purchase(product: IAPProduct) {
        guard let productToPurchase = products.filter({ $0.productIdentifier == product.rawValue }).first else { return }
        
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)
    }
}

extension IAPService: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
    }
}

extension IAPService: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing: break
            default: queue.finishTransaction(transaction)
            }
        }
    }
}

extension SKPaymentTransactionState {
    func status() -> String {
        switch self {
        case .deferred: return "deferred"
        case .failed: return "failed"
        case .purchased: return "purchased"
        case .purchasing: return "purchasing"
        case .restored: return "restored"
        }
    }
}













