//
//  LWZConmentCollectionViewCell.m
//  MusicFM
//
//  Created by ZC on 16/1/12.
//  Copyright © 2016年 LWZ. All rights reserved.
//

#import "LWZConmentCollectionViewCell.h"
#import "LWZConmentTableViewCell.h"
@interface LWZConmentCollectionViewCell ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation LWZConmentCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        UINib *nib = [UINib nibWithNibName:@"LWZConmentTableViewCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"LWZConmentTableViewCellId"];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LWZConmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWZConmentTableViewCellId"];
    cell.backgroundColor = [UIColor clearColor];
    if (_dataSource) {
        cell.conmentModel = self.dataSource[indexPath.row];
        return cell;
    }else {
        return nil;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (void)setDataSource:(NSArray *)dataSource {
    if (dataSource) {
        if (_dataSource != dataSource) {
            _dataSource = dataSource;
        }
        [self.tableView reloadData];
    }
}

@end
