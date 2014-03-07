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
        
        self.sprite = [[SKSpriteNode alloc] initWithImageNamed:@"ship"];
        self.sprite.texture.filteringMode = SKTextureFilteringNearest;
    }
    
    self.type = type;
    self.velocity = CGPointMake(0, 30);
    
    return self;
}

-(void)setHeading:(NSInteger)heading
{
    _heading = heading;
    
    switch (heading) {
        case kElementHeadingNorth:
        {
            [self changeTextureToNorth];
        }
            break;
        case kElementHeadingSouth:
        {
            [self changeTextureToSouth];
        }
            break;
        case kElementHeadingWest:
        {
            [self changeTextureToWest];
        }
            break;
        case kElementHeadingEast:
        {
            [self changeTextureToEast];
        }
            break;
        default:
            break;
    }
}

- (void)changeTextureToNorth
{
    NSLog(@"changed to south");
    self.sprite.texture = [SKTexture textureWithImageNamed:@"ship"];
    self.sprite.size = self.sprite.texture.size;
    self.sprite.texture.filteringMode = SKTextureFilteringNearest;
}

- (void)changeTextureToSouth
{
    NSLog(@"changed to north");
    self.sprite.texture = [SKTexture textureWithImageNamed:@"ship_north"];
    self.sprite.size = self.sprite.texture.size;
    self.sprite.texture.filteringMode = SKTextureFilteringNearest;
}

- (void)changeTextureToWest
{
    NSLog(@"changed to east");
    self.sprite.texture = [SKTexture textureWithImageNamed:@"ship_right"];
    self.sprite.size = self.sprite.texture.size;
    self.sprite.texture.filteringMode = SKTextureFilteringNearest;
}

- (void)changeTextureToEast
{
    NSLog(@"changed to west");
    self.sprite.texture = [SKTexture textureWithImageNamed:@"ship_left"];
    self.sprite.size = self.sprite.texture.size;
    self.sprite.texture.filteringMode = SKTextureFilteringNearest;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"Velocity: %f, %f; sprite: %@", self.velocity.x, self.velocity.y, self.sprite];
}

@end