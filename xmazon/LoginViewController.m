//
//  LoginViewController.m
//  xmazon
//
//  Created by Mohsan on 15/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "AFNetworking/AFNetworking.h"
#import "AFOAuth2Manager/AFOauth2Manager.h"
#import "LoginViewController.h"
#import "SubscribeViewController.h"
#import "NetworkManager.h"
#import "RootViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"Login";
    [NetworkManager getUserWithSuccess:^(id responseObject) {
        [self.navigationController pushViewController:[RootViewController new] animated:YES];
    } failure:^{
        
    }];
}

- (IBAction)connection:(id)sender {
    
    NSLog(@"Connection Action");
    
    NSUserDefaults* defaults = [[NSUserDefaults alloc] init];
    [defaults setObject:nil forKey:@"app_token"];
    
    NSLog(@"%@",self.loginInput.text);
    NSLog(@"%@",self.passwordInput.text);
    [NetworkManager oauthUserWithUserName:self.loginInput.text password:self.passwordInput.text successs:^{
        [self.navigationController pushViewController:[RootViewController new] animated:YES];
    } failure:^{
        NSLog(@"Nop");
    }];
    
}



- (IBAction)subscribe:(id)sender {
    
    NSLog(@"Create accout");
    
    
    SubscribeViewController* v = [SubscribeViewController new];
    //v.value = self.resultLabel.text;
    [self.navigationController pushViewController:v animated:YES];
}

@end
