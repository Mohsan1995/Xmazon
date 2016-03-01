//
//  ViewMenuItem.m
//  xmazon
//
//  Created by Quentin on 01/03/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "ViewMenuItem.h"

@implementation ViewMenuItem

@synthesize controller = controller_;


- (id) initWithName:(NSString*) name andWithController:(UIViewController*) controller {
    self = [super initWithName:name];
    if (self) {
        self.controller = controller;
    }
    return self;
}

- (void) onClick:(AMSlideMenuLeftTableViewController*) view {
    [view openContentNavigationController: [[UINavigationController alloc] initWithRootViewController:[self getController]]];
}


- (UIViewController*) getController {
    return self.controller;
}

@end
