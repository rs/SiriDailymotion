//
//  SiriMotion.m
//  SiriMotion
//
//  Created by Olivier Poitrey on 27/01/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//

#import "SiriMotion.h"
#import "SiriMotionCommands.h"
#import "SiriMotionSnippet.h"

@implementation SiriMotion

- (id)initWithSystem:(id<SESystem>)system
{
    if ((self = [super init]))
    {
        [system registerCommand:[SiriMotionCommands class]];
        [system registerSnippet:[SiriMotionSnippet class]];
    }
    return self;
}

-(NSString *)author
{
    return @"Dailymotion";
}
-(NSString *)name
{
    return @"Dailymotion";
}
-(NSString *)description
{
    return @"Dailymotion search";
}
-(NSString *)website
{
    return @"dailymotion.com";
}

@end
