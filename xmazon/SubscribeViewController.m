//
//  SubscribeViewController.m
//  xmazon
//
//  Created by Mohsan on 16/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "SubscribeViewController.h"
#import "NetworkManager.h"

@interface SubscribeViewController ()

@end

@implementation SubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchSubscribe:(id)sender {
    
    NSLog(@"%@", _inputEmail.text);
    
    NSDictionary* parameters=@{
        @"email":_inputEmail.text,
        @"password": _inputPassword.text,
        @"firstname": _inputFirstName.text,
        @"lastname": _inputLastName.text,
        @"birthdate": _inputBirth.text
                              
        };

    
    NSLog(@"%@", parameters);
    
    NSUserDefaults* defaults = [[NSUserDefaults alloc] init];
    [defaults setObject:nil forKey:@"app_token"];
    [NetworkManager setSubscribeWithSuccess:^(id responseObject) {
        NSLog(@"%@", [responseObject objectForKey:@"code"]);
        
        
        /*for(NSString* key in [responseObject objectForKey:@"result"]) {
            NSDictionary* data = key;
         
        }*/
    } failure:^{
        NSLog(@"NOPPPPP");
    }parameters: parameters];

    
}


@end
