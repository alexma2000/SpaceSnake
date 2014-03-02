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
    self.rotationPoints = [[NSMutableArray alloc] init];
    self.elements = [[NSMutableArray alloc] initWithCapacity:10];
    self.head = [[SnakeElement alloc] initWithType:kShipTypePlayer];
    self.head.elementInFront = self.head;
    //[self.elements addObject:self.head];
    
    return self;
}

- (CGPoint) velocity
{
    return self.head.velocity;
}

- (void) setVelocity:(CGPoint)newVelocity;
{
    self.head.velocity = newVelocity;
    
    [self.rotationPoints addObject:NSStringFromCGPoint(self.head.sprite.position)];
}

- (void)addElement:(SnakeElement *)element
{
    SnakeElement *lastElement = [self.elements lastObject];
    [self.elements addObject:element];
    element.sprite.position = CGPointMake(lastElement.sprite.position.x + lastElement.velocity.x * 2.5 , lastElement.sprite.position.y + lastElement.velocity.y * 2.5);
    element.sprite.zRotation = lastElement.sprite.zRotation;
    element.velocity = lastElement.velocity;
}

@end
