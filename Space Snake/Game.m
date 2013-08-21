//
//  Game.m
//  Space Snake
//
//  Created by Dmitry Volevodz on 21.08.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import "Game.h"
#import "Snake.h"

@implementation Game

+ (Game *)sharedGame
{
    static Game *sharedGame;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedGame = [[Game alloc] init];
    });
   
    return sharedGame;
}

- (void) makeNewPlayerSnake
{
    self.playerSnake = [[Snake alloc] init];
}



@end
