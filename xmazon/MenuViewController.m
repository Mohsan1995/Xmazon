//
//  MenuViewController.m
//  xmazon
//
//  Created by Quentin on 13/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "MenuViewController.h"
#import "NetworkManager.h"
#import "FirstTestViewController.h"
#import "SecondTestViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    stores_ = [@[@"VC 1",@"VC 2"] mutableCopy];
    /*
    NSUserDefaults* defaults = [[NSUserDefaults alloc] init];
    //    [defaults setObject:nil forKey:@"app_token"];
    [NetworkManager getStoreWithSuccess:^(id responseObject) {
        for(NSString* key in [responseObject objectForKey:@"result"]) {
            NSDictionary* data = key;
            [stores_ addObject:[data objectForKey:@"name"]];
        }
    } failure:^{
        NSLog(@"NOPPPPP");
    }];*/
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [stores_ count];
}

static NSString* const StoreCellId = @"StoreId";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: StoreCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: StoreCellId];
    }
    cell.textLabel.text = [stores_ objectAtIndex: indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *nvc;
    UIViewController *rootVC;
    switch (indexPath.row) {
        case 0:
        {
            rootVC = [[FirstTestViewController alloc] initWithNibName:@"FirstTestViewController" bundle:nil];
        }
            break;
        case 1:
        {
            rootVC = [[SecondTestViewController alloc] initWithNibName:@"SecondTestViewController" bundle:nil];
        }
            break;
        default:
            break;
    }
    nvc = [[UINavigationController alloc] initWithRootViewController:rootVC];
    
    [self openContentNavigationController:nvc];
}

@end
