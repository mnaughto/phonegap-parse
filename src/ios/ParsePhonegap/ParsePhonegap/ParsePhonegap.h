//
//  ParsePhonegap.h
//  ParsePhonegap
//
//  Created by Mike Naughton on 1/24/14.
//  Copyright (c) 2014 Mike Naughton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CDVPlugin.h>

@interface ParsePhonegap : CDVPlugin
/*Get information about the connected instance*/
-(void) instanceInfo: (CDVInvokedUrlCommand *) command;
/*Subscribes to a channel*/
-(void) subscribe: (CDVInvokedUrlCommand *) command;
/*Unsubscribes from a channel*/
-(void) unsubscribe: (CDVInvokedUrlCommand *) command;
/*Gets channels to which the instance is subscribed*/
-(void) subscribedChannels: (CDVInvokedUrlCommand *) command;
/*Logs into parse*/
-(void) connect: (CDVInvokedUrlCommand *) command;
@end
