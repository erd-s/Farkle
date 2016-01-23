//
//  DieLabel.h
//  Yahtzee
//
//  Created by Chris Erdos on 1/21/16.
//  Copyright © 2016 Chris Erdos. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DieLabelDelegate <NSObject>

-(void)DieLabel:(id)die onSelectStateDidChange:(NSString *)stateString;

@end

@interface DieLabel : UILabel
@property NSString *yOrN;
@property (nonatomic, assign) id <DieLabelDelegate> delegate;
@property BOOL locked;



-(void)rollDie;

@end
