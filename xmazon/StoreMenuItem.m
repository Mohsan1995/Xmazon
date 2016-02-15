//
//  StoreMenuItem.m
//  xmazon
//
//  Created by Quentin on 15/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "StoreMenuItem.h"
#import "StoreViewController.h"

@implementation StoreMenuItem

@synthesize Id = id_;

- (id) initWithName:(NSString *)name andWithId:(NSString*)Id {
    StoreViewController* storeViewController = [StoreViewController new];
    storeViewController.Id = self.Id;
    storeViewController.title = name;
    self = [super initWithName:name andWithController:storeViewController];
    if (self) {
        self.Id = Id;
    }
    return self;
}

@end
