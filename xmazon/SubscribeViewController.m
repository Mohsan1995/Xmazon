//
//  SubscribeViewController.m
//  xmazon
//
//  Created by Mohsan on 16/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "SubscribeViewController.h"
#import "NetworkManager.h"
#import "LoginViewController.h"
#import "AlertMessage.h"

@interface SubscribeViewController ()

@end

@implementation SubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Inscription";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)subscribe:(id)sender {
    
    NSLog(@"%@", _inputEmail.text);
    NSDictionary* parameters=@{
                               @"email":self.inputEmail.text,
                               @"password": self.inputPassword.text,
                               @"firstname": self.inputFirstName.text,
                               @"lastname": self.inputLastName.text,
                               @"birthdate": self.inputBirth.text
                               };
    NSLog(@"%@", parameters);
    
    [NetworkManager subscribeWithParams: parameters success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] isEqualToNumber: [NSNumber numberWithInt:500]]) {
            [AlertMessage showWithView:self message:@"Une erreur est survenue lors de la création de votre compte" handler:nil];
        } else {
            [AlertMessage showWithView:self message:@"Votre compte a été bien été crée" handler:^(UIAlertAction *action) {
                [self.navigationController pushViewController:[LoginViewController new] animated:YES];
            }];
        }
    } failure:^{
        [AlertMessage showWithView:self message:@"Une erreur est survenue lors de la création de votre compte" handler:nil];
    }];
}

- (IBAction)login:(id)sender {
    
    [self.navigationController pushViewController:[LoginViewController new] animated:YES];
    
    
}




@end
