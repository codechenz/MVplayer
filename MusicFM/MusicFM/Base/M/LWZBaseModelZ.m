//
//  LWZBaseModelZ.m
//  MusicFM
//
//  Created by ZC on 16/1/7.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "LWZBaseModelZ.h"

@implementation LWZBaseModelZ
#pragma mark - 纠错方法
- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}
#pragma mark - 纠错方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.nId = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.descriptionStr = value;
    }
}

#pragma mark - 初始化方法
- (instancetype)initWithDataSource:(NSDictionary *)dataSource
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dataSource];
    }
    return self;
}

@end
