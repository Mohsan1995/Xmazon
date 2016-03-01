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




//-----------------------------------------------------
//AUTH
//-----------------------------------------------------
//Permet d'exécuter une requête sur oauth/token et sauvegarde les token en fonction du type
//type: [app_token | client_token]
//params: le corps de la requête
+ (void) oauthWithType:(NSString*) type
                 params:(NSDictionary*) params
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
                                                   //On format les token
                                                   NSDictionary* token = @{
                                                                           @"access_token": credential.accessToken,
                                                                           @"refresh_token": credential.refreshToken
                                                                           };
                                                   //On les save
                                                   [defaults setObject:token forKey:type];
                                                   NSLog(@"oauth %@ RequestSuccess token:%@", type, token);
                                                   success();
                                               }
                                               failure:^(NSError *error) {
                                                   NSLog(@"oauth %@ RequestError error:%@", type, error);
                                                   failure();
                                               }];
}



//Pour authentifier l'app
+ (void) oauthClientCredentialsWithSuccess:(void (^)())success
                                   failure:(void (^)())failure {
    [self oauthWithType:@"app_token" params:@{@"grant_type":@"client_credentials"} success: success failure: failure];
}



//Pour authentifier le client
+ (void) oauthUserWithUserName:(NSString*) email
                      password:(NSString*) password
                      successs:(void (^)())success
                       failure:(void (^)())failure {
    [self oauthWithType:@"client_token" params:@{@"grant_type":@"password", @"username": email, @"password": password} success: success failure: failure];
}
//-----------------------------------------------------
//-----------------------------------------------------




//-----------------------------------------------------
//REFRESH
//-----------------------------------------------------
//Pour refresh le token
+ (void) refreshToken:(NSString*) token
                 type:(NSString*) type
              success:(void (^)())success
              failure:(void (^)())failure {
    NSLog(@"refreshToken token:%@  type:%@", token, type);
    [self oauthWithType: type params:@{@"grant_type":@"refresh_token", @"refresh_token": token} success: success failure: failure];
}



//Pour refresh l'app token
+ (void) refreshAppToken:(NSString*) token
                 success:(void (^)())success
                 failure:(void (^)())failure {
    [self refreshToken: token type: @"app_token" success:success failure:failure];
}



//Pour refresh le client token
+ (void) refreshClientToken:(NSString*) token
                    success:(void (^)())success
                    failure:(void (^)())failure {
    [self refreshToken: token type: @"client_token" success:success failure:failure];
}
//-----------------------------------------------------
//-----------------------------------------------------




//-----------------------------------------------------
//REQUEST
//-----------------------------------------------------
//Permet d'exécuter une requête
//type: [app_token | client_token]
//method: [GET | POST | PUT]
//url: l'url
//params: le corps de la requête
+ (void) requestWithType:(NSString*) type
                  method:(NSString*) method
                     url:(NSString*) url
                   params:(NSDictionary*) params
                 success:(void (^)(id responseObject))success
                 failure:(void (^)())failure {
    
    NSLog(@"Request %@ url:%@   params:%@", type, url, params);
    
    //On recupère le token en fonction du type
    NSUserDefaults* defaults = [[NSUserDefaults alloc] init];
    NSDictionary* token = [defaults objectForKey:type];
    if (!token) {//Si ya pas de token de sauvegarder
        NSLog(@"Request %@ noCache", type);
        if ([type isEqualToString:@"app_token"]) {//Si c'est l'app token
            //On s'authentifie
            [self oauthClientCredentialsWithSuccess:^{
                [self requestWithType:type method:method url:url params:params success:success failure:failure];
            } failure: failure];
        } else {//Sinon si c'est le client token
            //On execute le callback d'erreur
            //TODO: Retourner des code d'erreur
            failure();
        }
    } else {//Sinon on execute la requête
        NSLog(@"Request %@ cache %@", type, token);
        //On créer le manager
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //On définie le header Authorization
        NSString* authorization = [NSString stringWithFormat:@"%@%@", @"Bearer ", [token objectForKey:@"access_token"]];
        NSLog(@"%@", authorization);
        [manager.requestSerializer setValue:authorization forHTTPHeaderField:@"Authorization"];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        //Le CallBack en cas de succees
        id requestSuccess = ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Request %@ RequestSuccess: %@", type, responseObject);
            success(responseObject);
        };
        //Le CallBack en cas d'érreur
        id requestFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Request %@ RequestError: %@", type, error);
            if ([operation.response statusCode] == 401) { //Si l'erreur est de type 401
                //On essaye de refresh le token
                [NetworkManager refreshToken:[token objectForKey:@"refresh_token"] type:type success:^{
                    [self requestWithType:type method:method url:url params:params success:success failure:failure];
                } failure:failure];
            }
        };
        
        //L'url complète
        NSString* fullUrl = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
        
        //On éxécute les différentes fonction en fonction de la method définie
        if ([method isEqualToString:@"GET"]) {
            [manager GET:fullUrl parameters:params success:requestSuccess failure:requestFailure];
        } else if ([method isEqualToString:@"POST"]) {
            [manager POST:fullUrl parameters:params success:requestSuccess failure:requestFailure];
        } else if ([method isEqualToString:@"PUT"]) {
            [manager PUT:fullUrl parameters:params success:requestSuccess failure:requestFailure];
        }
    }
}


//Exécuter un requête utilisant l'app token
+ (void) requestAppTokenWithMethod:(NSString*) method
                           WithUrl:(NSString*) url
                             params:(NSDictionary*) params
                           success:(void (^)(id responseObject))success
                           failure:(void (^)())failure {
    [self requestWithType:@"app_token" method:method url:url params:params success:success failure:failure];
}



//Exécuter un requête utilisant le client token
+ (void) requestClientTokenWithMethod:(NSString*) method
                              WithUrl:(NSString*) url
                                params:(NSDictionary*) params
                              success:(void (^)(id responseObject))success
                              failure:(void (^)())failure {
    [self requestWithType:@"client_token" method:method url:url params:params success:success failure:failure];
}
//-----------------------------------------------------
//-----------------------------------------------------




//-----------------------------------------------------
//Custom REQUEST
//-----------------------------------------------------

//Recupère les commandes
+ (void) getOrdersWithSuccess:(void (^)(id responseObject))success
                      failure:(void (^)())failure {
    [self requestClientTokenWithMethod:@"GET" WithUrl:@"/order/list" params:nil success:success failure:failure];
}

//Recupère informations utilisateur
+ (void) getUserWithSuccess:(void (^)(id responseObject))success
                    failure:(void (^)())failure {
    [self requestAppTokenWithMethod:@"GET" WithUrl:@"/user" params:nil success:success failure:failure];
}

//Récuprer les stores
+ (void) getStoreWithSuccess:(void (^)(id responseObject))success
                     failure:(void (^)())failure {
    [self requestAppTokenWithMethod:@"GET" WithUrl:@"/store/list" params:nil success:success failure:failure];
}



//Récuprer les catégorie d'un store
+ (void) getCategoryWithStoreUid:(NSString*) uid
                          sucess:(void (^)(id responseObject))success
                         failure:(void (^)())failure {
    [self requestAppTokenWithMethod:@"GET" WithUrl:[NSString stringWithFormat:@"%@%@", @"/category/list?store_uid=", uid] params:nil success:success failure:failure];
}


+ (void) getProductsWithCatogoryUid:(NSString*) uid
                             sucess:(void (^)(id responseObject))success
                            failure:(void (^)())failure {
    [self requestClientTokenWithMethod:@"GET" WithUrl:[NSString stringWithFormat:@"%@%@", @"/product/list?category_uid=", uid] params:nil success:success failure:failure];
}


//Worth API
+ (void) getProductsWithSearch:(NSString*) search
                        sucess:(void (^)(id responseObject))success
                       failure:(void (^)())failure {
        [self requestClientTokenWithMethod:@"GET" WithUrl:[NSString stringWithFormat:@"%@%@", @"/product/list?search=", search] params:nil success:success failure:failure];
}


//Method use for subscription
+ (void) subscribeWithParams:(NSDictionary*) params
                     success:(void (^)(id responseObject))success
                     failure:(void (^)())failure {
    [self requestAppTokenWithMethod:@"POST" WithUrl:@"/auth/subscribe" params:params success:success failure:failure];
}
@end
