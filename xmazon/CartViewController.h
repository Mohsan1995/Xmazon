//
//  CartViewController.h
//  xmazon
//
//  Created by Quentin on 01/03/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "SWTableViewCell.h"

@interface CartViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, SWTableViewCellDelegate> {
@private
    NSMutableArray<Product*>* products;
}
@property (weak, nonatomic) IBOutlet UITableView *cartTableView;

@end
