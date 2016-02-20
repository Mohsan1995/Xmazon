//
//  LoginViewController.m
//  xmazon
//
//  Created by Mohsan on 15/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "LoginViewController.h"
#import "SubscribeViewController.h"
#import "NetworkManager.h"
#import "AFNetworking/AFNetworking.h"
#import "AFOAuth2Manager/AFOauth2Manager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"Login ";
}

- (IBAction)connection:(id)sender {
    
    NSLog(@"Connection Action");
    
    NSUserDefaults* defaults = [[NSUserDefaults alloc] init];
    [defaults setObject:nil forKey:@"app_token"];
    
    NSDictionary* parameters1= @{
                        @"username":@"test@testa.fr",
                            @"password":@"azertyazerty"
                                
                                
                                };

    
    NSLog(@"%@",self.loginInput.text);
    NSLog(@"%@",self.passwordInput.text);
    
}



- (IBAction)subscribe:(id)sender {
    
    NSLog(@"Create accout");
    
    
    SubscribeViewController* v = [SubscribeViewController new];
    //v.value = self.resultLabel.text;
    [self.navigationController pushViewController:v animated:YES];

    
    
}

@end
