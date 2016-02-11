//
//  LWZConmentTableViewCell.m
//  MusicFM
//
//  Created by ZC on 16/1/12.
//  Copyright © 2016年 LWZ. All rights reserved.
//

#import "LWZConmentTableViewCell.h"
#import "LWZConmentModelZ.h"
@interface LWZConmentTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *contextLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIButton *goodButton;

@end

@implementation LWZConmentTableViewCell

- (void)awakeFromNib {
    self.headImage.layer.cornerRadius = 15;
    self.headImage.layer.masksToBounds = YES;
    [self.goodButton setImage:[UIImage imageNamed:@"goodButton"] forState:UIControlStateNormal];
    [self.goodButton setTintColor:[UIColor whiteColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setConmentModel:(LWZConmentModelZ *)conmentModel {
    if (_conmentModel != conmentModel) {
        _conmentModel = conmentModel;
    }
    [self.headImage yy_setImageWithURL:[NSURL URLWithString:conmentModel.userHeadImg] placeholder:[UIImage imageNamed:@"headPlace"]];
    self.nameLabel.text = conmentModel.userName;
    self.contextLabel.text = conmentModel.content;
    self.timeLabel.text = conmentModel.dateCreated;
    [self.goodButton setTitle:[NSString stringWithFormat:@"%ld", conmentModel.totalSupports] forState:UIControlStateNormal];
}

@end
