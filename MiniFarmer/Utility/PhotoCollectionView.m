//
//  PhotoCollectionView.m
//  图片浏览
//
//  Created by 牛筋草 on 15/12/1.
//  Copyright © 2015年 牛筋草. All rights reserved.
//

#import "PhotoCollectionView.h"
#import "PhotoViewCell.h"

@implementation PhotoCollectionView{
    NSString *identifier;
    NSInteger currentIndex;
}
- (id)initWithFrame:(CGRect)frame{
    
    //创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //        设置滑动方向
    //    UICollectionViewScrollDirectionHorizontal   水平滑动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //        设置cell的大小
    flowLayout.itemSize = CGSizeMake(kScreenSizeWidth, kScreenSizeHeight);
    
    flowLayout.minimumLineSpacing = 0;
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        
        
        identifier = @"PhotoViewCell";
        //        设置自己为代理对象
        self.dataSource =self;
        self.delegate = self;
        //设置分页效果
        self.pagingEnabled = YES;
        
        //        注册单元格
        [self registerClass:[PhotoViewCell class] forCellWithReuseIdentifier:identifier];
        
    }
    return self;
}

#pragma mark - UICollection Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.urls.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.urlString = self.urls[indexPath.item];
    
    //    cell.backgroundColor = [UIColor grayColor];
    
    return cell;
    
}

//当单元格从视图上移除后调用的协议方法
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoViewCell *pCell = (PhotoViewCell *)cell;
    
    [pCell.scrollView setZoomScale:1 animated:NO];
    
    NSLog(@"cell=%@\ncll=%@",cell,self);
}
/*
 //scrollview 减速停止
 - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
 NSInteger row = scrollView.contentOffset.x / scrollView.width;
 if (currentIndex != row) {
 NSLog(@"翻页到%ld",row);
 NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentIndex inSection:0];
 //只能查找显示在界面上的单元格
 PhotoViewCell *cell = (PhotoViewCell *)[self cellForItemAtIndexPath:indexPath];
 //scrollView没法使用，原因：@class 类名
 [cell.scrollView setZoomScale:1 animated:NO];
 }
 currentIndex = row;
 }
 */


@end
