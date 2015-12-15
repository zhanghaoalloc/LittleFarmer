//
//  PhotoViewCell.m
//  图片浏览
//
//  Created by 牛筋草 on 15/12/1.
//  Copyright © 2015年 牛筋草. All rights reserved.
//

#import "PhotoViewCell.h"

@implementation PhotoViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatScrollView];
    }
    return self;
}
- (void)awakeFromNib{
    
    [self creatScrollView];
}

- (void)creatScrollView{
    _scrollView = [[PhotoScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_scrollView];
}

- (void)setUrlString:(NSString *)urlString{
    _urlString = urlString;
    
    if ([_urlString rangeOfString:@"http://www.enbs.com.cn"].location!= NSNotFound) {
        
        _scrollView.url =  [NSURL URLWithString:[APPHelper safeString:_urlString]];
        
    }
    NSString *str = [kPictureURL stringByAppendingString:_urlString];
    _scrollView.url = [NSURL URLWithString:str];
}



@end
