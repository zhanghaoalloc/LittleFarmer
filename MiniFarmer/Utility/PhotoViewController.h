//
//  PhotoViewController.h
//  图片浏览
//
//  Created by 牛筋草 on 15/12/1.
//  Copyright © 2015年 牛筋草. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

@property(nonatomic,retain)NSMutableArray *imageUrls; //要显示的图片URL数组
@property(nonatomic,retain)NSIndexPath *indexPath;  //开始显示的图片的indexPath


@end
