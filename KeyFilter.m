//
//  KeyFilter.m
//  MacHack
//
//  Created by Jedediah Smith on 11-01-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "KeyFilter.h"
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

  if (type == kCGEventTapDisabledByTimeout) {
    CGEventTapEnable(eventTap, true);
    return event;
  }
  
  if (type != kCGEventKeyUp && type != kCGEventKeyDown)
    return event;
  
  Context ctx;
  ctx.proxy = proxy;
  ctx.source = CGEventCreateSourceFromEvent(event);
  
  CGKeyCode keycode = (CGKeyCode) CGEventGetIntegerValueField(event,kCGKeyboardEventKeycode);    
  CGEventFlags flags = CGEventGetFlags(event);
  //CGEventSourceStateID ssid = CGEventSourceGetSourceStateID(ctx.source);
  
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

@end
