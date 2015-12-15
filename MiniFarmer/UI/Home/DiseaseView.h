//
//  DiseaseView.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/26.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoclassMode.h"
@interface DiseaseView : UIView{

    __weak IBOutlet UIImageView *_imageView;

    __weak IBOutlet UILabel *_name;

    __weak IBOutlet UIImageView *_browseV;
  
    __weak IBOutlet UILabel *_count;
   
}
@property(nonatomic,strong)NSDictionary *dic;

@property(nonatomic,strong)TwoclassMode *model;

@end
