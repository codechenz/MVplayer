//
//  LWZMVDesCollectionViewCell.h
//  MusicFM
//
//  Created by ZC on 16/1/11.
//  Copyright © 2016年 LWZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LWZMVModelZ;
@class LWZArtModelZ;
@interface LWZMVDesCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)LWZMVModelZ *MVModel;
@property (nonatomic, strong)LWZArtModelZ *artModel;

@end
