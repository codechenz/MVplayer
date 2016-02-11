//
//  LWZMVTabCellZ.m
//  MusicFM
//
//  Created by ZC on 16/1/9.
//  Copyright © 2016年 LWZ. All rights reserved.
//

#import "LWZMVTabCellZ.h"
#import "LWZMVModelZ.h"
@interface LWZMVTabCellZ ()
@property (strong, nonatomic) IBOutlet UIImageView *mainImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *artistLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (strong, nonatomic) IBOutlet UIButton *moreButton;
@property (nonatomic, strong)CAGradientLayer *cAGradientLayer;
@property (strong, nonatomic) IBOutlet UIView *coverView;

@end
@implementation LWZMVTabCellZ
- (IBAction)didPress:(id)sender {
    NSLog(@"点击");
}

- (void)awakeFromNib {
    self.clipsToBounds = YES;
    self.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.cAGradientLayer = [CAGradientLayer layer];
    self.cAGradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,(__bridge id)[UIColor clearColor].CGColor];
    self.cAGradientLayer.startPoint = CGPointMake(0, 1);
    self.cAGradientLayer.endPoint = CGPointMake(0, 0);
   [self.coverView.layer addSublayer:self.cAGradientLayer];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(60);
    }];
    self.cAGradientLayer.frame = self.mainImageView.bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMvModel:(LWZMVModelZ *)mvModel {
    if (_mvModel != mvModel) {
        _mvModel = mvModel;
    }
    
    [self.moreButton setImage:[UIImage imageNamed:@"moreButton"] forState:UIControlStateNormal];
    [self.moreButton setTintColor:[UIColor whiteColor]];
    
    [self.mainImageView yy_setImageWithURL:[NSURL URLWithString:mvModel.albumImg] placeholder:[UIImage imageNamed:@"placeHolderZ"] options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation completion:nil];
    
    self.titleLabel.text = mvModel.title;
    self.artistLabel.text = mvModel.artistName;
    self.viewCountLabel.text = [NSString stringWithFormat:@"播放次数:%ld", mvModel.totalViews];
}

@end
