//
//  MenuItem.h
//  xmazon
//
//  Created by Quentin on 15/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItem : NSObject {
    
    @private
    NSString* name_;
    UIViewController* controller_;
}
@property(strong, nonatomic) NSString* name;
@property(strong, nonatomic) UIViewController* controller;


- (id) initWithName:(NSString*) name andWithController:(UIViewController*) controller;
@end
