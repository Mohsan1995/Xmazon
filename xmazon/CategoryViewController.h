//
//  CategoryViewController.h
//  xmazon
//
//  Created by Quentin on 01/03/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "SWTableViewCell.h"

@interface CategoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate> {
    @private
    NSString* uid_;
    
    NSMutableArray<Product*>* products;
}

@property(strong, nonatomic) NSString* uid;
@property (weak, nonatomic) IBOutlet UITableView *productsTableView;

@end
