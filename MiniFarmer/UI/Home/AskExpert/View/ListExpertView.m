//
//  ListExpertView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/16.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "ListExpertView.h"

@implementation ListExpertView{
    NSString *_identify;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
       
    }
   
    return self;
}
- (void)initView{
    
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;

    _identify = @"UITableViewCell";
    
    //注册单元格
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:_identify];
    
    
}
#pragma mark--数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_isrigth == YES) {
        cell.textLabel.text = self.data[indexPath.row];
        cell.textLabel.font =kTextFont14;
        
    }else{
        NSDictionary *dic = self.data[indexPath.row];
        cell.textLabel.font =kTextFont14;

        cell.textLabel.text = [dic objectForKey:@"lxnc"];
        
    
    }
    
    return cell;

}
#pragma mark  ---协议方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    
    NSString *expertname= cell.textLabel.text;
    
    
    
    if (_isrigth == YES) {
        NSString *number = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        
        _block(expertname,number);
    }else{
        
        NSDictionary *dic = self.data[indexPath.row];
        
        NSString *lxbh = [dic objectForKey:@"lxbh"];

        _block(expertname,lxbh);

    
    }
    

}

- (void)setData:(NSArray *)data{
    _data = data;
    [self initView];

}
- (void)setIsrigth:(BOOL)isrigth{
    _isrigth = isrigth;


}



@end
