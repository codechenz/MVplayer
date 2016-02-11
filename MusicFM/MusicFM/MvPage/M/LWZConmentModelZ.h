//
//  LWZConmentModelZ.h
//  MusicFM
//
//  Created by ZC on 16/1/12.
//  Copyright © 2016年 LWZ. All rights reserved.
//

#import "LWZBaseModelZ.h"

@class Comments;
@interface LWZConmentModelZ : LWZBaseModelZ

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) NSInteger vipLevel;

@property (nonatomic, copy) NSString *repliedUserName;

@property (nonatomic, assign) NSInteger userWoLevel;

@property (nonatomic, assign) BOOL repliedUserWoWithDraw;

@property (nonatomic, assign) NSInteger repliedFloorInt;

@property (nonatomic, copy) NSString *repliedFloor;

@property (nonatomic, assign) NSInteger repliedUserId;

@property (nonatomic, assign) NSInteger floorInt;

@property (nonatomic, copy) NSString *vipImg;

@property (nonatomic, copy) NSString *repliedUserVipImg;

@property (nonatomic, assign) NSInteger belongId;

@property (nonatomic, assign) NSInteger totalSupports;

@property (nonatomic, assign) BOOL hot;

@property (nonatomic, copy) NSString *userHeadImg;

@property (nonatomic, assign) NSInteger commentId;

@property (nonatomic, copy) NSString *dateCreated;

@property (nonatomic, assign) NSInteger repliedId;

@property (nonatomic, assign) BOOL supported;

@property (nonatomic, assign) NSInteger repliedUserWoLevel;

@property (nonatomic, assign) NSInteger repliedUserVipLevel;

@property (nonatomic, assign) BOOL userWoWithDraw;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *userWoImg;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *floor;

@end

