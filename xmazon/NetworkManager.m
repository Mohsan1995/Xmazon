//
//  NetworkManager.m
//  xmazon
//
//  Created by Quentin on 13/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking/AFNetworking.h"
#import "AFOAuth2Manager/AFOauth2Manager.h"

NSString * const BASE_URL = @"http://xmazon.appspaces.fr";

@implementation NetworkManager

+ (void) oauthWithType:(NSString*) type
                 param:(NSDictionary*) params
               success:(void (^)())success
               failure:(void (^)())failure {
    NSLog(@"oauth type:%@  param:%@", type, params);
    NSURL *baseURL = [NSURL URLWithString:BASE_URL];
    AFOAuth2Manager *OAuth2Manager = [[AFOAuth2Manager alloc] initWithBaseURL:baseURL
                                                                     clientID:@"b3e039df-39a9-4b89-8467-499bed101fd9"
                                                                       secret:@"27542b4d359fffcbf8a9de29e97788d4d5c609ca"];
    [OAuth2Manager authenticateUsingOAuthWithURLString:@"oauth/token"
                                            parameters:params
                                               success:^(AFOAuthCredential *credential) {
                                                   NSUserDefaults* defaults = [[NSUserDefaults alloc] init];
                                                   NSDictionary* token = @{
                                                                           @"access_token": credential.accessToken,
                                                                           @"refresh_token": credential.refreshToken
                                                                           };
                                                   [defaults setObject:token forKey:type];
                                                   NSLog(@"oauth %@ RequestSuccess token:%@", type, token);
                                                   success();
                                               }
                                               failure:^(NSError *error) {
                                                   NSLog(@"oauth %@ RequestError error:%@", type, error);
                                                   failure();
                                               }];
}

+ (void) oauthClientCredentialsWithSuccess:(void (^)())success
                                   failure:(void (^)())failure {
    [self oauthWithType:@"app_token" param:@{@"grant_type":@"client_credentials"} success: success failure: failure];
}

+ (void) oauthUserWithUserName:(NSString*) email
                   password:(NSString*) password
                   successs:(void (^)())success
                    failure:(void (^)())failure {
    [self oauthWithType:@"client_token" param:@{@"grant_type":@"password", @"username": email, @"password": password} success: success failure: failure];
}

+ (void) refreshToken:(NSString*) token type:(NSString*) type
              success:(void (^)())success
              failure:(void (^)())failure {
    NSLog(@"refreshToken token:%@  type:%@", token, type);
    [self oauthWithType: type param:@{@"grant_type":@"refresh_token", @"refresh_token": token} success: success failure: failure];
}

+ (void) refreshAppToken:(NSString*) token
                 success:(void (^)())success
                 failure:(void (^)())failure {
    [self refreshToken: token type: @"app_token" success:success failure:failure];
}

+ (void) refreshClientToken:(NSString*) token
                 success:(void (^)())success
                 failure:(void (^)())failure {
    [self refreshToken: token type: @"client_token" success:success failure:failure];
}

+ (void) getStoreWithSuccess:(void (^)(id responseObject))success
                     failure:(void (^)())failure {
    [self requestAppTokenWithMethod:@"GET" WithUrl:@"/store/list" param:nil success:success failure:failure];
}

+ (void) getCategoryWithStoreUid:(NSString*) uid
                        sucess:(void (^)(id responseObject))success
                        failure:(void (^)())failure {
    [self requestAppTokenWithMethod:@"GET" WithUrl:[NSString stringWithFormat:@"%@%@", @"/category/list?store_uid=", uid] param:nil success:success failure:failure];
}

+ (void) requestAppTokenWithMethod:(NSString*) method
                           WithUrl:(NSString*) url
                             param:(NSDictionary*) params
                        success:(void (^)(id responseObject))success
                        failure:(void (^)())failure {
    [self requestWithType:@"app_token" method:method url:url param:params success:success failure:failure];
}

+ (void) requestClientTokenWithMethod:(NSString*) method
                           WithUrl:(NSString*) url
                             param:(NSDictionary*) params
                           success:(void (^)(id responseObject))success
                           failure:(void (^)())failure {
    [self requestWithType:@"client_token" method:method url:url param:params success:success failure:failure];
}

+ (void) requestWithType:(NSString*) type
                    method:(NSString*) method
                       url:(NSString*) url
                     param:(NSDictionary*) params
                   success:(void (^)(id responseObject))success
                   failure:(void (^)())failure {
    
    NSLog(@"Request %@ url: %@ ", type, url);
    NSUserDefaults* defaults = [[NSUserDefaults alloc] init];
    NSDictionary* token = [defaults objectForKey:type];
    if (!token) {
        NSLog(@"Request %@ noCache", type);
        [self oauthClientCredentialsWithSuccess:^{
            [self requestWithType:type method:method url:url param:params success:success failure:failure];
        } failure: failure];
    } else {
        NSLog(@"Request %@ cache %@", type, token);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSString* authorization = [NSString stringWithFormat:@"%@%@", @"Bearer ", [token objectForKey:@"access_token"]];
        [manager.requestSerializer setValue:authorization forHTTPHeaderField:@"Authorization"];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        id requestSuccess = ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Request %@ RequestSuccess: %@", type, responseObject);
            success(responseObject);
        };
        
        id requestFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Request %@ RequestError: %@", type, error);
            if ([operation.response statusCode] == 401) {
                [NetworkManager refreshAppToken:[token objectForKey:@"refresh_token"] success:^{
                    [self requestWithType:type method:method url:url param:params success:success failure:failure];
                } failure: failure];
            }
        };
        NSString* fullUrl = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
        if ([method isEqualToString:@"GET"]) {
            [manager GET:fullUrl parameters:nil success:requestSuccess failure:requestFailure];
        } else if ([method isEqualToString:@"POST"]) {
            [manager POST:fullUrl parameters:nil success:requestSuccess failure:requestFailure];
        } else if ([method isEqualToString:@"PUT"]) {
            [manager PUT:fullUrl parameters:nil success:requestSuccess failure:requestFailure];
        }
    }
}
@end
