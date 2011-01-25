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

- (void) toggleKeyFilter {
  if ([keyFilter isEnabled])
    [self disableKeyFilter];
  else
    [self enableKeyFilter];
}

- (void)enableKeyFilter {
  [keyFilter enable];
  [statusItem setTitle:@"H"];
  [itemEnable setTitle:@"Disable"];

  [self printToConsole:@"Enable key filter\n"];
}

- (void)disableKeyFilter {
  [keyFilter disable];
  [statusItem setTitle:@"h"];
  [itemEnable setTitle:@"Enable"];
  
  [self printToConsole:@"Disable key filter\n"];
}

- (void) showConsole {
  if (console == nil) {
    
    consoleWindow = [NSWindow alloc];
    [consoleWindow initWithContentRect:NSMakeRect(100,100,300,200)
                             styleMask:NSTitledWindowMask |
                                       NSClosableWindowMask |
                                       NSMiniaturizableWindowMask |
                                       NSResizableWindowMask
                               backing:NSBackingStoreBuffered
                                 defer:false];
    
    [consoleWindow setTitle:@"MacHack Console"];
    [consoleWindow setReleasedWhenClosed:YES];
    [consoleWindow setAutodisplay:true];
    [consoleWindow setDelegate:self];

    NSRect frame = [[consoleWindow contentView] frame];
    
    NSScrollView* scrollView = [[NSScrollView alloc] initWithFrame:frame];
    [scrollView setBorderType:NSNoBorder];
    [scrollView setHasHorizontalScroller:true];
    [scrollView setHasVerticalScroller:true];
    [scrollView setAutohidesScrollers:true];
    [scrollView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [scrollView setAutoresizesSubviews:true];
    
    console = [[NSTextView alloc] initWithFrame:frame];
    
    [console setEditable:false];
    [console setHorizontallyResizable:true];
    [console setVerticallyResizable:true];
    [console setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [console setFont:[NSFont userFixedPitchFontOfSize:12.0]];
    
    NSTextContainer* textContainer = [console textContainer];
    [textContainer setWidthTracksTextView:NO];
    [textContainer setHeightTracksTextView:NO];
    [textContainer setContainerSize:NSMakeSize(FLT_MAX,FLT_MAX)];
    
    [scrollView setDocumentView:console];
    
    [consoleWindow setContentView:scrollView];
    [consoleWindow makeFirstResponder:console];

    [consoleWindow orderFront:self];

    [scrollView release];
    [console release];
    
    [keyFilter setConsole:self];
  }
}

- (void) windowWillClose:(NSNotification *)notification {
  if ([notification object] == consoleWindow)
    console = nil;
}

- (void) hideConsole {
  if (console != nil) {
    [keyFilter setConsole:nil];
    [consoleWindow close];
  }
}

- (void) printToConsole:(NSString*) format, ... {
  if (console != nil) {
    va_list args;
    va_start(args,format);
    NSString* s = [[NSString alloc] initWithFormat:format arguments:args];
    [console setString:[[console string] stringByAppendingString:s]];
    [console scrollToEndOfDocument:self];
    [s release];
    va_end(args);
  }
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
  if (menuItem == itemConsole)
    return console == nil;
  
  return true;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  
  itemEnable = [NSMenuItem allocWithZone:[NSMenu menuZone]];
  [itemEnable initWithTitle:@"Enable"
                     action:@selector(toggleKeyFilter)
              keyEquivalent:@""];
  [itemEnable setTarget:self];
  
  itemConsole = [NSMenuItem allocWithZone:[NSMenu menuZone]];
  [itemConsole initWithTitle:@"Console"
                      action:@selector(showConsole)
               keyEquivalent:@""];
  [itemConsole setTarget:self];
  
  itemQuit = [NSMenuItem allocWithZone:[NSMenu menuZone]];
  [itemQuit initWithTitle:@"Quit"
                   action:@selector(terminate:)
            keyEquivalent:@""];
  [itemQuit setTarget:NSApp];
  
  NSMenu* menu = [NSMenu allocWithZone:[NSMenu menuZone]];
  [menu initWithTitle:@"Menu"];
  
  [menu addItem: itemEnable];
  [menu addItem: itemConsole];
  [menu addItem: itemQuit];
  
  statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
  [statusItem retain];
  [statusItem setTitle: @"h"];
  [statusItem setHighlightMode:true];
  [statusItem setMenu:menu];
  [menu release];

  CFRunLoopRef loop = CFRunLoopGetCurrent();

  keyFilter = [KeyFilter alloc];

  if (![keyFilter initWithRunLoop:loop]) {
    NSRunAlertPanel(@"Failure", @"Failed to create event tap", @"Dammit", nil, nil);
    return;
  }
 
  [self enableKeyFilter];
}

- (void) dealloc {
  [keyFilter release];
  [statusItem release];
  
  [itemEnable release];
  [itemConsole release];
  [itemQuit release];

  [console release];
  [consoleWindow release];
  
  [super dealloc];
}

@end
