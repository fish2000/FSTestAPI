//
//  FSTableController.h
//  FSTestAPI
//
//  Created by FI$H 2000 on 3/24/10.
//  Copyright 2010 Objects In Space And Time, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FSTableController : NSObject {
	IBOutlet NSTableView *tableID;
	NSMutableArray *tableData;
}

@property (assign) NSTableView *tableID;
@property (assign) NSMutableArray *tableData;

- (IBAction)addAtSelectedRow:(id)sender;
- (IBAction)deleteSelectedRow:(id)sender;

- (int)numberOfRowsInTableView:(NSTableView *)table;
- (id)tableView:(NSTableView *)table objectForColumn:(NSTableColumn *)column row:(int)rowidx;
- (void)tableView:(NSTableView *)table setObject:(id)tobj forColumn:(NSTableColumn *)column row:(int)rowidx;


@end
