//
//  MainViewController.h
//  xmazon
//
//  Created by Quentin on 13/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    @private
    NSMutableArray* stores_;
}
@property (weak, nonatomic) IBOutlet UITableView *storeTableView;

@end
