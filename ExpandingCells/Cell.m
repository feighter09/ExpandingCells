//
//  Cell.m
//  ExpandingCells
//
//  Created by work on 1/7/13.
//  Copyright (c) 2013 sbyrd. All rights reserved.
//

#import "Cell.h"

@implementation Cell

-(int)getHeight {
	return [self frame].size.height;
}

-(void)expand {
  CGRect oldFrame = [self frame];
  _height = _usersTable.contentSize.height + 44;
  
  [self setFrame:CGRectMake(	oldFrame.origin.x,
                            oldFrame.origin.y,
                            oldFrame.size.width,
                            _height)];
}

-(void)contract {
	CGRect oldFrame = [self frame];
	_height = 44;
  
	[self setFrame:CGRectMake(  oldFrame.origin.x,
                            oldFrame.origin.y,
                            oldFrame.size.width,
                            _height)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
}

- (void)setUsers:(NSMutableArray *)users {
  _users = users;
  [_usersTable setDataSource:self];
  [_usersTable setScrollEnabled:NO];
  [_usersTable reloadData];
}

#pragma mark - Table View DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
  
  NSString *name = [[_users objectAtIndex:indexPath.row] objectForKey:@"name"];
  NSString *val = [[_users objectAtIndex:indexPath.row] objectForKey:@"value"];
  
  [cell.textLabel setText:name];
  [cell.detailTextLabel setText:val];
  
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_users count];
}

@end
