//
//  MenuViewController.m
//  xmazon
//
//  Created by Quentin on 13/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "MenuViewController.h"
#import "NetworkManager.h"
#import "MainViewController.h"
#import "HomeMenuItem.h"
#import "StoreMenuItem.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menuItems = [[NSMutableArray alloc] init];
    [menuItems addObject:[[HomeMenuItem alloc] init]];
    NSUserDefaults* defaults = [[NSUserDefaults alloc] init];
    //    [defaults setObject:nil forKey:@"app_token"];
    [NetworkManager getStoreWithSuccess:^(id responseObject) {
        for(NSString* key in [responseObject objectForKey:@"result"]) {
            NSDictionary* data = key;
            [menuItems addObject:[[StoreMenuItem alloc] initWithName:[data objectForKey:@"name"] andWithUid:[data objectForKey:@"uid"]]];
            [_menuItemsTableView reloadData];
        }
    } failure:^{
        NSLog(@"NOPPPPP");
    }];
    NSLog(@"%@", self);
    [self openContentNavigationController: [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil]]];
}

- (void) clearAndAddHome {
    [menuItems removeAllObjects];
    [menuItems addObject:[[HomeMenuItem alloc] init]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [menuItems count];
}

static NSString* const StoreCellId = @"StoreId";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: StoreCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: StoreCellId];
    }
    cell.textLabel.text = [[menuItems objectAtIndex: indexPath.row] name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *nvc;
    nvc = [[UINavigationController alloc] initWithRootViewController:[[menuItems objectAtIndex: indexPath.row] controller]];
    [self openContentNavigationController:nvc];
}

@end
