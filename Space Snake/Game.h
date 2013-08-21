//
//  Game.h
//  Space Snake
//
//  Created by Dmitry Volevodz on 21.08.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Snake, SnakeElement;

@interface Game : NSObject

@property (strong, nonatomic) Snake *playerSnake;
@property (strong, nonatomic) NSMutableArray *enemySnakes;

+ (Game *)sharedGame;

- (void) makeNewPlayerSnake;

@end
