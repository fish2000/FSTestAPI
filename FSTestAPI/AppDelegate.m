//
//  AppDelegate.m
//  FSTestAPI
//
//  Created by FI$H 2000 on 3/23/10.
//  Copyright 2010 Objects In Space And Time, LLC. All rights reserved.
//

#import <JSON/JSON.h>
#import "AppDelegate.h"
#import "FSTestAPIOperation.h"


@implementation AppDelegate

static AppDelegate *shared;
static NSString *endpt;


/*
- (void)awakeFromNib {
	NSLog(@"AppDelegate awakeFromNib");
}
*/


- (id)init {
	if (shared) {
		[self autorelease];
		return shared;
	}
	if (![super init]) return nil;
	
	//endpt = @"http://otus-asio.local/api/isbn/"; // local
	endpt = @"http://forsale.objectsinspaceandtime.com/api/isbn/"; // public
	queue = [[NSOperationQueue alloc] init];
	shared = self;
	return self;
}


+ (id)shared {
	if (!shared) {
		[[AppDelegate alloc] init];
	}
	return shared;
}


- (IBAction)sendISBN:(id)sender {
	NSLog(@"AppDelegate sendISBN");
	NSLog(@"%@", [inputISBN stringValue]);
	
	[queue cancelAllOperations];
	FSTestAPIOperation *op = [[FSTestAPIOperation alloc] initWithURL:[[[NSString alloc] initWithString:endpt] autorelease]
															 forISBN:[[[NSString alloc] initWithString:[inputISBN stringValue]] autorelease]
							  ];
	[queue addOperation:op];
}

- (void)outputResults:(NSDictionary*)whatwegot {
	//NSLog(@"AppDelegate outputResults: %@", whatwegot);
	//NSLog(@"Result status type: %@", [[whatwegot objectForKey:@"status"] class]);
	
	if (whatwegot) {
		
		if ([[whatwegot objectForKey:@"status"] isEqualToString:@"ok"]) {
			NSDictionary *fsdataset = [[[NSDictionary alloc]
									  initWithDictionary:[[whatwegot
														   objectForKey:@"data"] objectForKey:@"dataset"]]
									 autorelease];
			
			NSString *outout = [NSString stringWithFormat:@"%@ (%@) [OK]",
			 [fsdataset objectForKey:@"title"],
			 [fsdataset objectForKey:@"author"]];
		
			[self output:outout];
		} else {
			NSDictionary *fsdata = [[[NSDictionary alloc]
									 initWithDictionary:[whatwegot
														 objectForKey:@"data"]]
									autorelease];
			NSString *outout = [NSString stringWithFormat:@"ERROR -- %@ [FAIL]",
								[fsdata objectForKey:@"msg"]];
			
			[self output:outout];
		}
		
	}
	
}

- (void)outputError:(NSError*)whatwegot {
	NSLog(@"AppDelegate outputError");
	
	NSString *whatstr = [[[NSString alloc] initWithFormat:@"ERROR: %@", whatwegot] autorelease]; 
	[outputJSONResults setStringValue: whatstr];
}

- (void)output:(NSString*)outputThis {
	NSLog(@"OUTPUT: %@", outputThis);
	[outputJSONResults setStringValue: outputThis];
}


- (void)dealloc {
	
	NSLog(@"AppDelegate dealloc");
	[queue cancelAllOperations];
	[queue release], queue = nil;
	[super dealloc];
	
}


@end
