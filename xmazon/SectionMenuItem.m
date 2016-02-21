//
//  SectionMenuItem.m
//  xmazon
//
//  Created by Quentin on 21/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "SectionMenuItem.h"

@implementation SectionMenuItem

@synthesize title = title_;
@synthesize items = items_;


- (id) initWitTitle:(NSString*) title {
    self = [super init];
    if (self) {
        self.title = title;
        self.items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addMenu:(MenuItem*) menuItem {
    [self.items addObject:menuItem];
}

- (void) clearMenu {
    [self.items removeAllObjects];
}

@end
