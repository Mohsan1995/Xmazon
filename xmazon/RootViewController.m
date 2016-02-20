//
//  RootViewController.m
//  xmazon
//
//  Created by Quentin on 15/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "RootViewController.h"
#import "MenuViewController.h"
#import "NetworkManager.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
    [NetworkManager oauthUserWithUserName:@"crabeman93330@gmail.com" password:@"test" successs:^{
        NSLog(@"OK");
    } failure:^{
        NSLog(@"Nop");
    }];
}

- (BOOL)deepnessForLeftMenu {
    return YES;
}
@end
