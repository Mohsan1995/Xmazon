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

@synthesize uid = uid_;

- (id) initWithName:(NSString *)name andWithUid:(NSString*)uid {
    StoreViewController* storeViewController = [[StoreViewController alloc] initWithUid: uid];
    storeViewController.title = name;
    self = [super initWithName:name andWithController:storeViewController];
    if (self) {
        self.uid = uid;
    }
    return self;
}

@end
