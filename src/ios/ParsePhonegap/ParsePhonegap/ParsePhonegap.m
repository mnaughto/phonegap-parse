//
//  ParsePhonegap.m
//  ParsePhonegap
//
//  Created by Mike Naughton on 1/24/14.
//  Copyright (c) 2014 Mike Naughton. All rights reserved.
//

#import "ParsePhonegap.h"
#import <Parse/Parse.h>

//TODO check for initialization, document
@implementation ParsePhonegap {
    BOOL initialized;
}

-(CDVPlugin *) initWithWebView:(UIWebView *)theWebView {
    self = [super initWithWebView:theWebView];
    if(self){
        initialized = false;
    }
    return self;
}

-(void) connect:(CDVInvokedUrlCommand *)command {
    CDVPluginResult* pluginResult = nil;
    NSString* appId = [command.arguments objectAtIndex:0];
    NSString * key = [command.arguments objectAtIndex:1];

    if (appId != nil && key != nil) {
        [Parse setApplicationId:appId clientKey:key];
        initialized = true;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"1 or more arguments were null"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void) subscribe:(CDVInvokedUrlCommand *)command{
    CDVPluginResult* pluginResult = nil;
    NSString* channel = [command.arguments objectAtIndex:0];
    
    if (channel != nil) {
        NSError * error;
        [PFPush subscribeToChannel:channel error:&error];
        if(error){
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.description];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        }
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Channel was null"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void) unsubscribe:(CDVInvokedUrlCommand *)command {
    CDVPluginResult* pluginResult = nil;
    NSString* channel = [command.arguments objectAtIndex:0];
    
    if (channel != nil) {
        NSError * error;
        [PFPush unsubscribeFromChannel:channel error:&error];
        if(error){
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.description];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        }
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Channel was null"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void) subscribedChannels:(CDVInvokedUrlCommand *)command {
    CDVPluginResult* pluginResult = nil;
    
    NSArray * channels = [[PFInstallation currentInstallation] channels];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:channels];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void) instanceInfo:(CDVInvokedUrlCommand *)command {
    CDVPluginResult* pluginResult = nil;
    PFInstallation * installation = [PFInstallation currentInstallation];
    NSDictionary * info = @{@"id": installation.installationId};
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:info];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
@end
