//
//  FSTestAPIOperation.h
//  FSTestAPI
//
//  Created by FI$H 2000 on 3/23/10.
//  Copyright 2010 Objects In Space And Time, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <JSON/JSON.h>

@interface FSTestAPIOperation : NSOperation {
	NSString *ISBN;
	NSString *endpt;
}

@property (assign) NSString *ISBN;
@property (assign) NSString *endpt;

- (void)main;
- (id)initWithURL:(NSString*)url
		  forISBN:(NSString*)anISBN;

@end
