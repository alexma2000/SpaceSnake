//
//  SnakeElement.h
//  Space Snake
//
//  Created by Dmitry Volevodz on 21.08.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, kElementHeading)
{
    kElementHeadingNorth = 1,
    kElementHeadingSouth,
    kElementHeadingEast,
    kElementHeadingWest
};

#define ANIMATION_TIME_PER_FRAME 0.15


@interface SnakeElement : NSObject

@property (strong, nonatomic) SKSpriteNode *sprite;
@property (nonatomic) int heading;
@property SnakeElement *elementInFront;
@property CGPoint velocity;
@property NSInteger type;

- (id) initWithType:(NSInteger) type;

- (void)changeTextureToVertical;
- (void)changeTextureToHorizontal;

@end
