//
//  Console.h
//  MacHack
//
//  Created by Jedediah Smith on 11-01-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol Console

-(void) printToConsole:(NSString*) format, ...; 

@end
