//
//  SubscribeViewController.h
//  xmazon
//
//  Created by Mohsan on 16/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubscribeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *inputEmail;
@property (weak, nonatomic) IBOutlet UITextField *inputPassword;
@property (weak, nonatomic) IBOutlet UITextField *inputFirstName;
@property (weak, nonatomic) IBOutlet UITextField *inputLastName;
@property (weak, nonatomic) IBOutlet UITextField *inputBirth;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;


- (void)  showAlertWithMessage:(NSString*) myMessage
                       handler:(void (^)(UIAlertAction* action)) handler;

@end
