//
//  AlertMessage.h
//  xmazon
//
//  Created by Quentin on 01/03/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface AlertMessage : NSObject

+ (void) showWithView:(UIViewController*) viewController
              message:(NSString*) myMessage
              handler:(void (^)(UIAlertAction* action)) handler;

@end
