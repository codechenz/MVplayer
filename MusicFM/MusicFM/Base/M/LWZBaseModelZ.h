//
//  LWZBaseModelZ.h
//  MusicFM
//
//  Created by ZC on 16/1/7.
//  Copyright © 2016年 ZC. All rights reserved.
//



@interface LWZBaseModelZ : NSObject

@property (nonatomic, strong)NSString *nId;
@property (nonatomic, copy) NSString *descriptionStr;
//声明自定义初始化
- (instancetype)initWithDataSource:(NSDictionary *)dataSource;
@end
