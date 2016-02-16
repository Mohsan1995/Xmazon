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

+ (void) oauthWithType:(NSString*) type param:(NSDictionary*) params
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
                                                   //NSLog(@"oauth RequestSuccess token:%@", token);
                                                   success();
                                               }
                                               failure:^(NSError *error) {
                                                   NSLog(@"oauth RequestError error:%@", error);
                                                   failure();
                                               }];
}

+ (void) oauthClientCredentialsWithSuccess:(void (^)())success
                                   failure:(void (^)())failure {
    [self oauthWithType:@"app_token" param:@{@"grant_type":@"client_credentials"} success: success failure: failure];
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

+ (void) getStoreWithSuccess:(void (^)(id responseObject))success
                     failure:(void (^)())failure {
    [self requestAppTokenWithUrl:@"/store/list" success:success failure:failure];
}

+ (void) requestAppTokenWithUrl:(NSString*) url
                        success:(void (^)(id responseObject))success
                        failure:(void (^)())failure{
    NSLog(@"RequestAppToken url: %@ ", url);
    
    NSUserDefaults* defaults = [[NSUserDefaults alloc] init];
    NSDictionary* appToken = [defaults objectForKey:@"app_token"];
    if (!appToken) {
        NSLog(@"RequestAppToken noCache");
        [self oauthClientCredentialsWithSuccess:^{
            [self requestAppTokenWithUrl: url success: success failure: failure];
        } failure: failure];
    } else {
        NSLog(@"RequestAppToken cache");
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSString* authorization = [NSString stringWithFormat:@"%@%@", @"Bearer ", [appToken objectForKey:@"access_token"]];
        [manager.requestSerializer setValue:authorization forHTTPHeaderField:@"Authorization"];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager GET:[NSString stringWithFormat:@"%@%@", BASE_URL, url] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"RequestAppToken RequestSuccess: %@", responseObject);
            success(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"RequestAppToken RequestError: %@", error);
            if ([operation.response statusCode] == 401) {
                [NetworkManager refreshAppToken:[appToken objectForKey:@"refresh_token"] success:^{
                    [self requestAppTokenWithUrl: url success: success failure: failure];
                } failure: failure];
            }
        }];
    }
}

+ (void) requestAppTokenWithUrlPost:(NSString*) url
                        success:(void (^)(id responseObject))success
                        failure:(void (^)())failure{
    NSLog(@"RequestAppToken url: %@ ", url);
    
    NSUserDefaults* defaults = [[NSUserDefaults alloc] init];
    NSDictionary* appToken = [defaults objectForKey:@"app_token"];
    if (!appToken) {
        NSLog(@"RequestAppToken noCache");
        [self oauthClientCredentialsWithSuccess:^{
            [self requestAppTokenWithUrl: url success: success failure: failure];
        } failure: failure];
    } else {
        NSLog(@"RequestAppToken cache");
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSString* authorization = [NSString stringWithFormat:@"%@%@", @"Bearer ", [appToken objectForKey:@"access_token"]];
        [manager.requestSerializer setValue:authorization forHTTPHeaderField:@"Authorization"];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager POST:[NSString stringWithFormat:@"%@%@", BASE_URL, url] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"RequestAppToken RequestSuccess: %@", responseObject);
            success(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"RequestAppToken RequestError: %@", error);
            if ([operation.response statusCode] == 401) {
                [NetworkManager refreshAppToken:[appToken objectForKey:@"refresh_token"] success:^{
                    [self requestAppTokenWithUrl: url success: success failure: failure];
                } failure: failure];
            }
        }];
    }
}

@end
