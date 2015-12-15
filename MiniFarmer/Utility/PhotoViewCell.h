//
//  PhotoViewCell.h
//  图片浏览
//
//  Created by 牛筋草 on 15/12/1.
//  Copyright © 2015年 牛筋草. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoScrollView.h"

@interface PhotoViewCell : UICollectionViewCell

@property(nonatomic,copy)NSString *urlString; //要显示的图片
@property(nonatomic,retain)PhotoScrollView *scrollView;

@end
