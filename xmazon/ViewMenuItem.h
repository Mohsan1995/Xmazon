//
//  ViewMenuItem.h
//  xmazon
//
//  Created by Quentin on 01/03/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"

@interface ViewMenuItem : MenuItem {
    @private
    UIViewController* controller_;
}

@property(strong, nonatomic) UIViewController* controller;


- (id) initWithName:(NSString*) name andWithController:(UIViewController*) controller;

- (UIViewController*) getController;
@end
