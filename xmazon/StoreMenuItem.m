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
    self = [super initWithName:name];
    if (self) {
        self.uid = uid;
    }
    return self;
}

- (UIViewController*) getController {
    if (self.controller == nil) {
        self.controller = [[StoreViewController alloc] initWithUid: self.uid];
        self.controller.title = self.name;
    }
    return [super getController];
}

@end
