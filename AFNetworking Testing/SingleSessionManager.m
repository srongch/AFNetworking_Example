//
//  SingleSessionManager.m
//  anyPay
//
//  Created by Chhem Sronglong on 17/10/2017.
//  Copyright © 2017 MPARK. All rights reserved.
//

#import "SingleSessionManager.h"

@implementation SingleSessionManager

+ (SingleSessionManager *)sharedManager {
    static SingleSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        manager = [[self alloc] initWithSessionConfiguration:configuration];
        manager.securityPolicy.allowInvalidCertificates=YES;
        manager.securityPolicy.validatesDomainName=NO;
        manager.responseSerializer.acceptableContentTypes =
        [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];

        
    });
    return manager;
}

@end
