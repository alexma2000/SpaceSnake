//
//  SnakeElement.m
//  Space Snake
//
//  Created by Dmitry Volevodz on 21.08.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import "SnakeElement.h"

@interface SnakeElement ()

@property (strong, nonatomic) SKTextureAtlas *idleAtlas;

@property (strong, nonatomic) NSMutableArray *idleLeft;
@property (strong, nonatomic) NSMutableArray *idleRight;
@property (strong, nonatomic) NSMutableArray *idleDown;
@property (strong, nonatomic) NSMutableArray *idleUp;

@property (strong, nonatomic) SKAction *idleLeftAnimation;
@property (strong, nonatomic) SKAction *idleRightAnimation;
@property (strong, nonatomic) SKAction *idleDownAnimation;
@property (strong, nonatomic) SKAction *idleUpAnimation;

@end

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
    
    self.idleAtlas = [SKTextureAtlas atlasNamed:@"enterprise"];
    [self setupAnimations];
    
    return self;
}

- (void)setupAnimations
{
    self.idleLeft = [[NSMutableArray alloc] init];
    self.idleRight = [[NSMutableArray alloc] init];
    self.idleDown = [[NSMutableArray alloc] init];
    self.idleUp = [[NSMutableArray alloc] init];
    self.idleLeft = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 6; i++) {
        NSString *string = [NSString stringWithFormat:@"enterprise_down%d", i];
        SKTexture *texture = [SKTexture textureWithImageNamed:string];
        texture.filteringMode = SKTextureFilteringNearest;
        [self.idleDown addObject:texture];
    }
    
    SKAction *temp1 = [SKAction animateWithTextures:self.idleDown timePerFrame:ANIMATION_TIME_PER_FRAME];
    self.idleDownAnimation = [SKAction repeatActionForever:temp1];
    
    
    for (int i = 0; i < 6; i++) {
        NSString *string = [NSString stringWithFormat:@"enterprise_up%d", i];
        SKTexture *texture = [self.idleAtlas textureNamed:string];
        texture.filteringMode = SKTextureFilteringNearest;
        [self.idleUp addObject:texture];
    }
    
    SKAction *temp2 = [SKAction animateWithTextures:self.idleUp timePerFrame:ANIMATION_TIME_PER_FRAME];
    self.idleUpAnimation = [SKAction repeatActionForever:temp2];
    
    for (int i = 0; i < 6; i++) {
        NSString *string = [NSString stringWithFormat:@"enterprise_left%d", i];
        SKTexture *texture = [self.idleAtlas textureNamed:string];
        texture.filteringMode = SKTextureFilteringNearest;
        [self.idleLeft addObject:texture];
    }
    
    SKAction *temp3 = [SKAction animateWithTextures:self.idleLeft timePerFrame:ANIMATION_TIME_PER_FRAME];
    self.idleLeftAnimation = [SKAction repeatActionForever:temp3];
    
    for (int i = 0; i < 6; i++) {
        NSString *string = [NSString stringWithFormat:@"enterprise_right%d", i];
        SKTexture *texture = [self.idleAtlas textureNamed:string];
        texture.filteringMode = SKTextureFilteringNearest;
        [self.idleRight addObject:texture];
    }
    
    SKAction *temp4 = [SKAction animateWithTextures:self.idleRight timePerFrame:ANIMATION_TIME_PER_FRAME];
    self.idleRightAnimation = [SKAction repeatActionForever:temp4];
    
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
    
    //self.sprite.texture = [SKTexture textureWithImageNamed:@"ship"];
    self.sprite.texture.filteringMode = SKTextureFilteringNearest;
    self.sprite.size = CGSizeMake(64, 96);
    [self.sprite removeAllActions];
    [self.sprite runAction:self.idleDownAnimation];
}

- (void)changeTextureToSouth
{
    self.sprite.size = CGSizeMake(64, 96);
    
//    self.sprite.texture = [SKTexture textureWithImageNamed:@"ship_north"];
    self.sprite.texture.filteringMode = SKTextureFilteringNearest;
    [self.sprite removeAllActions];
    [self.sprite runAction:self.idleUpAnimation];
}

- (void)changeTextureToWest
{
    self.sprite.size = CGSizeMake(96, 64);
//    self.sprite.texture = [SKTexture textureWithImageNamed:@"ship_right"];
    self.sprite.texture.filteringMode = SKTextureFilteringNearest;
    [self.sprite removeAllActions];
    [self.sprite runAction:self.idleRightAnimation];
}

- (void)changeTextureToEast
{
    self.sprite.size = CGSizeMake(96, 64);
//    self.sprite.texture = [SKTexture textureWithImageNamed:@"ship_left"];
    self.sprite.texture.filteringMode = SKTextureFilteringNearest;
    [self.sprite removeAllActions];
    [self.sprite runAction:self.idleLeftAnimation];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"Velocity: %f, %f; sprite: %@", self.velocity.x, self.velocity.y, self.sprite];
}

@end