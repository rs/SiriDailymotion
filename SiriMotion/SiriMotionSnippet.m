//
//  SiriMotionSnippet.m
//  SiriMotion
//
//  Created by Olivier Poitrey on 27/01/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//

#import "SiriMotionSnippet.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>

@interface SiriMotionSnippet ()

@property (strong) NSArray *videos;

@end

@implementation SiriMotionSnippet

@synthesize view = _view;
@synthesize videos = _videos;

- (id)initWithProperties:(NSDictionary *)props;
{
    if ((self = [super init]))
    {
        self.videos = [props objectForKey:@"videos"];

        UITableView *tableView = [[UITableView alloc] init];
        tableView.rowHeight = 60;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        self.view = tableView;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_videos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DailymotionResult";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = [UIColor whiteColor];
        CALayer *layer = [cell.imageView layer];
        layer.masksToBounds = YES;
        layer.cornerRadius = 5.0;
    }

    NSDictionary *video = [_videos objectAtIndex:indexPath.row];
    cell.textLabel.text = [video valueForKey:@"title"];
    cell.detailTextLabel.text = [video objectForKey:@"owner.screenname"];
    NSString *placeholderPath = [[NSBundle bundleForClass:self.class] pathForResource:@"placeholder" ofType:@"png"];
    NSURL *url = [NSURL URLWithString:[video valueForKey:@"thumbnail_medium_url"]];
    [cell.imageView setImageWithURL:url placeholderImage:[UIImage imageWithContentsOfFile:placeholderPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *video = [_videos objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[video valueForKey:@"url"]]];
}


@end
