//
//  MenuViewController.h
//  xmazon
//
//  Created by Quentin on 13/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMSlideMenuLeftTableViewController.h"
#import "SectionMenuItem.h"

@interface MenuViewController : AMSlideMenuLeftTableViewController {
    
    @private
    NSMutableArray<SectionMenuItem*>* sectionMenuItems;
}
@property (strong, nonatomic) IBOutlet UITableView *menuItemsTableView;

@end
