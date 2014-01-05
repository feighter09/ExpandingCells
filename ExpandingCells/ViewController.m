//
//  ViewController.m
//  ExpandingCells
//
//  Created by work on 1/7/13.
//  Copyright (c) 2013 sbyrd. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

static Cell* blankCell = nil;

#pragma mark Data Source Delegate Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
	NSString*	cellName	= [_dataSource objectAtIndex:indexPath.row];
	
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:@"ExpandingCell" owner:self options:nil] objectAtIndex:0];
    [cell setIndex:indexPath.row];
    [cell.cellName setText:cellName];

    NSMutableArray *users = [[NSMutableArray alloc] init];
    for (int i = 0; i < indexPath.row + 1; i++) {
      [users addObject:@{@"name": @"Austin Feight", @"value": @"14"}];
    }
    [cell setUsers:users];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_dataSource count];
}

#pragma mark Table View Delegate Methods

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([indexPath row] == [_selectedCell index]) {
		return [_selectedCell getHeight];
	}
	
	return [blankCell getHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Cell *cell = (Cell*)[tableView cellForRowAtIndexPath:indexPath];
	
	if(_selectedCell.index >= 0) {
		[_selectedCell contract];
	}
	
  if (_selectedCell.index != indexPath.row) {
    [cell expand];
    [self setSelectedCell:cell];
  } else {
    [_selectedCell setIndex:-1];
  }

	[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects: indexPath, nil] withRowAnimation:nil];
}

#pragma mark Initializing

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		[self setDataSource:[NSArray arrayWithObjects:@"cell 0", @"cell 1", @"cell 2", nil]];
		
		//Setting the selected cell value to this blank instance of the custom cell great simplifies the heightForRowAtIndexPath
		//function and lets us avoid needing to hard code any values -- now the height is derived from a nib. This blank instance
		//will go away the first time a cell is selected for real.
		[self setSelectedCell:[[[NSBundle mainBundle] loadNibNamed:@"ExpandingCell" owner:self options:nil] objectAtIndex:0]];
		
		blankCell = _selectedCell;
		
		[blankCell setIndex:-1];
		[blankCell retain];
	}
	
	return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
