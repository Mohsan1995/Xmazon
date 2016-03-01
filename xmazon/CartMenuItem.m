//
//  CartMenuItem.m
//  xmazon
//
//  Created by Quentin on 01/03/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "CartMenuItem.h"
#import "CartViewController.h"

@implementation CartMenuItem

- (UIViewController*) getController {
    return [CartViewController new];
}

@end
