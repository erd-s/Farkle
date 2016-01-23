//
//  GameViewController.m
//  Yahtzee
//
//  Created by Chris Erdos on 1/21/16.
//  Copyright © 2016 Chris Erdos. All rights reserved.
//

#import "GameViewController.h"
#import "DieLabel.h"

@interface GameViewController () <DieLabelDelegate>
@property (weak, nonatomic) IBOutlet DieLabel *dieOne;
@property (weak, nonatomic) IBOutlet DieLabel *dieTwo;
@property (weak, nonatomic) IBOutlet DieLabel *dieThree;
@property (weak, nonatomic) IBOutlet DieLabel *dieFour;
@property (weak, nonatomic) IBOutlet DieLabel *dieFive;
@property (weak, nonatomic) IBOutlet DieLabel *dieSix;
@property (weak, nonatomic) IBOutlet UILabel *playerScore;
@property (weak, nonatomic) IBOutlet UILabel *bank;
@property NSMutableArray *diceArray;
@property NSMutableArray *arrayWithOnes;
@property NSMutableArray *arrayWithTwos;
@property NSMutableArray *arrayWithThrees;
@property NSMutableArray *arrayWithFours;
@property NSMutableArray *arrayWithFives;
@property NSMutableArray *arrayWithSixes;
@property int turnNumber;
@property NSUInteger points;
@property NSUInteger pointsHolderOne;
@property NSUInteger pointsHolderTwo;
@property NSUInteger bankedPoints;
@end

@implementation GameViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.diceArray = [NSMutableArray arrayWithObjects:self.dieOne, self.dieTwo, self.dieThree, self.dieFour, self.dieFive, self.dieSix, nil];
	for (DieLabel *die in self.diceArray) {
		die.delegate = self;
		self.turnNumber = 0;
	}
	
	self.arrayWithOnes = [NSMutableArray new];
	self.arrayWithTwos = [NSMutableArray new];
	self.arrayWithThrees = [NSMutableArray new];
	self.arrayWithFours = [NSMutableArray new];
	self.arrayWithFives = [NSMutableArray new];
	self.arrayWithSixes = [NSMutableArray new];
	NSLog(@"%lu", (unsigned long)self.bankedPoints);
	self.pointsHolderOne = 0;
	self.pointsHolderTwo = 0;
}

- (IBAction)onRollTouchedUpInside:(UIButton *)sender {
	self.turnNumber = self.turnNumber + 1;
	for (DieLabel *die in self.diceArray) {
		if ([die.yOrN  isEqual: @"n"]) {
			[die rollDie];
		}
	}
	for (DieLabel *die in self.diceArray) {
		if (([die.yOrN isEqualToString:@"y"]) && (die.locked == NO)) {
			die.locked = YES;
		}
	}
	[self removeObjectsInArrayWithCounts];
	self.pointsHolderTwo = self.pointsHolderTwo + self.pointsHolderOne;
	self.bank.text = [NSString stringWithFormat:@"Bank: %lu", self.pointsHolderTwo];
	self.playerScore.text = @"Current Score: 0";
	[self checkFarkle];
}


-(void)DieLabel:(id)die onSelectStateDidChange:(NSString *)stateString {
	[self removeObjectsInArrayWithCounts];

		if (self.turnNumber == 0) {
			for (DieLabel *die in self.diceArray) {
			die.yOrN = @"n";
		}
		return;
	} else if (self.turnNumber >= 1){
		for (DieLabel *die in self.diceArray) {
			if ([die.yOrN isEqualToString:@"y"]) {
				die.backgroundColor = [UIColor redColor];
				
				}
				else {
				die.backgroundColor = [UIColor clearColor];
		}
	}
}
	[self checkWins];
	self.playerScore.text = [NSString stringWithFormat:@"Current Score:%lu", self.points];
	self.pointsHolderOne = self.points;
	
}

-(void) checkWins {
	self.points = 0;

	for (DieLabel *die in self.diceArray) {
		if ([die.yOrN isEqualToString:@"y"] && die.locked == NO) {
				if ([die.text isEqualToString:@"1"]) {
				[self.arrayWithOnes addObject:die];
			}	else if ([die.text isEqualToString:@"2"]) {
				[self.arrayWithTwos addObject:die];
			}	else if ([die.text isEqualToString:@"3"]) {
				[self.arrayWithThrees addObject:die];
			}	else if ([die.text isEqualToString:@"4"]) {
				[self.arrayWithFours addObject:die];
			}	else if ([die.text isEqualToString:@"5"]) {
				[self.arrayWithFives addObject:die];
			}	else if ([die.text isEqualToString:@"6"]) {
				[self.arrayWithSixes addObject:die];
			}
	}
	}

	NSUInteger ones = self.arrayWithOnes.count;
	NSUInteger twos = self.arrayWithTwos.count;
	NSUInteger threes = self.arrayWithThrees.count;
	NSUInteger fours = self.arrayWithFours.count;
	NSUInteger fives = self.arrayWithFives.count;
	NSUInteger sixes = self.arrayWithSixes.count;

	if (	(ones == 3 && twos == 3)
		||	(ones == 3 && threes == 3)
		||	(ones == 3 && fours == 3)
		||	(ones == 3 && fives == 3)
		||	(ones == 3 && sixes == 3)
		||	(twos == 3 && threes == 3)
		||	(twos == 3 && fours == 3)
		||	(twos == 3 && fives == 3)
		||	(twos == 3 && sixes == 3)
		||	(threes == 3 && fours == 3)
		||	(threes == 3 && fives == 3)
		||	(threes == 3 && sixes == 3)
		||	(fours == 3 && fives == 3)
		||	(fours == 3 && fives == 3)
		||	(fives == 3 && sixes == 3)) { self.points = self.points + 2500;}
	
//if 1-6 straight
	else if (ones == 1 && twos == 1 && threes == 1 && fours == 1 && fives == 1 && sixes == 1) {self.points = self.points + 1500;
		NSLog(@"This is a 1-6 straight");}
	
//four of any number with a pair
	else if ((ones == 4 && twos == 2)
		|| (ones == 4 && threes == 2)
		|| (ones == 4 && fours == 2)
		|| (ones == 4 && fives == 2)
		|| (ones == 4 && sixes == 2)
		|| (twos == 4 && ones == 2)
		|| (twos == 4 && threes == 2)
		|| (twos == 4 && fours == 2)
		|| (twos == 4 && fives == 2)
		|| (twos == 4 && sixes == 2)
		|| (threes == 4 && ones == 2)
		|| (threes == 4 && twos == 2)
		|| (threes == 4 && fours == 2)
		|| (threes == 4 && fives == 2)
		|| (threes == 4 && sixes == 2)
		|| (fours == 4 && ones == 2)
		|| (fours == 4 && twos == 2)
		|| (fours == 4 && threes == 2)
		|| (fours == 4 && fives == 2)
		|| (fours == 4 && sixes == 2)
		|| (fives == 4 && ones == 2)
		|| (fives == 4 && twos == 2)
		|| (fives == 4 && threes == 2)
		|| (fives == 4 && fours == 2)
		|| (fives == 4 && sixes == 2)
		|| (sixes == 4 && ones == 2)
		|| (sixes == 4 && twos == 2)
		|| (sixes == 4 && threes == 2)
		|| (sixes == 4 && fours == 2)
		|| (sixes == 4 && fives == 2)) {self.points = self.points + 2500;
	NSLog(@"This is four numbers and a pair");}

	//if three pairs
	else if (    (ones == 2 && twos == 2 && threes == 2)
		||    (ones == 2 && threes == 2 && fours == 2)
		||    (ones == 2 && fours == 2 && fives == 2)
		||    (ones == 2 && fives == 2 && sixes == 2)
		||    (ones == 2 && threes == 2 && fives == 2)
		||    (ones == 2 && threes == 2 && sixes == 2)
		||    (ones == 2 && twos == 2 && fours == 2)
		||    (ones == 2 && twos == 2 && fives == 2)
		||    (ones == 2 && sixes == 2 && fours == 2)
		||    (ones == 2 && twos == 2 && sixes == 2)
		||    (twos == 2 && threes == 2 && fours ==2)
		||    (twos == 2 && fours == 2 && fives ==2)
		||    (twos == 2 && fives == 2 && sixes ==2)
		||    (twos == 2 && sixes == 2 && fours ==2)
		||    (twos == 2 && fives == 2 && threes ==2)
		||    (threes == 2 && fours == 2 && fives ==2)
		||    (threes == 2 && fives == 2 && sixes ==2)
		||    (threes == 2 && sixes == 2 && fours ==2)
		||    (fours == 2 && fives == 2 && sixes ==2)) { self.points = self.points + 1500;
	NSLog(@"This is three pairs");}
	
// groups of triples, quads, fives, or sixes
	else {
	if (sixes == 1) {self.points = self.points + 0; }
	else if (sixes == 2) {self.points = self.points + 0;}
	else if (sixes == 3) {self.points = self.points + 600;}
	else if (sixes == 4) {self.points = self.points + 1000;}
	else if (sixes == 5) {self.points = self.points + 2000;}
	else if (sixes == 6) {self.points = self.points + 3000;}

	if (fives == 1) {self.points = self.points + 50;}
	else if (fives == 2) {self.points = self.points + 0;}
	else if (fives == 3) {self.points = self.points + 500;}
	else if (fives == 4) {self.points = self.points + 1000;}
	else if (fives == 5) {self.points = self.points + 2000;}
	else if (fives == 6) {self.points = self.points + 3000;}
		
	if (fours == 1) {self.points = self.points + 0;}
	else if (fours == 2) {self.points = self.points + 0;}
	else if (fours == 3) {self.points = self.points + 400;}
	else if (fours == 4) {self.points = self.points + 1000;}
	else if (fours == 5) {self.points = self.points + 2000;}
	else if (fours == 6) {self.points = self.points + 3000;}

	if (ones == 1) {self.points = self.points + 100;}
	else if (ones == 2) {self.points = self.points + 0;}
	else if (ones == 3) {self.points = self.points + 300;}
	else if (ones == 4) {self.points = self.points + 1000;}
	else if (ones == 5) {self.points = self.points + 2000;}
	else if (ones == 6) {self.points = self.points + 3000;}
	
	if (twos == 1) {self.points = self.points + 0;}
	else if (twos == 2) {self.points = self.points + 0;}
	else if (twos == 3) {self.points = self.points + 200;}
	else if (twos == 4) {self.points = self.points + 1000;}
	else if (twos == 5) {self.points = self.points + 2000;}
	else if (twos == 6) {self.points = self.points + 3000;}

	if (threes == 1) {self.points = self.points + 0;}
	else if (threes == 2) {self.points = self.points + 0;}
	else if (threes == 3) {self.points = self.points + 300;}
	else if (threes == 4) {self.points = self.points + 1000;}
	else if (threes == 5) {self.points = self.points + 2000;}
	else if (threes == 6) {self.points = self.points + 3000;}
}
	
	
}


-(void) checkFarkle {
	
	for (DieLabel *die in self.diceArray) {
		if (die.locked == NO) {
			if ([die.text isEqualToString:@"1"]) {
				[self.arrayWithOnes addObject:die];
			}	else if ([die.text isEqualToString:@"2"]) {
				[self.arrayWithTwos addObject:die];
			}	else if ([die.text isEqualToString:@"3"]) {
				[self.arrayWithThrees addObject:die];
			}	else if ([die.text isEqualToString:@"4"]) {
				[self.arrayWithFours addObject:die];
			}	else if ([die.text isEqualToString:@"5"]) {
				[self.arrayWithFives addObject:die];
			}	else if ([die.text isEqualToString:@"6"]) {
				[self.arrayWithSixes addObject:die];
			}
		}
	}
	NSUInteger ones = self.arrayWithOnes.count;
	NSUInteger twos = self.arrayWithTwos.count;
	NSUInteger threes = self.arrayWithThrees.count;
	NSUInteger fours = self.arrayWithFours.count;
	NSUInteger fives = self.arrayWithFives.count;
	NSUInteger sixes = self.arrayWithSixes.count;
	
	if (	(ones == 3 && twos == 3)
		||	(ones == 3 && threes == 3)
		||	(ones == 3 && fours == 3)
		||	(ones == 3 && fives == 3)
		||	(ones == 3 && sixes == 3)
		||	(twos == 3 && threes == 3)
		||	(twos == 3 && fours == 3)
		||	(twos == 3 && fives == 3)
		||	(twos == 3 && sixes == 3)
		||	(threes == 3 && fours == 3)
		||	(threes == 3 && fives == 3)
		||	(threes == 3 && sixes == 3)
		||	(fours == 3 && fives == 3)
		||	(fours == 3 && fives == 3)
		||	(fives == 3 && sixes == 3)){ }
	else if (ones == 1 && twos == 1 && threes == 1 && fours == 1 && fives == 1 && sixes == 1) {}
	else if ((ones == 4 && twos == 2)
			 || (ones == 4 && threes == 2)
			 || (ones == 4 && fours == 2)
			 || (ones == 4 && fives == 2)
			 || (ones == 4 && sixes == 2)
			 || (twos == 4 && ones == 2)
			 || (twos == 4 && threes == 2)
			 || (twos == 4 && fours == 2)
			 || (twos == 4 && fives == 2)
			 || (twos == 4 && sixes == 2)
			 || (threes == 4 && ones == 2)
			 || (threes == 4 && twos == 2)
			 || (threes == 4 && fours == 2)
			 || (threes == 4 && fives == 2)
			 || (threes == 4 && sixes == 2)
			 || (fours == 4 && ones == 2)
			 || (fours == 4 && twos == 2)
			 || (fours == 4 && threes == 2)
			 || (fours == 4 && fives == 2)
			 || (fours == 4 && sixes == 2)
			 || (fives == 4 && ones == 2)
			 || (fives == 4 && twos == 2)
			 || (fives == 4 && threes == 2)
			 || (fives == 4 && fours == 2)
			 || (fives == 4 && sixes == 2)
			 || (sixes == 4 && ones == 2)
			 || (sixes == 4 && twos == 2)
			 || (sixes == 4 && threes == 2)
			 || (sixes == 4 && fours == 2)
			 || (sixes == 4 && fives == 2)) { }
		else if (    (ones == 2 && twos == 2 && threes == 2)
			 ||    (ones == 2 && threes == 2 && fours == 2)
			 ||    (ones == 2 && fours == 2 && fives == 2)
			 ||    (ones == 2 && fives == 2 && sixes == 2)
			 ||    (ones == 2 && threes == 2 && fives == 2)
			 ||    (ones == 2 && threes == 2 && sixes == 2)
			 ||    (ones == 2 && twos == 2 && fours == 2)
			 ||    (ones == 2 && twos == 2 && fives == 2)
			 ||    (ones == 2 && sixes == 2 && fours == 2)
			 ||    (ones == 2 && twos == 2 && sixes == 2)
			 ||    (twos == 2 && threes == 2 && fours ==2)
			 ||    (twos == 2 && fours == 2 && fives ==2)
			 ||    (twos == 2 && fives == 2 && sixes ==2)
			 ||    (twos == 2 && sixes == 2 && fours ==2)
			 ||    (twos == 2 && fives == 2 && threes ==2)
			 ||    (threes == 2 && fours == 2 && fives ==2)
			 ||    (threes == 2 && fives == 2 && sixes ==2)
			 ||    (threes == 2 && sixes == 2 && fours ==2)
			 ||    (fours == 2 && fives == 2 && sixes ==2)) {}

		else if (sixes == 3) {}
		else if (sixes == 4) {}
		else if (sixes == 5) {}
		else if (sixes == 6) {}
		
		else if (fives == 1) {}
		else if (fives == 3) {}
		else if (fives == 4) {}
		else if (fives == 5) {}
		else if (fives == 6) {}
		

		else if (fours == 3) {}
		else if (fours == 4) {}
		else if (fours == 5) {}
		else if (fours == 6) {}
		
		else if (ones == 1) {}
		else if (ones == 3) {}
		else if (ones == 4) {}
		else if (ones == 5) {}
		else if (ones == 6) {}
		

		else if (twos == 3) {}
		else if (twos == 4) {}
		else if (twos == 5) {}
		else if (twos == 6) {}
		

		else if (threes == 3) {}
		else if (threes == 4) {}
		else if (threes == 5) {}
		else if (threes == 6) {}
		
		
		else { NSLog(@"You Farkled!");}
	}

-(void) removeObjectsInArrayWithCounts {
	[self.arrayWithOnes removeAllObjects];
	[self.arrayWithTwos removeAllObjects];
	[self.arrayWithThrees removeAllObjects];
	[self.arrayWithFours removeAllObjects];
	[self.arrayWithFives removeAllObjects];
	[self.arrayWithSixes removeAllObjects];
}









@end
