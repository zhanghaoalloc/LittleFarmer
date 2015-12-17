//
//  ExpertDetailHearView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/17.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "ExpertDetailHearView.h"

@implementation ExpertDetailHearView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubView];
    }
    return self;
}
- (void)_createSubView{
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _title.font =kTextFont14;
    _title.textColor = [UIColor colorWithHexString:@"#333333"];
    
    
}
- ()




@end
