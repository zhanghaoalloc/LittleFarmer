//
//  ImagesView.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/13.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImagesView;

@protocol ImagesViewDelegate <NSObject>

@optional
- (void)imagesView:(ImagesView *)imagesView selectedItem:(NSInteger)selectedItem;

@end

@interface ImagesView : UIView

@property (nonatomic, assign)id<ImagesViewDelegate,UIActionSheetDelegate> delegate;

- (void)reloadDataWithImagesInfo:(NSArray *)images;
@end
