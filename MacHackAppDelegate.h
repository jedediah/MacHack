//
//  MacHackAppDelegate.h
//  MacHack
//
//  Created by Jedediah Smith on 11-01-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <ApplicationServices/ApplicationServices.h>
#import "KeyFilter.h"
#import "Console.h"

@interface MacHackAppDelegate : NSObject <NSApplicationDelegate,
                                          NSWindowDelegate,
                                          Console> {
  NSWindow *window;
  
  NSStatusItem *statusItem;
  
  NSMenuItem* itemEnable;
  NSMenuItem* itemConsole;
  NSMenuItem* itemQuit;
  
  KeyFilter* keyFilter;

  NSWindow* consoleWindow;
  NSTextView* console;
}

-(void)toggleKeyFilter;
-(void)enableKeyFilter;
-(void)disableKeyFilter;

-(void)hideConsole;
-(void)showConsole;

-(void)printToConsole:(NSString *)format, ...;

@property (assign) IBOutlet NSWindow *window;

@end
