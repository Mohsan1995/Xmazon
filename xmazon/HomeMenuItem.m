//
//  HomeMenuItem.m
//  xmazon
//
//  Created by Quentin on 15/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "HomeMenuItem.h"
#import "MainViewController.h"

@implementation HomeMenuItem

- (id) init {
    self = [super initWithName:@"Home" andWithController:[MainViewController new]];
    return self;
}
@end
