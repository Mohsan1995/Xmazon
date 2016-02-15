//
//  MenuViewController.m
//  xmazon
//
//  Created by Quentin on 13/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "MenuViewController.h"
#import "NetworkManager.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    stores_ = [[NSMutableArray alloc] init];
    NSUserDefaults* defaults = [[NSUserDefaults alloc] init];
    //    [defaults setObject:nil forKey:@"app_token"];
    [NetworkManager getStoreWithSuccess:^(id responseObject) {
        for(NSString* key in [responseObject objectForKey:@"result"]) {
            NSDictionary* data = key;
            [stores_ addObject:[data objectForKey:@"name"]];
            [self.storeTableView reloadData];
        }
    } failure:^{
        NSLog(@"NOPPPPP");
    }];
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

@end
