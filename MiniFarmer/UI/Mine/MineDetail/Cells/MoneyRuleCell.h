//
//  MoneyRuleCell.h
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/25.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyRuleCell : UITableViewCell{


    __weak IBOutlet UILabel *_number;
    
    __weak IBOutlet UILabel *_content;
}

@property(nonatomic,strong)NSDictionary *dic;

@end
