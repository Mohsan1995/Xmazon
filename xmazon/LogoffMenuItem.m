//
//  LogoffMenuItem.m
//  xmazon
//
//  Created by Quentin on 01/03/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "LogoffMenuItem.h"

@implementation LogoffMenuItem


- (void) onClick:(AMSlideMenuLeftTableViewController*) view {
    NSUserDefaults* defaults = [[NSUserDefaults alloc] init];
    [defaults setObject:nil forKey:@"client_token"];
    
    
}

@end
