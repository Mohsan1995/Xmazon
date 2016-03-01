//
//  MenuViewController.m
//  xmazon
//
//  Created by Quentin on 13/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "MenuViewController.h"
#import "NetworkManager.h"
#import "UserViewController.h"
#import "StoreMenuItem.h"
#import "LogoffMenuItem.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sectionMenuItems = [[NSMutableArray alloc] init];
    
    SectionMenuItem* clientSection = [[SectionMenuItem alloc] initWitTitle:@"Client"];
    [clientSection addMenu:[[ViewMenuItem alloc] initWithName:@"Mon Compte" andWithController:[UserViewController new]]];
    [clientSection addMenu:[[ViewMenuItem alloc] initWithName:@"Mon Panier" andWithController:nil]];
    [clientSection addMenu:[[LogoffMenuItem alloc] initWithName:@"Déconnecter"]];
    [sectionMenuItems addObject:clientSection];
    
    SectionMenuItem* storesSection = [[SectionMenuItem alloc] initWitTitle:@"Store"];
    [sectionMenuItems addObject: storesSection];
    
    [NetworkManager getStoreWithSuccess:^(id responseObject) {
        [storesSection clearMenu];
        for(NSString* key in [responseObject objectForKey:@"result"]) {
            NSDictionary* data = key;
            [storesSection addMenu:[[StoreMenuItem alloc] initWithName:[data objectForKey:@"name"] andWithUid:[data objectForKey:@"uid"]]];
            [_menuItemsTableView reloadData];
        }
    } failure:^{
        NSLog(@"NOPPPPP");
    }];
}

//Section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [sectionMenuItems count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[sectionMenuItems objectAtIndex:section] title];
}



//Row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[sectionMenuItems objectAtIndex:section] items] count];
}

static NSString* const StoreCellId = @"StoreId";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: StoreCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: StoreCellId];
    }
    cell.textLabel.text = [[[[sectionMenuItems objectAtIndex:indexPath.section] items] objectAtIndex:indexPath.row] name];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[[[sectionMenuItems objectAtIndex:indexPath.section] items] objectAtIndex:indexPath.row] onClick:self];
}

@end
