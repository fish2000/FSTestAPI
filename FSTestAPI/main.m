//
//  main.m
//  FSTestAPI
//
//  Created by FI$H 2000 on 3/23/10.
//  Copyright Objects In Space And Time, LLC 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

int main(int argc, char *argv[]) {
	
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = NSApplicationMain(argc,  (const char **) argv);
    [pool release];
    return retVal;
	
	 
    //return NSApplicationMain(argc,  (const char **) argv);
}
