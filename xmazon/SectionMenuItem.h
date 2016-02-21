//
//  SectionMenuItem.h
//  xmazon
//
//  Created by Quentin on 21/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuItem.h"


@interface SectionMenuItem : NSObject {
    @private
    NSString* title_;
    NSMutableArray<MenuItem*>* items_;
}

@property(strong, nonatomic) NSString* title;
@property(strong, nonatomic) NSMutableArray<MenuItem*>* items;

- (id) initWitTitle:(NSString*) title;
- (void) addMenu:(MenuItem*) menuItem;
- (void) clearMenu;
@end
