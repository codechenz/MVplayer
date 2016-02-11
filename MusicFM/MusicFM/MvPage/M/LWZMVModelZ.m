//
//  LWZMVModelZ.m
//  MusicFM
//
//  Created by ZC on 16/1/9.
//  Copyright © 2016年 LWZ. All rights reserved.
//
#import "LWZArtistModel.h"
#import "LWZMVModelZ.h"

@implementation LWZMVModelZ

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"artists"]) {
        NSArray *array = value;
        NSMutableArray *mutable = [NSMutableArray new];
        for (NSDictionary *dic in array) {
            LWZArtistModel *artistModel = [[LWZArtistModel alloc] initWithDataSource:dic];
            [mutable addObject:artistModel];
        }
        self.artistsArray = [NSArray arrayWithArray:mutable];
    }
}
@end



