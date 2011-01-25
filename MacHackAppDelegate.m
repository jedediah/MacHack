//
//  MacHackAppDelegate.m
//  MacHack
//
//  Created by Jedediah Smith on 11-01-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MacHackAppDelegate.h"

@implementation MacHackAppDelegate

@synthesize window;

- (void)enableKeyFilter {
  [keyFilter enable];
  [statusItem setTitle:@"H"];
}

- (void)disableKeyFilter {
  [keyFilter disable];
  [statusItem setTitle:@"h"];
}

- (void)testKeyFilter {
  [statusItem setTitle:@"T"];
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
  if (menuItem == itemOff)
    return [keyFilter isEnabled];

  if (menuItem == itemOn)
    return ![keyFilter isEnabled];
  
  return true;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  
  itemOn = [NSMenuItem allocWithZone:[NSMenu menuZone]];
  [itemOn initWithTitle:@"On"
                   action:@selector(enableKeyFilter)
            keyEquivalent:@""];
  [itemOn setTarget:self];
  
  itemOff = [NSMenuItem allocWithZone:[NSMenu menuZone]];
  [itemOff initWithTitle:@"Off"
                   action:@selector(disableKeyFilter)
            keyEquivalent:@""];
  [itemOff setTarget:self];
  
  itemTest = [NSMenuItem allocWithZone:[NSMenu menuZone]];
  [itemTest initWithTitle:@"Test"
                   action:@selector(testKeyFilter)
            keyEquivalent:@""];
  [itemTest setTarget:self];
  
  itemQuit = [NSMenuItem allocWithZone:[NSMenu menuZone]];
  [itemQuit initWithTitle:@"Quit"
                   action:@selector(terminate:)
            keyEquivalent:@""];
  [itemQuit setTarget:NSApp];
  
  NSMenu* menu = [NSMenu allocWithZone:[NSMenu menuZone]];
  [menu initWithTitle:@"Menu"];
  
  [menu addItem: itemOn];
  [menu addItem: itemOff];
  [menu addItem: itemTest];
  [menu addItem: itemQuit];
  
  statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
  [statusItem retain];
  [statusItem setTitle: @"h"];
  [statusItem setMenu:menu];
  [menu release];

  CFRunLoopRef loop = CFRunLoopGetCurrent();

  keyFilter = [KeyFilter new];
  [keyFilter retain];
  if (![keyFilter initWithRunLoop:loop]) {
    NSRunAlertPanel(@"Failure", @"Failed to create event tap", @"Dammit", nil, nil);
    return;
  }
  
  [self enableKeyFilter];
}

- (void) dealloc {
  [keyFilter release];
  [statusItem release];
  
  [itemOn release];
  [itemOff release];
  [itemTest release];
  [itemQuit release];

  [super dealloc];
}

@end
