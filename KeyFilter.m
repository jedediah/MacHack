//
//  KeyFilter.m
//  MacHack
//
//  Created by Jedediah Smith on 11-01-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "KeyFilter.h"
#import "MacHackAppDelegate.h"

#include "keys.h"


@implementation KeyFilter

typedef struct {
  CGEventTapProxy proxy;
  CGEventSourceRef source;
} Context;

void SetKeyCode(CGEventRef event, CGKeyCode key, CGEventFlags flags) {
  CGEventSetIntegerValueField(event, kCGKeyboardEventKeycode, key);
  CGEventSetFlags(event, flags);
}

void PostKeyDown(Context ctx, CGKeyCode key, CGEventFlags flags) {
  CGEventRef event = CGEventCreateKeyboardEvent(ctx.source, key, true);
  CGEventSetFlags(event, flags);
  CGEventTapPostEvent(ctx.proxy, event);
}

void PostKeyUp(Context ctx, CGKeyCode key, CGEventFlags flags) {
  CGEventRef event = CGEventCreateKeyboardEvent(ctx.source, key, false);
  CGEventSetFlags(event, flags);
  CGEventTapPostEvent(ctx.proxy, event);
}

void PostKeyPress(Context ctx, CGKeyCode key, CGEventFlags flags) {
  PostKeyDown(ctx,key,flags);
  PostKeyUp(ctx,key,flags);
}

void PostChar(Context ctx, char c) {
  if (c >= 0) {
    int k = CharToKeyCode[c];
    CGEventFlags flags = 0;
    if (k & VK_FLAG_SHIFT) flags |= kCGEventFlagMaskShift;
    if (k & VK_FLAG_CTRL)  flags |= kCGEventFlagMaskControl;
    PostKeyPress(ctx, k & 0x7f, flags);
  }
}

void PostText(Context ctx, const char* text) {
  while (*text)
    PostChar(ctx,*text++);
}


CGEventRef Callback(CGEventTapProxy proxy,
                    CGEventType type,
                    CGEventRef event,
                    void* keyFilter) {
  
  return [((KeyFilter*) keyFilter) callbackWithProxy:proxy
                                                type:type
                                               event:event];
}

- (CGEventRef) callbackWithProxy:(CGEventTapProxy) proxy
               type:(CGEventType) type
               event:(CGEventRef) event {

  Context ctx;
  ctx.proxy = proxy;
  ctx.source = CGEventCreateSourceFromEvent(event);

  CGEventFlags flags = CGEventGetFlags(event);
    
  CGKeyCode keycode = (CGKeyCode) CGEventGetIntegerValueField(event,kCGKeyboardEventKeycode);    
  
  if (console) {
    NSString* typeStr;
    switch (type) {
      case kCGEventKeyDown:               typeStr = @"KeyDown      "; break;
      case kCGEventKeyUp:                 typeStr = @"KeyUp        "; break;
      case kCGEventFlagsChanged:          typeStr = @"FlagsChanged "; break;
      case kCGEventTapDisabledByTimeout:  typeStr = @"DisabledByTimeout"; break;
      default:                            typeStr = @"Unknown"; break; 
    }
    
    NSString* flagStr = @"";
    if (flags & kCGEventFlagMaskAlphaShift)   flagStr = [flagStr stringByAppendingString:@" AlphaShift"];
    if (flags & kCGEventFlagMaskAlternate)    flagStr = [flagStr stringByAppendingString:@" Alternate"];
    if (flags & kCGEventFlagMaskCommand)      flagStr = [flagStr stringByAppendingString:@" Command"];
    if (flags & kCGEventFlagMaskControl)      flagStr = [flagStr stringByAppendingString:@" Control"];
    if (flags & kCGEventFlagMaskHelp)         flagStr = [flagStr stringByAppendingString:@" Help"];
    //if (flags & kCGEventFlagMaskNonCoalesced) flagStr = [flagStr stringByAppendingString:@" NonCoalesced"];
    if (flags & kCGEventFlagMaskNumericPad)   flagStr = [flagStr stringByAppendingString:@" NumericPad"];
    if (flags & kCGEventFlagMaskSecondaryFn)  flagStr = [flagStr stringByAppendingString:@" SecondaryFn"];
    if (flags & kCGEventFlagMaskShift)        flagStr = [flagStr stringByAppendingString:@" Shift"];
    
    [console printToConsole:@"%@ %3i%@\n", typeStr, keycode, flagStr];
  }
  
  switch (type) {
  
    case kCGEventTapDisabledByTimeout:
      CGEventTapEnable(eventTap, true);
      break;
    
    case kCGEventFlagsChanged:
      switch (keycode) {
        case VK_COMMAND_R:
          CGEventSetType(event,
                         flags & kCGEventFlagMaskCommand
                         ? kCGEventKeyDown
                         : kCGEventKeyUp); 
          
          SetKeyCode(event,
                     VK_A,
                     (flags | kCGEventFlagMaskControl) & ~kCGEventFlagMaskCommand);
          break;
          
        case VK_OPTION_R:
          CGEventSetType(event,
                         flags & kCGEventFlagMaskAlternate
                         ? kCGEventKeyDown
                         : kCGEventKeyUp); 
          
          SetKeyCode(event,
                     VK_E,
                     (flags | kCGEventFlagMaskControl) & ~kCGEventFlagMaskAlternate);
          break;
          
        case VK_SHIFT_R:
          if (flags & kCGEventFlagMaskShift) {
            rightShiftFlag = true;
          } else if (rightShiftFlag) {
            rightShiftFlag = false;
            PostKeyPress(ctx, VK_FORWARD_DELETE, flags);
          }
          break;
      }
      break;
      
    case kCGEventKeyDown:
    case kCGEventKeyUp:
      rightShiftFlag = false;
      if (keycode == VK_ESCAPE) {
        if (type == kCGEventKeyDown && ++escapeCount >= 5)
          CFRunLoopStop(runLoop);
      } else {
        escapeCount = 0;
      }
      
      switch (keycode) {
          
        case VK_SPACE:
          if (flags & kCGEventFlagMaskShift)
            SetKeyCode(event, VK_MINUS, flags);
          break;
          
        case VK_HOME:
          SetKeyCode(event, VK_A, flags | kCGEventFlagMaskControl);
          break;
          
        case VK_END:
          SetKeyCode(event, VK_E, flags | kCGEventFlagMaskControl);
          break;
          
        case VK_PAGE_UP:
          if (flags & kCGEventFlagMaskControl)
            SetKeyCode(event, VK_HOME, flags & ~kCGEventFlagMaskControl);
          break;
          
        case VK_PAGE_DOWN:
          if (flags & kCGEventFlagMaskControl)
            SetKeyCode(event, VK_END, flags & ~kCGEventFlagMaskControl);
          break;
          
        case VK_DELETE:
          if (flags & kCGEventFlagMaskShift)
            SetKeyCode(event, VK_FORWARD_DELETE, flags);
          break;
      }
      break;
  }
  
  CFRelease(ctx.source);
  return event;
}

-(bool)initWithRunLoop:(CFRunLoopRef) loop {
  
  escapeCount = 0;
  runLoop = loop;
  CFRetain(runLoop);
  
  CGEventMask eventMask;
  eventMask = CGEventMaskBit(kCGEventKeyDown)
            | CGEventMaskBit(kCGEventKeyUp)
            | CGEventMaskBit(kCGEventFlagsChanged);
  
  eventTap = CGEventTapCreate(kCGHIDEventTap,
                              kCGHeadInsertEventTap,
                              kCGEventTapOptionDefault,
                              eventMask,
                              Callback,
                              self);
  
  if (!eventTap)
    return false;
  
  CFRetain(eventTap);

  CFRunLoopSourceRef runLoopSource;
  runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault,
                                                eventTap,
                                                0);
  CFRunLoopAddSource(runLoop,
                     runLoopSource,
                     kCFRunLoopCommonModes);
  return true;
}

- (void) dealloc {
  CFRelease(eventTap);
  CFRelease(runLoop);
  [super dealloc];
}

- (void) enable {
  CGEventTapEnable(eventTap, true);
  enabled = true;
}

- (void) disable {
  CGEventTapEnable(eventTap, false);
  enabled = false;
}

- (bool) isEnabled {
  return enabled;
}

- (void) setConsole:(NSObject<Console>*) con {
  [con retain];
  [console release];
  console = con;
}

@end
