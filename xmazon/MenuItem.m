//
//  MenuItem.m
//  xmazon
//
//  Created by Quentin on 15/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

@synthesize name = name_;
@synthesize controller = controller_;

- (id) initWithName:(NSString*) name andWithController:(UIViewController*) controller {
    self = [super init];
    if (self) {
        self.name = name;
        self.controller = controller;
    }
    return self;
}

@end
