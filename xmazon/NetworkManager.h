//
//  NetworkManager.h
//  xmazon
//
//  Created by Quentin on 13/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject {
    
}

+ (void) oauthWithType:(NSString*) type
                 param:(NSDictionary*) params
               success:(void (^)())success
               failure:(void (^)())failure;


+ (void) oauthClientCredentialsWithSuccess:(void (^)())success
                                   failure:(void (^)())failure;


+ (void) oauthUserWithUserName:(NSString*) email
                   password:(NSString*) pssword
                   successs:(void (^)())success
                    failure:(void (^)())failure;


+ (void) refreshToken:(NSString*) token type:(NSString*) type
              success:(void (^)())success
              failure:(void (^)())failure;


+ (void) refreshAppToken:(NSString*) token
                 success:(void (^)())success
                 failure:(void (^)())failure;


+ (void) refreshClientToken:(NSString*) token
                    success:(void (^)())success
                    failure:(void (^)())failure;




+ (void) getStoreWithSuccess:(void (^)(id responseObject))success
                     failure:(void (^)())failure;


+ (void) getCategoryWithStoreUid:(NSString*) uid
                         sucess:(void (^)(id responseObject))success
                        failure:(void (^)())failure;


+ (void) requestAppTokenWithMethod:(NSString*) method
                           WithUrl:(NSString*) url
                             param:(NSDictionary*) params
                           success:(void (^)(id responseObject))success
                           failure:(void (^)())failure;

+ (void) requestClientTokenWithMethod:(NSString*) method
                              WithUrl:(NSString*) url
                                param:(NSDictionary*) params
                              success:(void (^)(id responseObject))success
                              failure:(void (^)())failure;

+ (void) requestWithType:(NSString*) type
                  method:(NSString*) method
                     url:(NSString*) url
                   param:(NSDictionary*) params
                 success:(void (^)(id responseObject))success
                 failure:(void (^)())failure;
@end
