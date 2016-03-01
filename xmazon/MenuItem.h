//
//  MenuItem.h
//  xmazon
//
//  Created by Quentin on 15/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMSlideMenuLeftTableViewController.h"

@interface MenuItem : NSObject {
    
    @private
    NSString* name_;
}
@property(strong, nonatomic) NSString* name;


- (id) initWithName:(NSString*) name;

- (void) onClick:(AMSlideMenuLeftTableViewController*) view;
@end
