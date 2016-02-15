//
//  MainViewController.m
//  xmazon
//
//  Created by Quentin on 13/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "MainViewController.h"
#import "MenuViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    self.leftMenu = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    [super viewDidLoad];
    self.title = @"Michel Moncul";
}

- (BOOL)deepnessForLeftMenu {
    return YES;
}


@end
