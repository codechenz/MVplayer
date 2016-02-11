//
//  LWZArtModelZ.h
//  MusicFM
//
//  Created by ZC on 16/1/12.
//  Copyright © 2016年 LWZ. All rights reserved.
//

#import "LWZBaseModelZ.h"

@class Artist,Videos,Artists;
@interface LWZArtModelZ : LWZBaseModelZ

@property (nonatomic, copy) NSString *area;

@property (nonatomic, assign) NSInteger videoCount;

@property (nonatomic, copy) NSString *smallAvatar;

@property (nonatomic, assign) BOOL sub;

@property (nonatomic, assign) NSInteger fanCount;

@property (nonatomic, assign) NSInteger subCount;

@property (nonatomic, assign) NSInteger newVideoCount;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *aliasName;

@end

