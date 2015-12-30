//
//  MyanswerViewController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/7.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MyanswerViewController.h"
#import "BaseViewController+Navigation.h"
#import "GCPlaceholderTextView.h"
#import "XDPhotoSelect.h"
#import "ImagesView.h"
#import "QuCommonView.h"
#import "UIView+FrameCategory.h"
#import "ZmImageView.h"
#import "UserInfo.h"

//获取图片路径的类
#import <AssetsLibrary/AssetsLibrary.h>
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>


#define kPlaceHolderText @"请您尽量详细的解答是什么病虫草害和防治方法和药剂(必填)"

@interface MyanswerViewController ()<XDPhotoSelectDelegate,UINavigationControllerDelegate,ZmImageViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)GCPlaceholderTextView *ansTextView;//回答
@property(nonatomic,strong)XDPhotoSelect *photoSelect;//图片选择
@property(nonatomic,strong)QuCommonView *questionView;//问题视图
@property(nonatomic,strong)UIButton *sendButton;//发送按钮
@property(nonatomic,strong)UIButton *addImage;//添加图片的按钮
@property(nonatomic,strong)UIView *imagesView;//图片显示
@property(nonatomic,strong)UIView *bottomView ;//添加按钮下面的是视图
@property(nonatomic,strong)ZmImageView *selectImgView;

//存放选择图片
@property(nonatomic,strong)NSMutableArray *arrayPhotos;
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,strong)NSData *imgData;
@property(nonatomic,copy)NSString *path;
@end

@implementation MyanswerViewController{
   
    NSURL *pictureURL;
    NSString *imagePath;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //界面的配置
    [self initTitleLabel:@"我解答"];
    [self setNavigationBarIsHidden:NO];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
   // [self _createSubView];
    [self setNaVIgationBackAction:self action:@selector(BackAction:)];
    
    
    self.arrayPhotos = [NSMutableArray array];
    
    //功能方法
    [self _function];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate hideTabbar];

}
- (void)_function{

    //1.监听键盘的弹起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    //2.监听键盘的收起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboardAction:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)_createSubView{
    //初始化发送按钮
    [self.view addSubview:self.sendButton];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight + 8);
        make.size.mas_equalTo(CGSizeMake(56, 28));
    }];
    //创建滚动视图
    
    [self.view addSubview:self.scrollView];
    
    
    [self.scrollView addSubview:self.questionView];
    [self.scrollView addSubview:self.ansTextView];
    [self.scrollView addSubview:self.imagesView];
    
    
    //设置滑动视图子视图的位置
    
    CGRect subRect = self.view.bounds;
    //滑动视图的位置
    subRect.origin.y = kStatusBarHeight+kNavigationBarHeight +kLineWidth;
    subRect.size.height -=kStatusBarHeight + kNavigationBarHeight + kLineWidth+kBottomTabBarHeight;
    [self.scrollView setFrame:subRect];
    self.scrollView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    //问题视图的位置
    subRect.origin.y = 0;
    [_questionView refreshWithQuestionInfo:_info];
    subRect.size.height = _questionView.totalViewHeight;

    self.questionView.frame = subRect;
    
    subRect = _ansTextView.frame ;
    subRect.size.width = kScreenSizeWidth;
    subRect.size.height = 160;
    subRect.origin.y =_questionView.bottom+12;
    _ansTextView.frame = subRect;
    
   // self.ansTextView.frame = subRect;
    subRect.origin.y =_ansTextView.bottom;
    subRect.size.width = kScreenSizeWidth;
    subRect.size.height = (kScreenSizeWidth-21)/3;
    self.imagesView.frame = subRect;
    
    CGFloat totalheigth = _questionView.height +12+_ansTextView.height+_imagesView.height;
    _scrollView.contentSize = CGSizeMake(kScreenSizeWidth, totalheigth);
    
    //添加按钮的视图
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc ] initWithFrame:CGRectZero];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomView addSubview:self.addImage];
        [_addImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_bottomView.mas_left).offset(12);
            make.bottom.equalTo(_bottomView.mas_bottom).offset(-3);
            make.size.mas_equalTo(CGSizeMake(43, 43));
            
        }];
    
        [self.view addSubview:_bottomView];
    }
    subRect.origin.y = kScreenSizeHeight-kBottomTabBarHeight;
    subRect.size.height = kBottomTabBarHeight;
    self.bottomView.frame = subRect;
    
    
    
}
//发送按钮
- (UIButton *)sendButton
{
    if (!_sendButton)
    {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_no_enable_nm"] forState:UIControlStateDisabled];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_hl"] forState:UIControlStateHighlighted];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_enable_nm"] forState:UIControlStateNormal];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_sendButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [_sendButton setEnabled:NO];
        [_sendButton addTarget:self action:@selector(sendAsk:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}
//滑动视图
- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    
    }
    return _scrollView;
}
//问题视图
- (QuCommonView *)questionView{
    if(_questionView == nil){
        _questionView = [[QuCommonView alloc]init];
    
    }


    return _questionView;

}
//提交回复评论
- (UITextView *)ansTextView
{
    if (!_ansTextView)
    {
        _ansTextView = [[GCPlaceholderTextView alloc] initWithFrame:CGRectZero];
        _ansTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _ansTextView.textColor = [UIColor colorWithHexString:@"333333"];
        _ansTextView.font = kTextFont(14);
        _ansTextView.placeholderColor = _ansTextView.textColor;
        _ansTextView.delegate = self;
        _ansTextView.placeholder = kPlaceHolderText;
        _ansTextView.placeholderColor = [UIColor colorWithHexString:@"a3a3a3"];
        
    }
    return _ansTextView;
}

//添加图片
- (UIButton *)addImage
{
    if (!_addImage)
    {
        _addImage = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addImage setBackgroundImage:[UIImage imageNamed:@"home_question_addImage_btn"] forState:UIControlStateNormal];
        [_addImage addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImage;
}
//图片显示的View
- (UIView *)imagesView{
    if (_imagesView == nil) {
        _imagesView = [[UIView alloc] initWithFrame:CGRectZero];
        _imagesView.backgroundColor = [UIColor whiteColor];
    }

    return _imagesView;


}

#pragma mark----按钮的点击事件
//导航栏的返回按钮
- (void)BackAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
    
}
//发送回复的按钮
- (void)sendAsk:(UIButton *)btn{
    
    if (!self.ansTextView.text.length) {
        [self.view showWeakPromptViewWithMessage:@"回复不能为空"];
    }
    
    
    [self _requestData];


}

//添加图片按钮的点击事件
- (void)addImage:(UIButton *)btn
{   [self.view endEditing:YES];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    
    [actionSheet showInView:self.view];
    
    
}

#pragma mark----数据的处理
- (void)setInfo:(QuestionInfo *)info{
    _info = info;
    [self _createSubView];

}
- (void)_requestData{
    
    NSString *telephoneNumber = [UserInfo shareUserInfo].userName;
    NSString *userid = [UserInfo shareUserInfo].userId;
    
    //UIImage *image = _arrayPhotos.lastObject;
   NSData *imgData = UIImageJPEGRepresentation(_arrayPhotos.lastObject, 0.1);
    
   // NSData *imgData = nil;

   // NSData *imgData = [NSData dataWithContentsOfFile:_path];
    
    NSDictionary *dic = @{
                          @"wtid":_wtid,
                          @"mobile":telephoneNumber,
                          @"userid":userid,
                          @"hdnr":_ansTextView.text
                         
                                    };
    [self.view showLoadingWihtText:@"发送中"];
    //没有图片的时候
    if (imgData == nil) {
        [[SHHttpClient defaultClient]requestWithMethod:SHHttpRequestPost subUrl:@"?c=tw&m=savewthf" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSString *code = [responseObject objectForKey:@"code"];
            if ([code integerValue]==1) {
                [self.view dismissLoading];
                [self.view showWeakPromptViewWithMessage:@"回答成功"];
                [self.navigationController popViewControllerAnimated:YES];

            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];

    }else{//有图片的时候
        
        
        NSDictionary *fileData = @{
                                   @"upfile":imgData
                                  };
        
         
        [SHHttpClient uploadURL:@"?c=tw&m=savewthf" params:dic fileData:fileData completion:^(id result, NSError *error) {
            
            
            if (error == nil) {
                [self.view dismissLoading];
                [self.view showWeakPromptViewWithMessage:@"回答成功"];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [self.view dismissLoading];
                [self.view  showWeakPromptViewWithMessage:@"回答失败"];
                [self.navigationController popViewControllerAnimated:YES];
                
            
            }
        }];
        
        
         
    }
}

#pragma mark-----通知绑定的方法
//键盘弹出通知绑定的方法
- (void)showKeyboardAction:(NSNotification *)notification{
    //取得键盘信息
    NSDictionary *userInfo = notification.userInfo;
    //取出字典里面对应key的包装好的结构体valuerect
    NSValue *valuerect = userInfo[UIKeyboardBoundsUserInfoKey];
    //将NSValue类型转为CGRect
    CGRect rect = [valuerect CGRectValue];
    //取到键盘的高度
    CGFloat height = rect.size.height;
    //底部视图向上平移
    _bottomView.transform = CGAffineTransformMakeTranslation(0, -height);
     _scrollView.contentSize = CGSizeMake(kScreenSizeWidth, kScreenSizeHeight+height);
    CGFloat y = _questionView.bottom;
    CGFloat y1 =kScreenSizeHeight-kBottomTabBarHeight-height;
    if (y > y1) {
        _scrollView.contentOffset = CGPointMake(0, 160);
    }
    
    
}
//键盘收起
- (void)willHideKeyboardAction:(NSNotification *)notification{

    _bottomView.transform = CGAffineTransformIdentity;

    _scrollView.contentSize =CGSizeMake(kScreenSizeWidth, kScreenSizeHeight+kBottomTabBarHeight);
}

#pragma mark-----UITextViewDeegate
//文本开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ((!textView.text.length
         || [textView.text isEqualToString:@""]))
    {
        [self changeSendButtonStateToEnable:NO];
    }
    
}
//文本已经改变
- (void)textViewDidChange:(UITextView *)textView
{
    if ((textView.text.length
         || ![textView.text isEqualToString:@""])
        && !self.sendButton.enabled)
    {
        [self changeSendButtonStateToEnable:YES];
    }
    
    if ((!textView.text.length
         || [textView.text isEqualToString:@""]) && self.sendButton.enabled)
    {
        [self changeSendButtonStateToEnable:NO];
    }
}
//文本完成编辑
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ((!textView.text.length
         || [textView.text isEqualToString:@""]))
    {
        [self changeSendButtonStateToEnable:NO];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
  
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma ----mark UIActionSheetDelegate的协议方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerControllerSourceType sourceType;
    if (buttonIndex == 0) {
        
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if(buttonIndex == 1){
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else if(buttonIndex == 2){
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = sourceType;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSLog(@"%@",info);
    
    
    //2.取得选中的照片
    UIImage *img = info[UIImagePickerControllerOriginalImage];

      //获取选中的URL
    pictureURL = info[UIImagePickerControllerReferenceURL];
    
    //获取图片的名字
    ALAssetsLibraryAssetForURLResultBlock  resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
       self.imageName = [representation filename];//self.imageName是属性
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init] ;
    [assetslibrary assetForURL:pictureURL
                   resultBlock:resultblock
                  failureBlock:nil];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        //获取图片的类型前的名字,将字符串切割操作
        imagePath = [[self.imageName componentsSeparatedByString:@"."]
                               firstObject];
        
        NSString *aPath=[NSString stringWithFormat:@"%@/Documents/%@.jpg",NSHomeDirectory(),imagePath];
        _path =aPath;
        _imgData = UIImageJPEGRepresentation(img,0.5);
       
    }];
    //3.显示选中的照片
    if (_selectImgView == nil) {
        _selectImgView = [[ZmImageView alloc] initWithFrame:CGRectMake(0, 0, _imagesView.height, _imagesView.height)];
        [_imagesView addSubview:_selectImgView];
        //设置代理对象
        _selectImgView.delegate = self;
    }
    _selectImgView.image = img;
    [_arrayPhotos addObject:img];

}
#pragma mark- ZoomingImgView 协议方法
//图片将要放大
- (void)imageWillZoomin:(ZmImageView *)imageView {
    
    //收起键盘
    [_ansTextView resignFirstResponder];
    //    [self.view endEditing:YES];
}

//图片将要缩小
- (void)imageWillZoomOut:(ZmImageView *)imageView {
    
    //弹出键盘
    [_ansTextView becomeFirstResponder];
}


#pragma mark-----Other
- (void)changeSendButtonStateToEnable:(BOOL)enable
{
    [self.sendButton setEnabled:enable];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
