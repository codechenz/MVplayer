//
//  LWZSingleMVTableViewCell.m
//  MusicFM
//
//  Created by ZC on 16/1/12.
//  Copyright © 2016年 LWZ. All rights reserved.
//

#import "LWZSingleMVTableViewCell.h"
#import "LWZMVModelZ.h"
@interface LWZSingleMVTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *mainImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *artistLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UIButton *moreButton;

@end

@implementation LWZSingleMVTableViewCell

- (void)awakeFromNib {
    [self.moreButton setImage:[UIImage imageNamed:@"moreButton"] forState:UIControlStateNormal];
    [self.moreButton setTintColor:[UIColor whiteColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMvModel:(LWZMVModelZ *)mvModel {
    if (_mvModel != mvModel) {
        _mvModel = mvModel;
    }
    [self.mainImage yy_setImageWithURL:[NSURL URLWithString:mvModel.playListPic] placeholder:[UIImage imageNamed:@"placeHolderZ"]];
    self.titleLabel.text = mvModel.title;
    self.artistLabel.text = mvModel.artistName;
    self.countLabel.text = [NSString stringWithFormat:@"播放次数:%ld", mvModel.totalViews];
}

@end
