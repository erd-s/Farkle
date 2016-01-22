//
//  DieLabel.m
//  Yahtzee
//
//  Created by Chris Erdos on 1/21/16.
//  Copyright © 2016 Chris Erdos. All rights reserved.
//

#import "DieLabel.h"
#import "GameViewController.h"

@interface DieLabel () <UIGestureRecognizerDelegate>
@end


@implementation DieLabel

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	self.yOrN = [NSString new];
	if (self) {
		self.yOrN = @"n";
		self.userInteractionEnabled = YES;
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
		self.gestureRecognizers = @[tap];
		tap.delegate = self;
		self.font = [UIFont fontWithName:@"Dice" size:60];
	}
return self;
}



-(void)tapHandler:(UIGestureRecognizer *)gestureRecognizer {
	
	if ([self.yOrN isEqualToString:@"y"]) {
		self.yOrN = @"n";
	} else {
		self.yOrN = @"y";
	}
	[self.delegate DieLabel:self onSelectStateDidChange:self.yOrN];
}

-(void)rollDie {
	self.text = [NSString stringWithFormat:@"%d", (rand() % 6) + 1];
}


@end
