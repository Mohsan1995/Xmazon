//
//  AlertMessage.m
//  xmazon
//
//  Created by Quentin on 01/03/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "AlertMessage.h"

@implementation AlertMessage

+ (void) showWithView:(UIViewController*) viewController
              message:(NSString*) myMessage
              handler:(void (^)(UIAlertAction* action)) handler {
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:@"Subscribe" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler: handler]];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}
@end
