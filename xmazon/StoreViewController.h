//
//  StoreViewController.h
//  xmazon
//
//  Created by Quentin on 15/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreViewController : UITabBarController {
    @private
    NSString* uid_;
}

-(id) initWithUid:(NSString*) uid;

@property(strong, nonatomic) NSString* uid;

@end
