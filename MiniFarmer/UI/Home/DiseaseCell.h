//
//  DiseaseCell.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/29.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiseaseCell : UITableViewCell{
    
    
    __weak IBOutlet UILabel *_titleLabel;

    __weak IBOutlet UILabel *_commentLabel;
    

}
@property(nonatomic,copy)NSString *comment;
@property(nonatomic,copy)NSString *title;


    
   


@end
