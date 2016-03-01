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

- (id) initWithName:(NSString*) name {
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}


- (void) onClick:(AMSlideMenuLeftTableViewController*) view {
    //Override
}

@end
