//
//  CartViewController.m
//  xmazon
//
//  Created by Quentin on 01/03/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "CartViewController.h"
#import "NetworkManager.h"

@interface CartViewController ()

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Mon Panier";
    products = [[NSMutableArray alloc] init];
    [NetworkManager getCartWithSucess:^(id responseObject) {
        NSArray* result = [[responseObject objectForKey:@"result"] objectForKey:@"products_cart"];
        for (NSInteger i = 0, max = [result count]; i<max; i++) {
            NSDictionary* product = [[result objectAtIndex:i] objectForKey:@"product"];
            NSString* name = [product objectForKey:@"name"];
            NSNumber* price = [product objectForKey:@"price"];
            NSString* uid = [product objectForKey:@"uid"];
            int available = [[product objectForKey:@"available"] intValue];
            int quantity = [[[result objectAtIndex:i] objectForKey:@"quantity"] intValue];
            if (quantity == 0) {
                continue;
            }
            if (quantity > 1) {
                name = [NSString stringWithFormat:@"%d x %@", quantity, name];
                price = [NSNumber numberWithFloat: ([price floatValue] * quantity)];
            }
            [products addObject:[[Product alloc] initWithName:name andWithPrice:price andWithUid:uid andIsAvailable:available == 1 ? YES : NO]];
        }
        [_cartTableView reloadData];
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
    [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0] icon:[UIImage imageNamed:@"delete.png"]];
    return rightUtilityButtons;
}


- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath* cellIndexPath = [self.cartTableView indexPathForCell:cell];
    Product* product = [products objectAtIndex: cellIndexPath.row];
    NSLog(@"Remove uid:%@", product.uid);
    [NetworkManager removeProductToCartWithUid:product.uid quantity:1 sucess:^(id responseObject) {
        NSLog(@"Deleted");
    } failure:^{
        NSLog(@"Nopp");
    }];
}
@end
