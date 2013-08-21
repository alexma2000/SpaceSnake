//
//  Snake.h
//  Space Snake
//
//  Created by Dmitry Volevodz on 21.08.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnakeElement.h"

@interface Snake : NSObject

@property (strong, nonatomic) NSMutableArray *elements;
@property (strong, nonatomic) SnakeElement *head;

- (CGPoint) velocity;
- (void) setVelocity:(CGPoint)newVelocity;

@end
