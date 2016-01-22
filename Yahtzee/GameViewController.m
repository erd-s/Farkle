//
//  GameViewController.m
//  Yahtzee
//
//  Created by Chris Erdos on 1/21/16.
//  Copyright © 2016 Chris Erdos. All rights reserved.
//

#import "GameViewController.h"
#import "DieLabel.h"

@interface GameViewController () <DieLabelDelate>
@property (weak, nonatomic) IBOutlet DieLabel *dieOne;
@property (weak, nonatomic) IBOutlet DieLabel *dieTwo;
@property (weak, nonatomic) IBOutlet DieLabel *dieThree;
@property (weak, nonatomic) IBOutlet DieLabel *dieFour;
@property (weak, nonatomic) IBOutlet DieLabel *dieFive;
@property (weak, nonatomic) IBOutlet DieLabel *dieSix;
@property (weak, nonatomic) IBOutlet UILabel *playerScore;
@property NSMutableArray *diceArray;
@property NSMutableArray *arrayWithUnselectedDice;
@property NSMutableArray *arrayWithSelectedDice;
@property int turnNumber;
@end

@implementation GameViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.diceArray = [NSMutableArray arrayWithObjects:self.dieOne, self.dieTwo, self.dieThree, self.dieFour, self.dieFive, self.dieSix, nil];
	for (DieLabel *die in self.diceArray) {
		die.delegate = self;
		self.turnNumber = 0;
	}
	self.arrayWithUnselectedDice = [NSMutableArray new];
	self.arrayWithSelectedDice = [NSMutableArray new];

}

- (IBAction)onRollTouchedUpInside:(UIButton *)sender {
	self.turnNumber = self.turnNumber + 1;
	for (DieLabel *die in self.diceArray) {
		if ([die.yOrN  isEqual: @"n"]) {
			[die rollDie];
		}
	}
	for (DieLabel *die in self.arrayWithSelectedDice) {
		die.locked = YES;
	}
}


-(void)DieLabel:(id)die onSelectStateDidChange:(NSString *)stateString {
	[self.arrayWithUnselectedDice removeAllObjects];														//array with unselected dice has to be emptied & refilled each selection
	[self.arrayWithSelectedDice removeAllObjects];
	if (self.turnNumber == 0) {																				//turn number 0, must roll all dice
		for (DieLabel *die in self.diceArray) {
			die.yOrN = @"n";
		}
		return;
	} else if (self.turnNumber >= 1){
		for (DieLabel *die in self.diceArray) {
			if ([die.yOrN isEqualToString:@"y"]) {
				die.backgroundColor = [UIColor redColor];
				[self.arrayWithSelectedDice addObject:die];
			} else {
				die.backgroundColor = [UIColor clearColor];
				[self.arrayWithUnselectedDice addObject:die];
			}
		}
		
}
}


@end
