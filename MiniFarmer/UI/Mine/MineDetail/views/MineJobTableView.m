//
//  MineJobTableView.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/22.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineJobTableView.h"

@implementation MineJobTableView{

    NSString *_identify1;
    NSArray *jobarry;
}


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _creatSubView];
    }
    
    return self;

}
- (void)_creatSubView{
   

    self.delegate = self;
    self.dataSource = self;
    
    _identify1 = @"jobCell";
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:_identify1];

}
#pragma mark----UITabeViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:_identify1 forIndexPath:indexPath];
    NSString *title = self.data[indexPath.row];
    if ([title isEqualToString:self.item.subTitle]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    
    cell.textLabel.text = title;
    cell.textLabel.font = kTextFont16;
   
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *cellarray = [tableView visibleCells];
    
    for (UITableViewCell *cell in cellarray) {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    NSString *name = cell.textLabel.text;
    self.block(name);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}
- (void)setItem:(UserMenuItem *)item{
    _item = item;
    [self reloadData];

}
- (void)setData:(NSArray *)data{
    _data = data;
    
    CGRect frame = self.frame;
    frame.size.height = _data.count*40;
    self.frame = frame;
    
    [self reloadData];
}



@end
