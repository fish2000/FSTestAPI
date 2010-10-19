//
//  FSTestAPIOperation.m
//  FSTestAPI
//
//  Created by FI$H 2000 on 3/23/10.
//  Copyright 2010 Objects In Space And Time, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
//#import <JSON/JSON.h>
//#import "JSON/JSON.h"
#import "JSON/SBJsonParser.h"
#import "AppDelegate.h"
#import "FSTestAPIOperation.h"

@implementation FSTestAPIOperation

@synthesize ISBN;
@synthesize endpt;


- (id)initWithURL:(NSString*)url
		  forISBN:(NSString*)anISBN {
	//NSLog(@"FSTestAPIOperation initWithURL:forISBN");
	if (![super init]) return nil;
	[self setISBN:anISBN];
	[self setEndpt:url];
	
	return self;
}


- (void)dealloc {
	//NSLog(@"FSTestAPIOperation dealloc");
	[endpt release], endpt = nil;
	[ISBN release], ISBN = nil;
	[super dealloc];
}


- (void)main {
	SBJsonParser *json = [SBJsonParser new];
	NSURL *url = [[[NSURL alloc] initWithString:[[self endpt] stringByAppendingString:[self ISBN]]] autorelease];
	
	//NSLog(@"JSON URL: %@", url);
	
	NSError *error = nil;
	NSString *jsonstring = [[[NSString alloc] initWithContentsOfURL:url] autorelease];
	NSDictionary *jsonout = [[[NSDictionary alloc] initWithDictionary:[json objectWithString:jsonstring error:&error]] autorelease];
	
	if (!jsonout) {
		NSLog(@"JSON error: %@", error);
		[[AppDelegate shared] performSelectorOnMainThread:@selector(outputError:)
											   withObject:error
											waitUntilDone:YES];
		[jsonout release];
		[json release];
		return;
	}
	
	[[AppDelegate shared] performSelectorOnMainThread:@selector(outputResults:)
										   withObject:[jsonout copy]
										waitUntilDone:YES];
	
	[jsonout release];
	[json release];
}


@end
