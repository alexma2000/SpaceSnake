//
//  SnakeElement.h
//  Space Snake
//
//  Created by Dmitry Volevodz on 21.08.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SnakeElement : NSObject

@property (strong, nonatomic) SKSpriteNode *sprite;
@property NSInteger heading;
@property SnakeElement *elementInFront;
@property CGPoint velocity;
@property NSInteger type;

- (id) initWithType:(NSInteger) type;

@end
