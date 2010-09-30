//
//  AppDelegate.h
//  FSTestAPI
//
//  Created by FI$H 2000 on 3/23/10.
//  Copyright 2010 Objects In Space And Time, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
//#import <JSON/JSON.h>

@interface AppDelegate : NSObject {
	IBOutlet NSTextField *outputJSONResults;
	IBOutlet NSTextField *inputISBN;
	IBOutlet NSWindow *window;
	
	NSOperationQueue *queue;
}

+(id)shared;
-(IBAction)sendISBN:(id)sender;
-(void)outputResults:(NSDictionary*)whatwegot;
-(void)outputError:(NSError*)whatwegot;
-(void)output:(NSString*)outputThis;


@end
