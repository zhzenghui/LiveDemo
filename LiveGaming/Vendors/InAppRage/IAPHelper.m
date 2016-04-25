//
//  IAPHelper.m
//  In App Rage
//
//  Created by Ray Wenderlich on 9/5/12.
//  Copyright (c) 2012 Razeware LLC. All rights reserved.
//

// 1
#import "IAPHelper.h"
#import <StoreKit/StoreKit.h>
#import "NSData+Helper.h"


NSString *const IAPHelperProductPurchasedNotification = @"IAPHelperProductPurchasedNotification";

// 2
@interface IAPHelper () <SKProductsRequestDelegate, SKPaymentTransactionObserver>
@end

// 3
@implementation IAPHelper {
    SKProductsRequest * _productsRequest;
    RequestProductsCompletionHandler _completionHandler;
    
    NSSet * _productIdentifiers;
    NSMutableSet * _purchasedProductIdentifiers;
}

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers {
    
    if ((self = [super init])) {
        
        // Store product identifiers
        _productIdentifiers = productIdentifiers;
        
        // Check for previously purchased products
        _purchasedProductIdentifiers = [NSMutableSet set];
//        for (NSString * productIdentifier in _productIdentifiers) {
//            BOOL productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:productIdentifier];
//            if (productPurchased) {
//                [_purchasedProductIdentifiers addObject:productIdentifier];
//                NSLog(@"Previously purchased: %@", productIdentifier);
//            } else {
//                NSLog(@"Not purchased: %@", productIdentifier);
//            }
//        }
        NSLog(@"purchased count: %@", @(_productIdentifiers.count));

        // Add self as transaction observer
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
    }
    return self;
    
}

- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler {
    
    
    // 1
    _completionHandler = [completionHandler copy];
    
    // 2
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
    
}

- (BOOL)productPurchased:(NSString *)productIdentifier {
    return [_purchasedProductIdentifiers containsObject:productIdentifier];
}

- (void)buyProduct:(SKProduct *)product {
    
    NSLog(@"Buying %@...", product.productIdentifier);
    
    SKPayment * payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    NSLog(@"Loaded list of products...");
    _productsRequest = nil;
    
    NSArray * skProducts = response.products;
//    for (SKProduct * skProduct in skProducts) {
//        NSLog(@"Found product: %@ %@ %0.2f",
//              skProduct.productIdentifier,
//              skProduct.localizedTitle,
//              skProduct.price.floatValue);
//    }
    NSLog(@"Found product count: %@", @(response.products.count));

    _completionHandler(YES, skProducts);
    _completionHandler = nil;
    
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
    NSLog(@"Failed to load list of products.");
    _productsRequest = nil;
    
    _completionHandler(NO, nil);
    _completionHandler = nil;
    
}

#pragma mark SKPaymentTransactionOBserver

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction * transaction in transactions) {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    };
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"completeTransaction...");

    // 服务器验证
    [self serverVier:transaction];
//    [self localVerify:transaction];
    
    [self provideContentForProductIdentifier:transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"restoreTransaction...");
    
    [self provideContentForProductIdentifier:transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"failedTransaction...");
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)provideContentForProductIdentifier:(NSString *)productIdentifier {
    
    [_purchasedProductIdentifiers addObject:productIdentifier];
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productIdentifier];
//    [[NSUserDefaults standardUserDefaults] synchronize];

    // 保存购买记录
    [[NSNotificationCenter defaultCenter] postNotificationName:IAPHelperProductPurchasedNotification object:productIdentifier userInfo:nil];
    
}
//

- (void)localVerify:(SKPaymentTransaction *)transaction {
    


//    NSData * = transaction.transactionReceipt; // Sent to the server by the device
    
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSURL *receiptURL = [mainBundle appStoreReceiptURL];
    NSError *receiptError;
    BOOL isPresent = [receiptURL checkResourceIsReachableAndReturnError:&receiptError];
    if (!isPresent) {
        // 验证失败
    }
    
    NSData *receipt = [NSData dataWithContentsOfURL:receiptURL];

    
    // Create the JSON object that describes the request
    NSError *error;
    NSDictionary *requestContents = @{
                                      @"receipt-data": [receipt base64EncodedStringWithOptions:0]
                                      };
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents
                                                          options:0
                                                            error:&error];
    
    if (!requestData) { /* ... Handle error ... */ }
    
    // Create a POST request with the receipt data.
    NSURL *storeURL = [NSURL URLWithString:@"https://sandbox.itunes.apple.com/verifyReceipt"];
    NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:storeURL];
    [storeRequest setHTTPMethod:@"POST"];
    [storeRequest setHTTPBody:requestData];
    
    // Make a connection to the iTunes Store on a background queue.
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:storeRequest queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError) {
                                   /* ... Handle error ... */
                                   NSLog(@"json: %@", @"error");

                               } else {
                                   NSError *error;
                                   NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                   NSLog(@"json: %@", jsonResponse);
                                   if (!jsonResponse) { /* ... Handle error ...*/ }
                                   /* ... Send a response back to the device ... */
                                   int  status = [jsonResponse[@"status"] intValue];
                                   
                                   switch (status) {
                                       case 0:
                                       {
                                           NSLog(@"购买成功");
                                           break;
                                       }
                                       default:
                                           NSLog(@"发生错误");
                                           break;
                                   }
                               }
                           }];

}

- (void)serverVier:(SKPaymentTransaction *)transaction {
    
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.199.104:3000/api/v1/validate"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];

    
    NSString *is_development = @"1";
    
#if DEBUG
    is_development = @"1";
#else
    is_development = @"2";
#endif
    
    
    

    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSURL *receiptURL = [mainBundle appStoreReceiptURL];
    NSError *receiptError;
    BOOL isPresent = [receiptURL checkResourceIsReachableAndReturnError:&receiptError];
    if (!isPresent) {
        // 验证失败
    }
    
    NSData *receipt = [NSData dataWithContentsOfURL:receiptURL];
    
    
    NSString *params = [NSString stringWithFormat:@"receipt_data=%@&is_development=%@", [receipt base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength], is_development];
//    NSLog(@"%@", params);
    
    
    
    NSData *httpBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:httpBody];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                               if (httpResponse.statusCode == 200) {
                                   id receipt = [NSJSONSerialization JSONObjectWithData:data
                                                                                options:0
                                                                                  error:nil];
                                   NSLog(@"Received receipt: %@", receipt);
                                   
                                   int  status = [receipt[@"status"] intValue];
 
                                   NSLog( @"%@", receipt[@"status"]  );
                                   switch (status) {
                                       case 200:
                                       {
                                           NSLog(@"购买成功");
                                           break;
                                       }
                                       default:
                                           NSLog(@"发生错误");
                                           break;
                                   }
//
                               } else {
                                   NSLog(@"Body: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                   NSLog(@"ERROR: %@", error);
                               }
                           }];
    
    
    
}

- (void)restoreCompletedTransactions {
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

@end