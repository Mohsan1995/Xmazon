//
//  MainViewController.m
//  xmazon
//
//  Created by Quentin on 13/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "MainViewController.h"
#import "NetworkManager.h"
#import "SlideNavigationController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    stores_ = [[NSMutableArray alloc] init];
    self.title = @"Michel Moncul";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(onTouchMenu)];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onTouchMenu {
    NSLog(@"onTouchMenu");
    [[SlideNavigationController sharedInstance] toggleLeftMenu];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [stores_ count];
}

static NSString* const toto = @"mdr";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: toto];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: toto];
    }
    cell.textLabel.text = [stores_ objectAtIndex: indexPath.row];
    return cell;
}

@end
