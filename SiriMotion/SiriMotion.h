//
//  SiriMotion.h
//  SiriMotion
//
//  Created by Olivier Poitrey on 27/01/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//

#import "SiriObjects.h"

@interface SiriMotion : NSObject<SEExtension> 

- (id)initWithSystem:(id<SESystem>)system;

- (NSString *)author;
- (NSString *)name;
- (NSString *)description;
- (NSString *)website;

@end