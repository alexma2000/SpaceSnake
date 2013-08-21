//
//  Snake.m
//  Space Snake
//
//  Created by Dmitry Volevodz on 21.08.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import "Snake.h"


@implementation Snake

- (id) init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.elements = [[NSMutableArray alloc] initWithCapacity:10];
    self.head = [[SnakeElement alloc] initWithType:kShipTypePlayer];
    self.head.elementInFront = self.head;
    [self.elements addObject:self.head];
    
    return self;
}

- (CGPoint) velocity
{
    return self.head.velocity;
}

- (void) setVelocity:(CGPoint)newVelocity;
{
    self.head.velocity = newVelocity;
}


@end
