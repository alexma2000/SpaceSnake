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
    
    NSString *velocity = NSStringFromCGPoint(newVelocity);
    NSString *spritePosition = NSStringFromCGPoint(self.head.sprite.position);
    
    double angle;
    
    if (newVelocity.x > 1) {
        angle = -1.570796;
    }
    
    if (newVelocity.x < -1) {
        angle = 1.570796;
    }
    
    if (newVelocity.y > 1) {
        angle = 0.0;
    }
    
    if (newVelocity.y < -1) {
        angle = 3.14;
    }
    
    [self.rotationPoints addObject:@{@"velocity": velocity, @"position" : spritePosition, @"angle" : @(angle)}];
}

- (void)addElement:(SnakeElement *)element
{
    SnakeElement *lastElement = [self.elements lastObject];
    if (!lastElement) {
        lastElement = self.head;
    }
    
    [self.elements addObject:element];
    element.sprite.position = CGPointMake(lastElement.sprite.position.x + lastElement.velocity.x * 2.5 , lastElement.sprite.position.y + lastElement.velocity.y * 2.5);
    element.sprite.zRotation = lastElement.sprite.zRotation;
    element.velocity = lastElement.velocity;
}

@end
