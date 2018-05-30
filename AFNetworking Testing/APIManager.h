//
//  APIManager.h
//  trunk
//
//  Created by Jason Park on 2016. 7. 4..
//  Copyright © 2016년 Jason Park. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject


+ (NSURLSessionDataTask *) callAPIServer:(NSString *)url callback:(void(^)(NSDictionary *response, id userData,  NSError *error))callback param:(NSMutableDictionary *)param enabledInteraction:(BOOL)isEnabled;


@end
