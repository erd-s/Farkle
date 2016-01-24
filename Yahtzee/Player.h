//
//  Player.h
//  Yahtzee
//
//  Created by Chris Erdos on 1/22/16.
//  Copyright © 2016 Chris Erdos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property NSString *name;
@property NSUInteger score;
@property NSUInteger turnsTaken;

@end
