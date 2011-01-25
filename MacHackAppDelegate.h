//
//  MacHackAppDelegate.h
//  MacHack
//
//  Created by Jedediah Smith on 11-01-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <ApplicationServices/ApplicationServices.h>
#include "KeyFilter.h"

@interface MacHackAppDelegate : NSObject <NSApplicationDelegate> {
  NSWindow *window;
  
  NSStatusItem *statusItem;
  
  NSMenuItem* itemOn;
  NSMenuItem* itemOff;
  NSMenuItem* itemTest;
  NSMenuItem* itemQuit;
  
  KeyFilter* keyFilter;
}

-(void)enableKeyFilter;
-(void)disableKeyFilter;
-(void)testKeyFilter;

@property (assign) IBOutlet NSWindow *window;

@end
