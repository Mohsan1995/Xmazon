//
//  Product.m
//  xmazon
//
//  Created by Quentin on 01/03/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "Product.h"

@implementation Product

@synthesize name = name_;
@synthesize price = price_;
@synthesize available = available_;

- (id) initWithName:(NSString*) name andWithPrice:(NSNumber*) price andIsAvailable:(BOOL) available {
    self = [super init];
    if (self) {
        self.name = name;
        self.price = price;
        self.available = available;
    }
    return self;
}
@end
