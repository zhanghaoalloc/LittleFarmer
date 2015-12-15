//
//  HeaderLoginView.h
//  MiniFarmer
//
//  Created by yahui.zhang on 15/12/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapLoginBT)();
typedef void(^TapRegistBT)();
typedef void(^TapPhotoBT)();


@interface HeaderNotLoginView : UIView

@property (nonatomic ,copy) TapLoginBT tapLoginBT;
@property (nonatomic ,copy) TapRegistBT tapRegistBT;
@property (nonatomic ,copy) TapPhotoBT tapPhotoBT;

@end
