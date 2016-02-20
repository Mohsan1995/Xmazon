//
//  StoreViewController.h
//  xmazon
//
//  Created by Quentin on 15/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreViewController : UIViewController {
    @private
    NSString* uid_;
}
@property(strong, nonatomic) NSString* uid;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *productsTableView;

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@end
