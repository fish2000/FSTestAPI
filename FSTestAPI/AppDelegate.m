//
//  AppDelegate.m
//  FSTestAPI
//
//  Created by FI$H 2000 on 3/23/10.
//  Copyright 2010 Objects In Space And Time, LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "FSTestAPIOperation.h"


@implementation AppDelegate

static AppDelegate *shared;
static NSString *endpt;



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
	
	if (whatwegot) {
		
		NSLog(@"About to check status...");
		if ([[whatwegot objectForKey:@"status"] isEqualToString:@"ok"]) {
			NSLog(@"status ok");
			
			NSString *outout = @"(nothing)";
			NSDictionary *fsdataset = nil;
			NSDictionary *fsdata = [[NSDictionary alloc] initWithDictionary:[[whatwegot
																			 objectForKey:@"data"] retain]];
			
			NSLog(@"About to check for dataset...");
			if (!([[fsdata objectForKey:@"dataset"] isEqualTo:@"None"])) {
				fsdataset = [[[NSDictionary alloc] initWithDictionary:[fsdata objectForKey:@"dataset"]] retain];
				NSLog(@"Formatting output string with dataset...");
				outout = [NSString stringWithFormat:@"%@ (%@) [OK]",
						  [fsdataset objectForKey:@"title"],
						  [fsdataset objectForKey:@"author"]];
			} else {
				fsdataset = [[[NSDictionary alloc] initWithDictionary:[fsdata objectForKey:@"isbndbset"]] retain];
				NSLog(@"Formatting output string with isbndbset...");
				outout = [NSString stringWithFormat:@"%@ (%@) [OK]",
						  [fsdataset objectForKey:@"title"],
						  [fsdataset objectForKey:@"authors"]];
			}
			
			
			
			if (fsdataset) {
				[fsdataset release];
			}
			if (fsdata) {
				[fsdata release];
			}
		
			[self output:outout];
		} else {
			NSLog(@"WTF: status wasn't ok");
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
