//
//  TableViewCell.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/14.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    
    _usertx.layer.cornerRadius = 16;
    _usertx.layer.masksToBounds = YES;
    
    _xm.textColor = [UIColor colorWithHexString:@"#666666"];
    
    _time.textColor = [UIColor colorWithHexString:@"#999999"];
    
    _comment.textColor = [UIColor colorWithHexString:@"#505050"];

}

- (void)setModel2:(PfcommentModel *)model2{
    
    _model2 = model2;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kPictureURL,_model2.usertx]];
    
    _usertx.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    _xm.text = _model2.xm;
    
    _time.text = _model2.indatetime;
    
    _comment.text = _model2.commenttext;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
