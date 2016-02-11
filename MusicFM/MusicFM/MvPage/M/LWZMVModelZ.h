//
//  LWZMVModelZ.h
//  MusicFM
//
//  Created by ZC on 16/1/9.
//  Copyright © 2016年 LWZ. All rights reserved.
//

#import "LWZBaseModelZ.h"

@class LWZArtistModel;

@interface LWZMVModelZ : LWZBaseModelZ

@property (nonatomic, assign) NSInteger videoSize;

@property (nonatomic, copy) NSString *regdate;

@property (nonatomic, assign) NSInteger totalViews;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *posterPic;

@property (nonatomic, assign) NSInteger totalMobileViews;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger shdVideoSize;

@property (nonatomic, copy) NSString *shdUrl;

@property (nonatomic, assign) NSInteger duration;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger uhdVideoSize;

@property (nonatomic, copy) NSString *traceUrl;

@property (nonatomic, copy) NSString *albumImg;

@property (nonatomic, assign) NSInteger linkId;

@property (nonatomic, copy) NSString *playListPic;

@property (nonatomic, copy) NSString *artistName;

@property (nonatomic, assign) NSInteger totalComments;

@property (nonatomic, assign) NSInteger hdVideoSize;

@property (nonatomic, copy) NSString *videoSourceTypeName;

@property (nonatomic, copy) NSString *hdUrl;

@property (nonatomic, copy) NSString *uhdUrl;

@property (nonatomic, assign) NSInteger totalPcViews;

@property (nonatomic, copy) NSString *thumbnailPic;

@property (nonatomic, strong)NSArray *artistsArray;
@end


