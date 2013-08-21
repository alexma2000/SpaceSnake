//
//  SnakeElement.m
//  Space Snake
//
//  Created by Dmitry Volevodz on 21.08.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import "SnakeElement.h"

@implementation SnakeElement

- (id) initWithType:(NSInteger) type
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    if (self.type == kShipTypePlayer) {
        
        self.sprite = [[SKSpriteNode alloc] initWithImageNamed:@"playerShip.png"];
    }
    self.heading = kNorth;
    self.type = type;
    self.velocity = CGPointMake(0, 30);
    
    return self;
}

@end