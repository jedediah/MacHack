//
//  KeyFilter.h
//  MacHack
//
//  Created by Jedediah Smith on 11-01-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <ApplicationServices/ApplicationServices.h>

#import "Console.h"

@interface KeyFilter : NSObject {
  int escapeCount;
  CFRunLoopRef runLoop;
  CFMachPortRef eventTap;
  NSObject<Console>* console;
  bool enabled;
  bool rightShiftFlag;
}

- (CGEventRef) callbackWithProxy:(CGEventTapProxy) proxy
                            type:(CGEventType) type
                           event:(CGEventRef) event;
  
- (bool) initWithRunLoop:(CFRunLoopRef) loop;
- (void) enable;
- (void) disable;
- (bool) isEnabled;
- (void) setConsole:(NSObject<Console>*) con;
@end
