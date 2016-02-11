//
//  LWZDetailViewControllerZ.m
//  MusicFM
//
//  Created by ZC on 16/1/11.
//  Copyright © 2016年 LWZ. All rights reserved.
//

#import "LWZDetailViewControllerZ.h"
#import "LWZMVModelZ.h"
#import "LWZArtistModel.h"
#import "LWZMVDesCollectionViewCell.h"
#import "MHNetWorkTask.h"
#import "LWZArtistModel.h"
#import "LWZArtModelZ.h"
#import "LWZConmentModelZ.h"
#import "LWZArtMVCollectionViewCell.h"
#import "LWZConmentCollectionViewCell.h"
#import <AFNetworking.h>
#import <AFNetworking/AFHTTPSessionManager.h>
//AV框架
#import <AVFoundation/AVFoundation.h>
@interface LWZDetailViewControllerZ ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

//model类
@property (nonatomic, strong) LWZMVModelZ *MVModel;
@property (nonatomic, strong) LWZArtModelZ *artModel;

//XIB引入
@property (strong, nonatomic) IBOutlet UIImageView *backImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightBtn;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segement;
@property (strong, nonatomic) IBOutlet UICollectionView *collection;
@property (strong, nonatomic) IBOutlet UIView *tapView;
@property (strong, nonatomic) IBOutlet UIView *collectionBar;
@property (strong, nonatomic) IBOutlet UIButton *startBtn;
@property (strong, nonatomic) IBOutlet UIButton *fullScreenBtn;
@property (strong, nonatomic) IBOutlet UILabel *totalTime;
@property (strong, nonatomic) IBOutlet UILabel *nowTime;
@property (strong, nonatomic) IBOutlet UISlider *rateLine;
@property (strong, nonatomic) IBOutlet UIProgressView *rateProgress;


//model数据数组
@property (nonatomic, strong)NSMutableArray *artMVModelArr;
@property (nonatomic, strong)NSMutableArray *conmentModelArr;

//AVPlayer组件
@property (nonatomic, strong)AVPlayerItem *avPlayItem;
@property (nonatomic, strong)AVPlayer *avPlayer;
@property (nonatomic, strong)AVPlayerLayer *avPlayerLayer;

//是非标记
@property (nonatomic, assign)BOOL indexBool;

@property (nonatomic, assign)NSInteger minuteTotal;
@property (nonatomic, assign)NSInteger secondTotal;
@property (nonatomic, strong)NSTimer *subTimer;

@end

@implementation LWZDetailViewControllerZ

- (instancetype)initWithMVModel:(LWZMVModelZ *)MVModel
{
    self = [super init];
    if (self) {
        self.MVModel = MVModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    创建视图
    [self createAVPlayer];
    [self createCollectionView];
    [self createToolBarButtonItem];
    [self createMVController];
    
//    获取数据
    [self getArtData];
    [self getConmentData];
    
#warning 播放
    [self.avPlayer play];
    
    
//  设置状态栏颜色，背景色，标题
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.view.backgroundColor = [UIColor blackColor];
    self.titleLabel.text = self.MVModel.title;
    
//    左右button
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"leftBtnZ"] forState:UIControlStateNormal];
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"rightBtnZ"] forState:UIControlStateNormal];
    
//    显示toolbar
    [self.navigationController setToolbarHidden:NO animated:YES];
    self.navigationController.toolbar.barStyle = UIBarStyleBlack;
    self.navigationController.toolbar.tintColor = [UIColor whiteColor];
    
//    将toolbar设为全透明
    [self.navigationController.toolbar setBackgroundImage:[UIImage imageNamed:@"navigationBackground"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    self.navigationController.toolbar.barStyle = UIBarStyleBlackTranslucent;
    
//    背景图
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backImageView.userInteractionEnabled = YES;

//    毛玻璃
    UIBlurEffect *effct = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualview = [[UIVisualEffectView alloc] initWithEffect:effct];
    [self.view addSubview:self.backImageView];
    
//    设置位置大小
    [self.backImageView addSubview:visualview];
    [visualview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backImageView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
//    调整层级
    [self.view sendSubviewToBack:self.backImageView];
    [self.view bringSubviewToFront:self.tapView];
    
//    延迟加载
    double delaySeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds *NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [self.backImageView yy_setImageWithURL:[NSURL URLWithString:self.MVModel.albumImg] placeholder:[UIImage imageNamed:@"placeHolderZ"]];
    });
    
    self.collectionBar.hidden = YES;

    [self.avPlayItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.avPlayItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
}

#pragma mark - 获取数据
- (void)getArtData {

    LWZArtistModel *artModel = self.MVModel.artistsArray[0];
    NSString *artistId = [NSString stringWithFormat:@"%ld", artModel.artistId];
    NSNumber *size = @20;
    NSDictionary *parameter = @{@"artistId":artistId, @"size":size};
    NSDictionary *header = @{@"App-Id":kMVApp, @"Device-Id":kMVid, @"Device-V":kMVDv};
    [MHNetWorkTask getWithURL:kMVYR withParameter:parameter withHttpHeader:header withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        NSArray *videos = result[@"videos"];
        self.artMVModelArr = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in videos) {
            LWZMVModelZ *artMVModel = [[LWZMVModelZ alloc] initWithDataSource:dic];
            [self.artMVModelArr addObject:artMVModel];
        }
         self.artModel = [[LWZArtModelZ alloc] initWithDataSource:result[@"artist"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collection reloadData];
            self.collectionBar.hidden = NO;
            
        });
    } withFail:^(NSError *error) {
        NSLog(@"🍎%@", error);
    }];
}

- (void)getConmentData {

    NSNumber *size = @20;
    NSNumber *vConment = @2;
    NSNumber *offset = @0;
    NSString *videoId = self.MVModel.nId;
    NSDictionary *parameter = @{@"v":vConment,@"offset":offset ,@"size":size,@"videoId":videoId};
    NSDictionary *header = @{@"App-Id":kMVApp, @"Device-Id":kMVid, @"Device-V":kMVDv};
    [MHNetWorkTask getWithURL:kMVPl withParameter:parameter withHttpHeader:header withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        NSArray *array = result[@"comments"];
        self.conmentModelArr = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in array) {
            LWZConmentModelZ *commentModel = [[LWZConmentModelZ alloc] initWithDataSource:dic];
            [self.conmentModelArr addObject:commentModel];
        }
    } withFail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}
#pragma mark - 创建播放器
- (void)createAVPlayer {
    NSURL *url = [NSURL URLWithString:self.MVModel.url];
    AVAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    self.avPlayItem = [AVPlayerItem playerItemWithAsset:avAsset];
    self.avPlayer = [AVPlayer playerWithPlayerItem:self.avPlayItem];
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.avPlayerLayer.frame = CGRectMake(0, 64, kScreenWidth, 290);
    UIView *label = [[UIView alloc] initWithFrame:CGRectMake(0, 93, kScreenWidth, 232)];
    label.backgroundColor = [UIColor blackColor];
    [self.view addSubview:label];
    [self.view.layer addSublayer:label.layer];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [label addSubview:titleLabel];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = [NSString stringWithFormat:@"即将播放:%@", self.MVModel.title];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_top).offset(75);
        make.right.left.offset(0);
        make.height.mas_equalTo(25);
    }];
    UILabel *artistLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    artistLabel.backgroundColor = [UIColor clearColor];
    artistLabel.textAlignment = NSTextAlignmentCenter;
    artistLabel.text = self.MVModel.artistName;
    artistLabel.font = [UIFont systemFontOfSize:14];
    artistLabel.textColor = [UIColor colorWithRed:0.232 green:1.000 blue:0.469 alpha:1.000];
    [label addSubview:artistLabel];
    
    [artistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.right.left.offset(0);
        make.height.mas_equalTo(25);
    }];
    
    [self.view.layer addSublayer:self.avPlayerLayer];
    self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
}
#pragma mark - 创建collection
- (void)createCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collection.collectionViewLayout = flowLayout;
    UINib *nib = [UINib nibWithNibName:@"LWZMVDesCollectionViewCell" bundle:nil];
    [self.collection registerNib:nib  forCellWithReuseIdentifier:@"LWZMVDesCollectionViewCell"];
    [self.collection registerClass:[LWZArtMVCollectionViewCell class] forCellWithReuseIdentifier:@"artMVCollectionCellId"];
    [self.collection registerClass:[LWZConmentCollectionViewCell class] forCellWithReuseIdentifier:@"LWZConmentCollectionViewCell"];
    self.collection.backgroundColor = [UIColor clearColor];
    self.collection.scrollEnabled = NO;
    self.collection.dataSource = self;
    self.collection.delegate = self;
    
}

#pragma mark - 创建toolbar

- (void)createToolBarButtonItem {
    UIBarButtonItem *placeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *downLoadBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"downLoad"] style:UIBarButtonItemStylePlain target:self action:@selector(downLoadBtn:)];
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"shareZ"] style:UIBarButtonItemStyleDone target:self action:@selector(shareBtn:)];
    UIBarButtonItem *conmentBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"conmentZ"] style:UIBarButtonItemStyleDone target:self action:@selector(shareBtn:)];
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"addZ"] style:UIBarButtonItemStyleDone target:self action:@selector(addBtn:)];

    [self setToolbarItems:@[placeButton,downLoadBtn,placeButton,shareBtn,placeButton,conmentBtn,placeButton,addBtn,placeButton] animated:YES];

}

#pragma mark - 创建MV控制栏
- (void)createMVController {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.tapView addGestureRecognizer:tap];
    self.rateLine.maximumTrackTintColor = [UIColor clearColor];
    
    [self.rateLine addTarget:self action:@selector(sliderDidTouchDown:) forControlEvents:UIControlEventTouchDown];
    
    [self.rateLine addTarget:self action:@selector(sliderDidValueChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.rateLine addTarget:self action:@selector(sliderDidTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rateLine setThumbImage:[UIImage imageNamed:@"sliderZ"] forState:UIControlStateNormal];
    self.rateLine.minimumValue = 0.0f;
//    创建子线程获取视频长度
    dispatch_queue_t getTotalTimeQueue = dispatch_queue_create("getTotalTime", NULL);
    dispatch_async(getTotalTimeQueue, ^{
        self.rateLine.maximumValue = [self getAVTotalTime];
        self.rateLine.value = CMTimeGetSeconds(self.avPlayer.currentItem.currentTime) / CMTimeGetSeconds(self.avPlayer.currentItem.duration) * [self getAVTotalTime];
        NSLog(@"%f", self.rateLine.value);
        NSInteger minuteTotal = [self getAVTotalTime] / 60;
        NSInteger secondTotal = [self getAVTotalTime] - minuteTotal * 60;
//        回到主线程刷新视图
        dispatch_async(dispatch_get_main_queue(), ^{
            self.totalTime.text = [NSString stringWithFormat:@"%02ld:%02ld", minuteTotal, secondTotal];
        });
    });

}


#pragma mark - colleciont协议方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LWZMVDesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LWZMVDesCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.item == 0) {
        cell.backgroundColor = [UIColor clearColor];
        cell.MVModel = self.MVModel;
        cell.artModel = self.artModel;
        return cell;
    }else if (indexPath.item == 1) {
        LWZConmentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LWZConmentCollectionViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.dataSource = self.conmentModelArr;
        return cell;
    }else {
        LWZArtMVCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"artMVCollectionCellId" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.dataSource = self.artMVModelArr;
        return cell;
    }
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize layoutSize = CGSizeMake(self.collection.width, self.collection.height);
    return layoutSize;
}

#pragma mark - KVO监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {

            [self monitoringPlayback:self.avPlayItem];// 监听播放状态
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"播放失败");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        CMTime duration = self.avPlayItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [self.rateProgress setProgress:timeInterval / totalDuration animated:YES];
    }

}

#pragma mark - 获取实时播放进度
- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
    __weak typeof(self) weakSelf = self;
    [self.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        CGFloat currentSecond = playerItem.currentTime.value / playerItem.currentTime.timescale;
        [weakSelf.rateLine setValue:currentSecond animated:YES];
        NSInteger minute = currentSecond / 60;
        NSInteger second = currentSecond - minute * 60;
        weakSelf.nowTime.text = [NSString stringWithFormat:@"%02ld:%02ld/", minute, second];
    }];

}
#pragma mark - 获取缓冲进度
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.avPlayer currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

#pragma mark - 下载

- (void)download {
   NSLog(@"======%@", NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES));
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://hc.yinyuetai.com/uploads/videos/common/E58B015148AA2EF82A163A0292A2CE6C.flv"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"失败");
    }];

    [downloadTask resume];
}
#pragma mark - 按钮点击事件

- (IBAction)leftBtn:(id)sender {
    [self.avPlayer pause];
    self.backImageView.image = nil;
    self.navigationController.toolbarHidden = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)rightBtn:(id)sender {
}

- (void)downLoadBtn:(UIBarButtonItem *)sender {
    [self download];
    
}

- (void)shareBtn:(UIBarButtonItem *)sender {
    NSLog(@"草");
}

- (void)conmentBtn:(UIBarButtonItem *)sender {
    NSLog(@"草");
}

- (void)addBtn:(UIBarButtonItem *)sender {
    NSLog(@"草");
}


- (IBAction)stratBtn:(id)sender {
    UIButton *button = sender;
//    判断是否可播放
    if (self.avPlayItem.status == AVPlayerStatusReadyToPlay) {
        button.enabled = YES;
        [button setBackgroundImage:[UIImage imageNamed:@"puseBtnZ"] forState:UIControlStateNormal];
        if (self.indexBool) {
            [self.avPlayer play];
            [button setBackgroundImage:[UIImage imageNamed:@"puseBtnZ"] forState:UIControlStateNormal];
            
        } else {
            [self.avPlayer pause];
            [button setBackgroundImage:[UIImage imageNamed:@"startBtnZ"] forState:UIControlStateNormal];
        }
        self.indexBool = !self.indexBool;
    }else {
        button.enabled = NO;
    }
}

- (IBAction)fullBtn:(id)sender {
    
}

#pragma mark - 定时器事件
- (void)timerEvent:(NSTimer *)sender {
    self.collectionBar.hidden = YES;
}

#pragma mark - 手势事件
- (void)tapEvent:(UITapGestureRecognizer *)sender {
    if (self.collectionBar.hidden) {
        self.collectionBar.hidden = NO;
        self.subTimer = [NSTimer timerWithTimeInterval:4 target:self selector:@selector(timerEvent:) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:self.subTimer forMode:NSRunLoopCommonModes];
    }else {
        self.collectionBar.hidden = YES;
    }
}

#pragma mark - segement点击事件
- (IBAction)segementValueChange:(id)sender {
    UISegmentedControl *temp =  sender;

    if (temp.selectedSegmentIndex ==0) {
        self.collection.contentOffset = CGPointMake(0, 0);
    } else if(temp.selectedSegmentIndex == 1) {
        self.collection.contentOffset = CGPointMake(kScreenWidth - 20, 0);
    }else {
        self.collection.contentOffset = CGPointMake(2 *(kScreenWidth - 20), 0);
    }
}

#pragma mark - slider事件
- (void)sliderDidTouchDown:(UISlider *)sender {
    [self.avPlayer pause];
    [self.subTimer setFireDate:[NSDate distantFuture]];
    
}

- (void)sliderDidValueChange:(UISlider *)sender {
    self.nowTime.text = [self exchangeTimeToString:sender.value];
}

- (void)sliderDidTouchUp:(UISlider *)sender {
    CMTime dragCMTime = CMTimeMake(sender.value, 1);
    [self.avPlayer seekToTime:dragCMTime completionHandler:^(BOOL finished) {
        [self.subTimer setFireDate:[NSDate distantPast]];
        [self.avPlayer play];
    }];
}


#pragma mark - 获取AV总时长
- (float)getAVTotalTime {
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:self.MVModel.hdUrl] options:dic];
    float totalTime = urlAsset.duration.value / urlAsset.duration.timescale;
    return totalTime;
}

#pragma mark - 时间转字符串
- (NSString *)exchangeTimeToString:(float)time {
    NSInteger min = time / 60;
    NSInteger sec = time - min * 60;
    NSString *str = [NSString stringWithFormat:@"%02ld:%02ld", min, sec];
    return str;
}

#pragma mark - 释放内存
- (void)dealloc {
    [self.avPlayItem removeObserver:self forKeyPath:@"status"];
    [self.avPlayItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
