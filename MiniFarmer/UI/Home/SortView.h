//
//  SortView.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/24.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortView : UIView{


    __weak IBOutlet UILabel *_title;
    
    __weak IBOutlet UILabel *_history;
    
    
    __weak IBOutlet UIView *_dividine;


}

@property(nonatomic,assign)NSInteger currentIndex;


@end
