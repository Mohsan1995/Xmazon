//
//  StoreViewController.m
//  xmazon
//
//  Created by Quentin on 15/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "StoreViewController.h"
#import "NetworkManager.h"
#import "CategoryViewController.h"

@interface StoreViewController ()

@end

@implementation StoreViewController
@synthesize uid = uid_;


-(id) initWithUid:(NSString*) uid {
    self = [super initWithNibName:@"StoreViewController" bundle:nil];
    if (self) {
        self.uid = uid;
        CategoryViewController* cvc = [CategoryViewController new];
        [cvc.tabBarController setTitle:@"echo"];
        [self setViewControllers:@[cvc]];
        [NetworkManager getCategoryWithStoreUid:uid sucess:^(id responseObject) {
            NSLog(@"%@", responseObject);
            NSArray* result = [responseObject objectForKey:@"result"];
            NSMutableArray* controllers = [[NSMutableArray alloc] initWithCapacity: [result count]];
            for (NSInteger i = 0, max = [result count]; i<max; i++) {
                CategoryViewController* category = [CategoryViewController new];
                category.title = [[result objectAtIndex:i] objectForKey:@"name"];
                category.uid = [[result objectAtIndex:i] objectForKey:@"uid"];
                [controllers addObject:category];
            }
            [self setViewControllers: controllers];
        } failure:^{
            NSLog(@"NOPPPPP");
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
