//
//  MenuViewController.h
//  xmazon
//
//  Created by Quentin on 13/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMSlideMenuLeftTableViewController.h"
#import "MenuItem.h"

@interface MenuViewController : AMSlideMenuLeftTableViewController {
    
    @private
    NSMutableArray<MenuItem*>* menuItems;
}
@property (strong, nonatomic) IBOutlet UITableView *menuItemsTableView;

@end
