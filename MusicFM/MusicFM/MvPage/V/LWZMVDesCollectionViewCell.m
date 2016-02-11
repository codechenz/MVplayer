//
//  LWZMVDesCollectionViewCell.m
//  MusicFM
//
//  Created by ZC on 16/1/11.
//  Copyright © 2016年 LWZ. All rights reserved.
//

#import "LWZMVDesCollectionViewCell.h"
#import "LWZMVModelZ.h"
#import "LWZArtModelZ.h"
@interface LWZMVDesCollectionViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *artistLabel;
@property (strong, nonatomic) IBOutlet UIButton *moreButton;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UILabel *PCLabel;
@property (strong, nonatomic) IBOutlet UILabel *mobleLabel;
@property (strong, nonatomic) IBOutlet UILabel *contextLabel;

@end

@implementation LWZMVDesCollectionViewCell

- (void)awakeFromNib {
    self.contextLabel.numberOfLines = 0;
    self.headImage.layer.cornerRadius = 30;
    self.headImage.layer.masksToBounds = YES;
}

- (void)setMVModel:(LWZMVModelZ *)MVModel {
    if (_MVModel != MVModel) {
        _MVModel = MVModel;
    }
    self.contextLabel.text = MVModel.descriptionStr;
    self.artistLabel.text = MVModel.artistName;
    self.timeLabel.text = MVModel.regdate;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",MVModel.totalViews];
    self.PCLabel.text = [NSString stringWithFormat:@"%ld", MVModel.totalPcViews];
    self.mobleLabel.text = [NSString stringWithFormat:@"%ld", MVModel.totalMobileViews];
}

- (void)setArtModel:(LWZArtModelZ *)artModel {
    if (_artModel != artModel) {
        _artModel = artModel;
    }
    [self.headImage yy_setImageWithURL:[NSURL URLWithString:artModel.smallAvatar] placeholder:[UIImage imageNamed:@"headPlace"]];
}
@end
