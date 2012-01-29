//
//  SiriMotionCommands.m
//  SiriMotion
//
//  Created by Olivier Poitrey on 27/01/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//

#import "SiriMotionCommands.h"

@interface SiriMotionCommands ()

@property (strong) id<SEContext>currentContext;
@property (strong) Dailymotion *dailymotion;

@end

@implementation SiriMotionCommands

@synthesize currentContext = _currentContext;
@synthesize dailymotion = _dailymotion;

- (id)init
{
    if ((self = [super init]))
    {
        self.dailymotion = [[Dailymotion alloc] init];
    }
    return self;
}

- (BOOL)handleSpeech:(NSString *)text tokens:(NSArray *)tokens tokenSet:(NSSet *)tokenset context:(id<SEContext>)ctx
{
    if (self.currentContext) return NO; // already preocessing
    
	if (![tokenset containsObject:@"dailymotion"] && !([tokenset containsObject:@"daily"] && [tokenset containsObject:@"motion"]))
	{
        return NO;
    }

    self.currentContext = ctx;
    
    NSMutableArray *terms = [NSMutableArray array];
    for (int num = 0; num < [tokens count]; num++)
    {
        NSString* str = [tokens objectAtIndex:num];
        
        // skip dailymotion or daily motion
        if ([str isEqualToString:@"dailymotion"] || [str isEqualToString:@"daily"] || [str isEqualToString:@"motion"])
        {
            continue;
        }
        // skip search/find
        else if (num == 0 && ([str isEqualToString:@"search"] || [str isEqualToString:@"find"] ||
                              [str isEqualToString:@"cherche"] || [str isEqualToString:@"recherche"]))
        {
            continue;
        }
        else if ([str isEqualToString:@"on"] || [str isEqualToString:@"sur"])
        {
            continue;
        }
        else
        {
            [terms addObject:str];
        }
    }
    NSString *query = [terms componentsJoinedByString:@" "];
    
    // reflection...
    NSString* str = @"Searching Dailymotion for you...";
    [ctx sendAddViewsUtteranceView:str speakableText:str dialogPhase:@"Reflection" scrollToTop:NO temporary:NO];
    
    NSLog(@"Dailymotion query: '%@'", query);

    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:
                          query, @"search",
                          @"relevance", @"sort",
                          @"6", @"limit",
                          @"title,owner.screenname,thumbnail_medium_url,url", @"fields",
                          nil];
    [self.dailymotion request:@"/videos"withArguments:args delegate:self userInfo:nil];
    
    return YES;
}

- (void)dailymotion:(Dailymotion *)dailymotion didReturnResult:(id)result userInfo:(NSDictionary *)userInfo
{
    NSArray *videos = [result objectForKey:@"list"];
    NSLog(@"Found %@ Dailymotion results...", [result objectForKey:@"total"]);
    if ([videos count] == 0)
    {
        [self.currentContext sendAddViewsUtteranceView:@"Nothing has been found."];
    }
    else
    {
        NSDictionary* snipProps = [NSDictionary dictionaryWithObjectsAndKeys:videos, @"videos", nil];
        [self.currentContext sendAddViewsSnippet:@"SiriMotionSnippet" properties:snipProps];
    }
    [self.currentContext sendRequestCompleted];
    self.currentContext = nil;
}

- (void)dailymotion:(Dailymotion *)dailymotion didReturnError:(NSError *)error userInfo:(NSDictionary *)userInfo
{
    NSLog(@"Dailymotion error: %@", error.localizedDescription);
    [self.currentContext sendAddViewsUtteranceView:@"Something incredibly wrong happened."];
    [self.currentContext sendRequestCompleted];
    self.currentContext = nil;
    return;
}

@end