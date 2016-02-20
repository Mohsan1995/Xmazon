//
//  StoreViewController.m
//  xmazon
//
//  Created by Quentin on 15/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "StoreViewController.h"
#import "NetworkManager.h"

@interface StoreViewController ()

@end

@implementation StoreViewController
@synthesize uid = uid_;

- (void)viewDidLoad {
    [super viewDidLoad];
    [NetworkManager getCategoryWithStoreUid:uid_ sucess:^(id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^{
        NSLog(@"NOPPPPP");
    }];
    NSLog(@"%@", self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
