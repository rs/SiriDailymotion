//
//  SiriMotionCommands.h
//  SiriMotion
//
//  Created by Olivier Poitrey on 27/01/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//

#import "SiriObjects.h"
#import "Dailymotion.h"

@interface SiriMotionCommands : NSObject<SECommand, DailymotionDelegate>

- (BOOL)handleSpeech:(NSString *)text tokens:(NSArray *)tokens tokenSet:(NSSet *)tokenset context:(id<SEContext>)ctx;

@end