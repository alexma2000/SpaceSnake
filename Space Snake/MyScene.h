//
//  MyScene.h
//  Space Snake
//

//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class Snake;
@interface MyScene : SKScene

@property (strong, nonatomic) Snake *playerSnake;

@property CFTimeInterval lastTime;
@property (strong, nonatomic) SKSpriteNode *background;

@end
