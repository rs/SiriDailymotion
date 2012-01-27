//
//  SiriMotionSnippet.h
//  SiriMotion
//
//  Created by Olivier Poitrey on 27/01/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//

#import "SiriObjects.h"

@interface SiriMotionSnippet : NSObject<SESnippet, UITableViewDelegate, UITableViewDataSource>

@property (strong) UIView *view;

- (id)initWithProperties:(NSDictionary *)props;

@end
