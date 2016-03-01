//
//  StoreMenuItem.h
//  xmazon
//
//  Created by Quentin on 15/02/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "ViewMenuItem.h"

@interface StoreMenuItem : ViewMenuItem {
    
    @private
    NSString* uid_;
}
@property(strong, nonatomic) NSString* uid;

- (id) initWithName:(NSString *)name andWithUid:(NSString*)uid;

@end
