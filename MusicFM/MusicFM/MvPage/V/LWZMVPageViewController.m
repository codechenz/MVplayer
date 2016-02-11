//
//  LWZMVPageViewController.m
//  MusicFM
//
//  Created by ZC on 16/1/7.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "LWZMVPageViewController.h"
#import "LWZMVModelZ.h"
#import "LWZArtistModel.h"
#import "LWZMVTabCellZ.h"
#import "LWZDetailViewControllerZ.h"

@interface LWZMVPageViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate>
//视图属性
@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)UICollectionView *titleCollection;
@property (nonatomic, strong)NSMutableArray *mvDataSource;

@end

//上拉加载次数
static int countInt = 1;

@implementation LWZMVPageViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.tabBarController.tabBar.barTintColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationItem.title = @"MV";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.mvDataSource = [NSMutableArray array];
//    创建视图
    [self createTitleCollection];
    [self createMainTableView];
//    获取数据
    [self getMVDataWith:YES];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - 获取数据
- (void)getMVDataWith:(BOOL)headOrFoot {
    NSNumber *offset = [[NSNumber alloc] init];
    NSNumber *size = [[NSNumber alloc] init];
    if (headOrFoot) {
        offset = @0;
        size = @20;
        [self.mvDataSource removeAllObjects];
    }else {
        offset = [NSNumber numberWithInt:countInt * 20];
        size = [NSNumber numberWithInt:(countInt + 1) * 20];
        countInt++;
        
    }
    NSString *area = @"ALL";
    NSDictionary *parameter = @{@"area":area, @"offset":offset, @"size":size};
    NSDictionary *header = @{@"App-Id":kMVApp, @"Device-Id":kMVid, @"Device-V":kMVDv};
    
    [MHNetWorkTask getWithURL:kMVMv withParameter:parameter withHttpHeader:header withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        NSArray *array = result[@"videos"];
        for (NSDictionary *dic in array) {
            LWZMVModelZ *mvModel = [[LWZMVModelZ alloc] initWithDataSource:dic];
            [self.mvDataSource addObject:mvModel];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mainTableView reloadData];
                if (headOrFoot) {
                    [self.mainTableView.mj_header endRefreshing];
                }else {
                    [self.mainTableView.mj_footer endRefreshing];
                }
            });

        }
    } withFail:^(NSError *error) {
        
    }];
    
}

#pragma mark - 创建视图
- (void)createTitleCollection {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(kScreenWidth / 4, 40);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 0;

    self.titleCollection =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.titleCollection.delegate = self;
    self.titleCollection.dataSource = self;
    [self.titleCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellId"];
    self.titleCollection.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.titleCollection];
    
    [self.titleCollection mas_makeConstraints:^(MASConstraintMaker *make) {
//        设置collection的上左右的约束为0
        make.top.left.right.mas_equalTo(0);
//        设置collection的高度
        make.height.mas_equalTo(40);
    }];
}


- (void)createMainTableView {
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.backgroundColor = [UIColor colorWithWhite:0.200 alpha:1.000];
    
    UINib *nibForMVTabCell = [UINib nibWithNibName:@"LWZMVTabCellZ" bundle:nil];
     [self.mainTableView registerNib:nibForMVTabCell forCellReuseIdentifier:@"UITableCellId"];
    __weak LWZMVPageViewController *weakSelf = self;
    self.mainTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf getMVDataWith:NO];
    }];
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getMVDataWith:YES];
    }];
    
    [self.view addSubview:self.mainTableView];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.titleCollection.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
}

#pragma mark - collection协议方法

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

#pragma mark - tableview协议方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LWZMVTabCellZ *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableCellId"];
    cell.mvModel = self.mvDataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mvDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (kScreenHeight - 104) / 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    详情页初始化
    LWZDetailViewControllerZ *detailVC = [[LWZDetailViewControllerZ alloc] initWithMVModel:self.mvDataSource[indexPath.row]];
//    详情页tabbar隐藏
    detailVC.hidesBottomBarWhenPushed = YES;
//    push到详情页，注意隐藏tabbar一定要写到push之前
    [self.navigationController pushViewController:detailVC animated:YES];
//    隐藏navigationbar
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - 滑动协议
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.mainTableView) {
        self.tabBarController.tabBar.hidden = YES;
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.mainTableView) {
        self.tabBarController.tabBar.hidden = NO;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
