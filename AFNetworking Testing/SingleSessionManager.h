//
//  SingleSessionManager.h
//  anyPay
//
//  Created by Chhem Sronglong on 17/10/2017.
//  Copyright © 2017 MPARK. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface SingleSessionManager : AFHTTPSessionManager
+ (SingleSessionManager *)sharedManager;
@end
