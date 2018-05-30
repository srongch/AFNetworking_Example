#import "APIManager.h"
#import "SingleSessionManager.h"


@implementation APIManager


static NSString *serverPrefix = @"http://206.189.145.92:8080/dtalk/api/";
//static NSString *serverPrefix = @"http://localhost:8081/api/";


+(NSURLSessionDataTask *)callAPIServer:(NSString *)url callback:(void (^)(NSDictionary *, id userData, NSError *))callback param:(NSMutableDictionary *)param enabledInteraction:(BOOL)isEnabled{
    return [APIManager callAPI:url andPrefix:serverPrefix callback:callback param:param userdata:nil andUserInteraction:isEnabled];
}


+ (NSURLSessionDataTask *) callAPI:(NSString *)url andPrefix:(NSString *)prefix callback:(void (^)(NSDictionary *, id, NSError *))callback param:(NSMutableDictionary *)param userdata:(id)userdata andUserInteraction:(BOOL)isEnabled{

    if(!isEnabled)
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];

    if(!param) param = [[NSMutableDictionary alloc] init];

    NSString *fullUrl = [NSString stringWithFormat:@"%@%@", prefix, url];
    

    NSURLSessionDataTask *dataTask = [[SingleSessionManager sharedManager] POST:fullUrl
                                    parameters:param
                                    progress:nil
                                    success:^(NSURLSessionDataTask *task, id json) {
                                        if(callback) {
                                            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                                callback([NSDictionary dictionaryWithDictionary:json], userdata, nil);
                                        }
                                    }
                                    failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        if(callback) {
                                            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                            callback([NSDictionary new], userdata, error);
                                        }
                                    }];

    [dataTask resume];
    return dataTask;
}


@end
