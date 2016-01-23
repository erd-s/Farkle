//
//  PlayersViewController.m
//  Yahtzee
//
//  Created by Chris Erdos on 1/22/16.
//  Copyright © 2016 Chris Erdos. All rights reserved.
//

#import "PlayersViewController.h"
#import "Player.h"
#import "GameViewController.h"

@interface PlayersViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *playersArray;


@end

@implementation PlayersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.playersArray = [NSMutableArray new];
}

-(void)viewWillAppear:(BOOL)animated {
	[self.tableView reloadData];


}
- (IBAction)onAddButtonTapped:(UIBarButtonItem *)sender {
	Player *player = [Player new];
	UIAlertController *addPlayer = [UIAlertController alertControllerWithTitle:@"Add Player" message:@"Please type player name below." preferredStyle:(UIAlertControllerStyleAlert)];
	[addPlayer addTextFieldWithConfigurationHandler:^(UITextField * textField) {
		textField.placeholder = @"Insert player name.";
	}];
	UIAlertAction *add = [UIAlertAction actionWithTitle:@"Add Player" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		if ([addPlayer.textFields[0].text isEqualToString:@""]) {
		} else {
		player.name = addPlayer.textFields[0].text;
		[self.playersArray addObject:player];
		[self.tableView reloadData];
		}
	}];
	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

	
	
	[addPlayer addAction:add];
	[addPlayer addAction:cancel];
	[addPlayer.view sizeToFit];
	[self presentViewController:addPlayer animated:YES completion:nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	Player *player = [self.playersArray objectAtIndex:indexPath.row];
	
	
	cell.textLabel.text = player.name;
	cell.detailTextLabel.text = [NSString stringWithFormat:@"Score: %lu", (long)player.score];
	
	
	return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.playersArray.count;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	GameViewController *dvc = [segue destinationViewController];
	NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
	
	dvc.player = [self.playersArray objectAtIndex:indexPath.row];
}

-(IBAction) unwind:(UIStoryboardSegue *)segue {
	
}


@end
