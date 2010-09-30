//
//  FSTableController.m
//  FSTestAPI
//
//  Created by FI$H 2000 on 3/24/10.
//  Copyright 2010 Objects In Space And Time, LLC. All rights reserved.
//

#import "FSTableController.h"


@implementation FSTableController

@synthesize tableID;
@synthesize tableData;


- (void)awakeFromNib {
}

- (IBAction)addAtSelectedRow:(id)sender {
}

- (IBAction)deleteSelectedRow:(id)sender {
	
}

- (int)numberOfRowsInTableView:(NSTableView *)table {
	return 0;
}

- (id)tableView:(NSTableView *)table objectForColumn:(NSTableColumn *)column row:(int)rowidx {
	return nil;
}

- (void)tableView:(NSTableView *)table setObject:(id)tobj forColumn:(NSTableColumn *)column row:(int)rowidx {
}


@end
