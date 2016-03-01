//
//  SearchViewController.m
//  xmazon
//
//  Created by Quentin on 01/03/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "SearchViewController.h"
#import "NetworkManager.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    products = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [products count];
}

static NSString* const ProductsCellId = @"ProductsId";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ProductsCellId];
    if (!cell) {
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ProductsCellId];
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;
    }
    Product* product = [products objectAtIndex: indexPath.row];
    cell.textLabel.text = [product name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@", [[product price] stringValue], @"€"];
    cell.textColor = [product available] ? [UIColor blackColor] : [UIColor redColor];
    return cell;
}


- (NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]
                                                 icon:[UIImage imageNamed:@"add-to-cart.png"]];
    return rightUtilityButtons;
}

- (void)swipeableTableViewCell:(SWTableViewCell*)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSLog(@"%d", index);
}

- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar {
    NSLog(@"%@", searchBar.text);
    [NetworkManager getProductsWithCatogoryUid:uid_ sucess:^(id responseObject) {
        NSArray* result = [responseObject objectForKey:@"result"];
        for (NSInteger i = 0, max = [result count]; i<max; i++) {
            NSString* name = [[result objectAtIndex:i] objectForKey:@"name"];
            NSNumber* price = [[result objectAtIndex:i] objectForKey:@"price"];
            int available = [[[result objectAtIndex:i] objectForKey:@"available"] intValue];
            [products addObject:[[Product alloc] initWithName:name andWithPrice:price andIsAvailable:available == 1 ? YES : NO]];
        }
        [_productsTableView reloadData];
    } failure:^{
        
    }];
}
@end
