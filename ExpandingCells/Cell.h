//
//  Cell.h
//  ExpandingCells
//
//  Created by work on 1/7/13.
//  Copyright (c) 2013 sbyrd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell <UITableViewDataSource>

@property (nonatomic) int index;
@property (nonatomic, strong)	IBOutlet UILabel *cellName;
@property (nonatomic) CGFloat height;

@property (strong, nonatomic) IBOutlet UITableView *usersTable;
@property (strong, nonatomic) NSMutableArray *users;

-(int)getHeight;
-(void)expand;
-(void)contract;

@end
