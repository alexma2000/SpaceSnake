//
//  MyScene.m
//  Space Snake
//
//  Created by Dmitry Volevodz on 21.08.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import "MyScene.h"
#import "Snake.h"
#import "Game.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        [self performSelector:@selector(addElementToSnake) withObject:self afterDelay:2.0];
    }
    return self;
}

- (void) addElementToSnake
{
    SnakeElement *second = [[SnakeElement alloc] initWithType:kShipTypePlayer];
    [self.playerSnake addElement:second];
    [self addChild:second.sprite];
}

-(void) didMoveToView:(SKView *)view
{
//    self.background = [[SKSpriteNode alloc] initWithImageNamed:@"iceAsteroidsBackground.jpg"];
//    self.background.position = CGPointMake(512, 384);
//    [self addChild:self.background];
    
    [[Game sharedGame] makeNewPlayerSnake];
    self.playerSnake = [Game sharedGame].playerSnake;
    [self addChild:self.playerSnake.head.sprite];
    
    self.playerSnake.head.sprite.position = CGPointMake(512, 380);
    
    UISwipeGestureRecognizer *swipeEastwards = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleEastRecognizer:)];
    [view addGestureRecognizer: swipeEastwards];
    
    UISwipeGestureRecognizer *swipeUpwards = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleNorthRecognizer:)];
    swipeUpwards.direction = UISwipeGestureRecognizerDirectionUp;
    [view addGestureRecognizer: swipeUpwards];
    
    UISwipeGestureRecognizer *swipeDownwards = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSouthRecognizer:)];
    swipeDownwards.direction = UISwipeGestureRecognizerDirectionDown;
    [view addGestureRecognizer: swipeDownwards];
    
    UISwipeGestureRecognizer *swipeWestwards = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleWestRecognizer:)];
    swipeWestwards.direction = UISwipeGestureRecognizerDirectionLeft;
    [view addGestureRecognizer: swipeWestwards];
    
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(spawnNewSnake)];
    [tapper setNumberOfTouchesRequired:2];
    [view addGestureRecognizer:tapper];
}

- (void) spawnNewSnake {
    
    self.playerSnake.head.sprite.position = CGPointMake(512, 380);
}

// all recognizers are retarded with wrong coordinates

- (void) handleEastRecognizer:(UIGestureRecognizer *)sender
{
    NSLog(@"Swipe east detected!");
    
    if (self.playerSnake.velocity.x != 0) {
        return;
    }
    
    self.playerSnake.velocity = CGPointMake(-abs(self.playerSnake.velocity.y), 0);

    SKAction *action = [SKAction rotateToAngle:1.570796 duration:0.2 shortestUnitArc:YES];
    [self.playerSnake.head.sprite runAction:action];
}

- (void) handleWestRecognizer:(UIGestureRecognizer *)sender
{
    NSLog(@"Swipe west detected!");
    
    if (self.playerSnake.velocity.x != 0 ) {
        return;
    }
    
    self.playerSnake.velocity = CGPointMake(abs(self.playerSnake.velocity.y), 0);

    SKAction *action = [SKAction rotateToAngle:-1.570796 duration:0.2 shortestUnitArc:YES];
    [self.playerSnake.head.sprite runAction:action];
}



- (void) handleNorthRecognizer:(UIGestureRecognizer *)sender
{
    NSLog(@"Swipe north detected!");
    
    if (self.playerSnake.velocity.y != 0) {
        return;
    }
    
    self.playerSnake.velocity = CGPointMake(0, -abs(self.playerSnake.velocity.x));

    
    SKAction *action = [SKAction rotateToAngle:3.14 duration:0.2 shortestUnitArc:YES];
    [self.playerSnake.head.sprite runAction:action];
}



- (void) handleSouthRecognizer:(UIGestureRecognizer *)sender
{
    NSLog(@"Swipe south detected!");
    
    if (self.playerSnake.velocity.y != 0) {
        return;
    }
    
    self.playerSnake.velocity = CGPointMake(0, abs(self.playerSnake.velocity.x));

    SKAction *action = [SKAction rotateToAngle:0.0 duration:0.2 shortestUnitArc:YES];
    [self.playerSnake.head.sprite runAction:action];

}

-(void)update:(CFTimeInterval)currentTime {
    
    if (!self.lastTime) {
        self.lastTime = currentTime;
        return;
    }
    
    
    CFTimeInterval delta = self.lastTime - currentTime;
    
    CGPoint currentPosition = self.playerSnake.head.sprite.position;
    CGPoint velocity = self.playerSnake.velocity;
    
    self.playerSnake.head.sprite.position = CGPointMake(currentPosition.x + velocity.x * delta * CONSTANTSPEEDFACTOR , currentPosition.y + velocity.y * delta * CONSTANTSPEEDFACTOR);
    
    for (SnakeElement *element in self.playerSnake.elements) {
        
        CGPoint currentPositionE = element.sprite.position;
        CGPoint velocityE = element.velocity;
        
        element.sprite.position = CGPointMake(currentPositionE.x + velocityE.x * delta * CONSTANTSPEEDFACTOR , currentPositionE.y + velocityE.y * delta * CONSTANTSPEEDFACTOR);
    }
    
    for (NSDictionary *dict in self.playerSnake.rotationPoints) {
        
        CGPoint positionCoordinate = CGPointFromString(dict[@"position"]);
        CGPoint velocityNew = CGPointFromString(dict[@"velocity"]);
        
        for (SnakeElement *element in self.playerSnake.elements) {
            
            int xDifference = element.sprite.position.x - positionCoordinate.x;
            int yDifference = element.sprite.position.y - positionCoordinate.y;
            
            if ((xDifference > -2 && xDifference < 2) && (yDifference > -2 && yDifference < 2)   ) {
                
                element.velocity = velocityNew;
                element.sprite.position = CGPointMake(element.sprite.position.x + xDifference, element.sprite.position.y + yDifference);
                SKAction *action = [SKAction rotateToAngle:self.playerSnake.head.sprite.zRotation duration:0.2 shortestUnitArc:YES];
                [element.sprite runAction:action];
            }
        }
    }
    
    self.lastTime = currentTime;
}


//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    /* Called when a touch begins */
//
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"playerShip.png"];
//
//        sprite.position = location;
//
//        SKAction *action = [SKAction moveTo:CGPointMake(arc4random() % 300, arc4random() % 300) duration:0.5];
//        [sprite runAction:[SKAction repeatActionForever:action]];
//
//        [self addChild:sprite];
//    }
//}

@end
