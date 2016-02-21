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
    self.title=@"Inscription";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)  showAlertMessage:(NSString*) myMessage{
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:@"Subscribe" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
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
    
    NSUserDefaults* defaults = [[NSUserDefaults alloc] init];
    [defaults setObject:nil forKey:@"app_token"];
    [NetworkManager subscribeWithParams: parameters success:^(id responseObject) {
        NSString* string = [responseObject objectForKey:@"code"];
        NSLog(@"Response api  %@", string);
        
        /*if ([responseObject objectForKey:@"code"]) {
         [self showAlertMessage:@"Une erreur est survenue lors de la création de votre compte"];
         }else{
         [self showAlertMessage:@"Votre compte a été bien été crée"];
         
         }*/
    } failure:^{
        NSLog(@"NOPPPPP");
    }];
}





@end
