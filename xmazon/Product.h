//
//  Product.h
//  xmazon
//
//  Created by Quentin on 01/03/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject {
    @private
    NSString* name_;
    NSNumber* price_;
    NSString* uid_;
    BOOL available_;
}

@property(strong, nonatomic) NSString* name;
@property(strong, nonatomic) NSNumber* price;
@property(strong, nonatomic) NSString* uid;
@property(assign, nonatomic) BOOL available;


- (id) initWithName:(NSString*) name andWithPrice:(NSNumber*) price andWithUid:(NSString*) uid andIsAvailable:(BOOL) available;
@end
