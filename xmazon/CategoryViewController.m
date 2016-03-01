//
//  CategoryViewController.m
//  xmazon
//
//  Created by Quentin on 01/03/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "CategoryViewController.h"
#import "NetworkManager.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

@synthesize uid = uid_;

- (void)viewDidLoad {
    [super viewDidLoad];
    products = [[NSMutableArray alloc] init];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [products count];
}

static NSString* const ProductsCellId = @"ProductsId";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: ProductsCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier: ProductsCellId];
    }
    Product* product = [products objectAtIndex: indexPath.row];
    cell.textLabel.text = [product name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@", [[product price] stringValue], @"€"];
    cell.textColor = [product available] ? [UIColor blackColor] : [UIColor redColor];
    return cell;
}

@end
