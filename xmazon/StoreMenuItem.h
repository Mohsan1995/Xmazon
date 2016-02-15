//
//  StoreMenuItem.h
//  xmazon
//
//  Created by Quentin on 15/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "MenuItem.h"

@interface StoreMenuItem : MenuItem {
    
    @private
    NSString* id_;
}
@property(strong, nonatomic) NSString* Id;

- (id) initWithName:(NSString *)name andWithId:(NSString*)Id;

@end
