//
//  MineChangeTXController.m
//  MiniFarmer
//
//  Created by 牛筋草 on 15/12/21.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "MineChangeTXController.h"
#import "BaseViewController+Navigation.h"
#import "ZmImageView.h"
#import "UserInfo.h"


//获取图片路径的类
#import <AssetsLibrary/AssetsLibrary.h>
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

@interface MineChangeTXController ()



@property(nonatomic,strong)UIButton *changeButton;
@property(nonatomic,strong)UIView *bottomView;


@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,strong)ZmImageView *selectImgView;
@property(nonatomic,copy)NSString *path;
@property(nonatomic,strong)NSData *imgData;








@end

@implementation MineChangeTXController{

    UIImageView *_imageView;
    NSURL *pictureURL;
    NSString *imagePath;
    

}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self _createSubView];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self initnavigationBackbutton];
    [self initTitleLabel:@"查看头像"];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self _createSubView];
    
}
- (void)initnavigationBackbutton{
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0,kStatusBarHeight,44, 44)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"home_navigation_back_btn"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"home_navigation_back_btn"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    

    _changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_changeButton setFrame:CGRectMake(kScreenSizeWidth-64, kStatusBarHeight, 44, 44)];
    [_changeButton setTitle:@"更换" forState:UIControlStateNormal];
    [_changeButton setTitleColor:[UIColor colorWithHexString:@"#3872f4"] forState:UIControlStateNormal];
    [self.view addSubview:_changeButton];
    _changeButton.tag = 1;
    [_changeButton addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight+kStatusBarHeight-0.5, kScreenSizeWidth, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.view addSubview:line];
    [self.view addSubview:backButton];
    
    //初始化发送按钮
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(kScreenSizeWidth-64,0,44, 44);
    [sendButton setTitle:@"使用" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor colorWithHexString:@"#3872f4"] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    sendButton.tag = 2;
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenSizeHeight-kBottomTabBarHeight,kScreenSizeWidth , kBottomTabBarHeight)];
    _bottomView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _bottomView.hidden = YES;
    [self.view addSubview:_bottomView];
    
    
    [_bottomView addSubview:sendButton];
    
    
    
}
- (void)backAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)changeAction:(UIButton *)button{
    if (button.tag == 1) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        
        [actionSheet showInView:self.view];
    }else{//发送网络请求
        NSDictionary *dic;
        NSString *subURL;
        

        NSString *userid = [UserInfo shareUserInfo].userId;
        subURL = @"?c=user&m=edit_usertx";
            dic = @{
                    @"userid":userid
                    };
            
        NSDictionary *filedata = @{
                                   @"upfile":_imgData
                                   };
        
        
        __weak MineChangeTXController *wself = self;
        [SHHttpClient uploadURL:subURL params:dic fileData:filedata completion:^(id result, NSError *error) {
            if (error == nil) {
                [wself.view showWeakPromptViewWithMessage:@"更改成功"];
                [wself backAction:nil];
            }
            
        }];
    }
    
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
    
    [_imageView setImage:img];
    _scrollView.backgroundColor = [UIColor blackColor];
    _bottomView.hidden = NO;
    //[self.view reloadInputViews];
    //_scrollView.alpha = 0.5;
    
    
    
    
}

#pragma mark
//大图浏览
- (void)_createSubView{
   
    _scrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kScreenSizeWidth, kScreenSizeHeight-(kStatusBarHeight+kNavigationBarHeight))];
    _scrollView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    //设置最大最小的缩小倍数
    _scrollView.maximumZoomScale = 2;
    _scrollView.minimumZoomScale = 1;
    
    //设置隐藏滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    //
    _scrollView.delegate = self;
    [self.view insertSubview:_scrollView atIndex:0];
    
    _imageView = [[UIImageView alloc] initWithFrame:_scrollView.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_imageView];

    //双击手势
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction2:)];
    tap2.numberOfTapsRequired = 2;   // 点击的次数
    tap2.numberOfTouchesRequired = 1;  //点击所使用的手指数
    [_scrollView addGestureRecognizer:tap2];
    //单击手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction1:)];
    [_scrollView addGestureRecognizer:tap1];
    
    //当tap2手势触发的时候，让tap1失效
    [tap1 requireGestureRecognizerToFail:tap2];
    
}

- (void)tapAction2:(UITapGestureRecognizer *)tap{
    
    if (_scrollView.zoomScale > 1) {  //大于1,说明已经放大了
        [_scrollView setZoomScale:1 animated:YES];
    } else {
        [_scrollView setZoomScale:2 animated:YES];
    }
    
   
}
- (void)tapAction1:(UITapGestureRecognizer *)tap{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark---数据处理
- (void)setUrl:(NSString *)url{
    _url = url;

    NSURL *iconURL;
    if ([_url rangeOfString:@"http://www.enbs.com.cn"].location!= NSNotFound) {
        //有前缀
        iconURL = [NSURL URLWithString:[APPHelper safeString:_url]];
        
    }else{
        NSString *str = [kPictureURL stringByAppendingString:_url];
        iconURL =[NSURL URLWithString:[APPHelper safeString:str]];
    }

    [_imageView sd_setImageWithURL:iconURL];

}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}

- (void)setZjid:(NSString *)zjid{
    _zjid = zjid;
    if (_zjid ==nil) {
        self.changeButton.hidden = NO;
    }else{
    
        self.changeButton.hidden = YES;
    }
}





@end
