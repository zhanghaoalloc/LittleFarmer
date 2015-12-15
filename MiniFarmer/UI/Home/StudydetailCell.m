//
//  StudydetailCell.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/11/26.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "StudydetailCell.h"
#import "DiseaseView.h"
#import "TwoclassMode.h"

@implementation StudydetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       // [self _createSubView];
        
    }
    return self;
}
- (void)_createSubView{
    

    CGFloat weiht = (kScreenSizeWidth-30)/3;

        
        for (int i = 0; i<3;i++ ) {
            if (_isStudymore == NO) {
                
                DiseaseView *view = [[NSBundle mainBundle] loadNibNamed:@"DiseaseView" owner:self options:nil].firstObject 
                ;
                if (i<_model.zplist.count) {
                    view.dic = _model.zplist[i];
                    
                }
                view.frame = CGRectMake(i*(weiht+6)+10, 0,weiht,weiht*0.75+30);
                view.tag = i+1;
                [self.contentView addSubview:view];
                
                self.selectionStyle =UITableViewCellSelectionStyleNone;
            }else {
            
                if (self.data.count != 0) {
                    
                    if (i<self.data.count) {
                    DiseaseView *view = [[NSBundle mainBundle] loadNibNamed:@"DiseaseView" owner:self options:nil].lastObject;
                        view.model = _data [i];
                        self.selectionStyle =UITableViewCellSelectionStyleNone;
                        view.frame = CGRectMake(i*(weiht+6)+10, 0,weiht,weiht*0.75+30+16);
                        view.tag = i+1;
                        [self.contentView addSubview:view];

                    }
    
                }
            }
        }
  
    
    
}
- (void)setModel:(StudyModel *)model{
  _model = model;
    [self _createSubView];
}
- (void)setData:(NSMutableArray *)data{
    _data = data;
    [self _createSubView];
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
