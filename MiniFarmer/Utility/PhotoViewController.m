//
//  PhotoViewController.m
//  图片浏览
//
//  Created by 牛筋草 on 15/12/1.
//  Copyright © 2015年 牛筋草. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCollectionView.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.navigationController.navigationBar.translucent = YES;
    

    
    if (_imageUrls == nil) {
        _imageUrls = [NSMutableArray array];
    }
    
    //    返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    //    创建collectionview
    PhotoCollectionView *collectionV = [[PhotoCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight)];
    //collectionV.backgroundColor= [UIColor redColor];
    [self.view addSubview:collectionV];
    
    //    数据传递
    collectionV.urls = self.imageUrls;
    
    //    滚动到指定的位置
    [collectionV scrollToItemAtIndexPath:_indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    //    创建单机手势，用于显示或隐藏导航栏
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    //    [self.view addGestureRecognizer:tap];
    
}
/*
 - (void)tapAction:(UITapGestureRecognizer *)tap{
 [self.navigationController setNavigationBarHidden:_ishidden animated:YES];
 _ishidden = !_ishidden;
 }*/

- (void)back{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)setImageUrls:(NSMutableArray *)imageUrls{
    _imageUrls = imageUrls.mutableCopy;
    
    for (NSString *str in _imageUrls) {
        if (str.length ==0) {
            [_imageUrls removeObject:str];
        }
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
