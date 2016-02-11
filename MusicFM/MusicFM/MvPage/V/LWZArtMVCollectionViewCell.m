//
//  LWZArtMVCollectionViewCell.m
//  MusicFM
//
//  Created by ZC on 16/1/12.
//  Copyright © 2016年 LWZ. All rights reserved.
//

#import "LWZArtMVCollectionViewCell.h"
#import "LWZSingleMVTableViewCell.h"

@interface LWZArtMVCollectionViewCell ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation LWZArtMVCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        UINib *nib = [UINib nibWithNibName:@"LWZSingleMVTableViewCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"tableViewCell"];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.tableView];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LWZSingleMVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    cell.backgroundColor = [UIColor clearColor];
    if (_dataSource) {
        cell.mvModel = self.dataSource[indexPath.row];
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

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    
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
