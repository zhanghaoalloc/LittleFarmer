//
//  AskViewController.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "AskViewController.h"
#import "BaseViewController+Navigation.h"
#import "GCPlaceholderTextView.h"
#import "AskCropNameView.h"
#import "AskSendModel.h"
#import "XDPhotoSelect.h"
#import "RootTabBarViewController.h"
#import "MTAssetsPickerController.h"
#import "MTPickerInfo.h"
#import "ImagesView.h"
#import "AskScrollView.h"
#import "UIScrollView+LGKeyboard.h"


#import "ZLPhoto.h"
#import "ZLPhotoAssets.h"



#define kPlaceHolderText @"请描述作物的异常情况和您的问题, 越详细专家越好给您准确的回答哟! (必填)"
#define kCountOfNumber 3
#define kImagesCount 6

@interface AskViewController ()<XDPhotoSelectDelegate,MTAssetsPickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,ImagesViewDelegate,ZLPhotoPickerViewControllerDelegate,ZLPhotoPickerBrowserViewControllerDataSource,ZLPhotoPickerBrowserViewControllerDelegate>

@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) GCPlaceholderTextView *askTextView;
@property (nonatomic, strong) GCPlaceholderTextView *nameTextView;
@property (nonatomic, strong) UIScrollView *askScrollview;
@property (nonatomic, strong) AskCropNameView *askCropNameView;
@property (nonatomic, strong) UIButton *addImageButton;
@property (nonatomic, strong) XDPhotoSelect *photoSelect;
@property (nonatomic, strong) MTPickerInfo *info;
@property (nonatomic, strong) AskSendModel *sendModel;

//显示图片的view
@property (nonatomic, strong) ImagesView *imagesView;

/// 存放的对象是 MTPickerInfo 类型
@property (nonatomic, strong) NSMutableArray *arrayPhotos;

//存放的对象是 assets类型的
@property (nonatomic ,strong)NSMutableArray *assets;


@end

@implementation AskViewController{

    NSInteger index;

}
- (NSMutableArray *)assetsArray{
    
    if(!_assets){
        _assets = [NSMutableArray array];
        
    }
    return _assets;
        
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.assets = [self assetsArray];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.arrayPhotos = [NSMutableArray array];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(dismissAskVC:)];
    [self setBarTitle:@"我的问题"];
    [self setLineToBarBottomWithColor:[UIColor colorWithHexString:@"#a3a3a3"] heigth:kLineWidth];
    [self initNavigationbgView:[UIColor colorWithHexString:@"#ffffff"]];
    [self addSubviews];
    [self addGesture];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate hideTabbar];
    
    //[self addSubviews];
    [self setNavigationBarIsHidden:YES];
    
    [self.askScrollview enableAvoidKeyboard];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   

    
    [self setNavigationBarIsHidden:NO];
    [self.view setNeedsDisplay];
    
    [self.askScrollview disableAvoidKeyboard];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - event
//切换控制器到主页
- (void)dismissAskVC:(UIButton *)btn{
    
    
    //[self.imagesView clearPicture];
   
   // UIView *view = self.view;
      
    [self.navigationController popViewControllerAnimated:YES];
    
   // [self changeSelectedVC:0];
    
}

- (void)sendAsk:(UIButton *)btn
{
    if (_zjid == nil) {
        _zjid = @"0";
    }
    
    //判断问题描述是否为空
    if (!self.askTextView.text.length)
    {
        [self.view showWeakPromptViewWithMessage:@"问题描述不能为空"];
        return;
    }
    else if (!self.askCropNameView.text.length)
    {
        [self.view showWeakPromptViewWithMessage:@"作物名称不能为空"];
        return;
    }
    NSDictionary *dic =
    @{/*@"c":@"tw",@"m":@"savetw",*/
      @"userid":[APPHelper safeString:[[MiniAppEngine shareMiniAppEngine] userId]],
      @"mobile":[APPHelper safeString:[[MiniAppEngine shareMiniAppEngine] userLoginNumber]],
      @"zjid":_zjid,
      @"zwmc":self.askCropNameView.text,
      @"wtms":self.askTextView.text};
    
    __weak AskViewController *wself = self;
    [self.view showLoadingWihtText:@"发送中"];
    
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestPost subUrl:@"?c=tw&m=savetw" parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        wself.sendModel = [[AskSendModel alloc] initWithDictionary:
                           (NSDictionary *)responseObject error:nil];
        NSNumber *code = [responseObject objectForKey:@"code"];
        int  i = [code intValue];
        if (i == 1) {
            [wself sendPicture];
        
        }
        else
        {
            [self.view showWeakPromptViewWithMessage:wself.sendModel.msg];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

   }
- (void)sendPicture{
    UIImage *image ;
    for (int i = 0;i<self.arrayPhotos.count-1; i++) {
        ZLPhotoAssets *info = self.arrayPhotos[i];
        if ([info isKindOfClass:[UIImage class]]) {
            image = (UIImage *)info;
        }else{
            image = info.originImage;
        }
        NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
        NSString  *wtid = _sendModel.wtid;
        NSString *number = [NSString  stringWithFormat:@"%d",i+1];
        NSDictionary * dic =@{
                              @"twid":wtid,
                              @"zpxh":number                             };
        NSDictionary *fileData = @{
                                   @"upfile":imgData
                                   };
        __weak AskViewController *wself = self;
        [SHHttpClient uploadURL:@"?c=tw&m=do_uploadtw" params:dic fileData:fileData completion:^(id result, NSError *error) {
            if (error == nil ) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    index ++;
                    if (index == (wself.arrayPhotos.count-1)) {
                        [wself.view dismissLoading];
                        [wself.view showWeakPromptViewWithMessage:@"发送成功"];
                        [self dismissAskVC:nil];
                    }
                });
            }else {
            }
        }];
    }
}
//此方法用于统计图片是否选择成功
#pragma mark - subviews
- (void)addSubviews
{
    [self.view addSubview:self.askScrollview];
    [self.view addSubview:self.sendButton];
    [self.askScrollview addSubview:self.askTextView];
    [self.askScrollview addSubview:self.askCropNameView];
    [self.askScrollview addSubview:self.imagesView];
    
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight + 8);
        make.size.mas_equalTo(CGSizeMake(56, 28));
    }];
    
    CGRect subRect = self.view.bounds;
    subRect.origin.y = kStatusBarHeight + kNavigationBarHeight + kLineWidth;
    subRect.size.height -= kBottomTabBarHeight + kStatusBarHeight + kNavigationBarHeight + kLineWidth;
    [self.askScrollview setFrame:subRect];
    
    subRect.origin.x = 12;
    subRect.origin.y = 12 ;
    subRect.size.width = kScreenSizeWidth - 2 * 12;
    subRect.size.height = 160;
    self.askTextView.frame = subRect;
    
    subRect.origin.y = CGRectGetMaxY(self.askTextView.frame);
    subRect.size.width = kScreenSizeWidth - 12;
    subRect.size.height = 48;
    self.askCropNameView.frame = subRect;
    
    subRect.origin.y = CGRectGetMaxY(self.askCropNameView.frame) + 18;
    subRect.size.width = kScreenSizeWidth - 2 * 12;
    self.imagesView.frame = subRect;
    
    [self reloadImagesView];
}
- (ImagesView *)imagesView
{
    if (!_imagesView)
    {
        _imagesView = [[ImagesView alloc] initWithFrame:CGRectZero];
        _imagesView.delegate = self;
    }
    return _imagesView;
}

- (UIScrollView *)askScrollview
{
    if (!_askScrollview)
    {
        _askScrollview = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _askScrollview.showsHorizontalScrollIndicator = NO;
    }
    return _askScrollview;
}

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

- (UITextView *)askTextView
{
    if (!_askTextView)
    {
        _askTextView = [[GCPlaceholderTextView alloc] initWithFrame:CGRectZero];
        _askTextView.textColor = [UIColor colorWithHexString:@"#333333"];
        _askTextView.font = kTextFont(14);
        _askTextView.placeholderColor =[UIColor colorWithHexString:@"#a3a3a3"];
        _askTextView.delegate = self;
        _askTextView.placeholder = kPlaceHolderText;
        
    }
    return _askTextView;
}

- (AskCropNameView *)askCropNameView
{
    if (!_askCropNameView)
    {
        _askCropNameView = [[AskCropNameView alloc] initWithFrame:CGRectZero];
    }
    return _askCropNameView;
}

#pragma mark - textdelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ((!textView.text.length
         || [textView.text isEqualToString:@""]))
    {
        [self changeSendButtonStateToEnable:NO];
    }

}

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

#pragma mark - imagesViewDelegate
//添加
- (void)imagesView:(ImagesView *)imagesView selectedItem:(NSInteger)selectedItem
{
    id info = [self.arrayPhotos objectAtIndex:selectedItem];
    
    if ([info isKindOfClass:[MTPickerInfo class]])
    {//创建控制器
        ZLPhotoPickerViewController *pickerVC = [[ZLPhotoPickerViewController alloc] init];
      //  pickerVC.selectPickers = [self assets];
        pickerVC.topShowPhotoPicker = YES;
        pickerVC.status = PickerViewShowStatusCameraRoll ;
        pickerVC.maxCount = 6-self.assets.count;
        pickerVC.delegate = self;
        //pickerVC.editing = YES;
        [pickerVC showPickerVc:self];
    }
    else
    {
        //[self.assets removeLastObject];
        ZLPhotoPickerBrowserViewController *browserVc = [[ZLPhotoPickerBrowserViewController alloc] init];
        browserVc.editing = YES;
        browserVc.delegate = self;
        browserVc.dataSource = self;
        if (self.assets.count>6) {
            [self.assets removeLastObject];
        }
        browserVc.currentIndexPath =  [NSIndexPath indexPathForRow:0
                                                         inSection:0];
        [self presentViewController:browserVc animated:YES completion:nil];
        }
}
#pragma ----mark图片选择器的代理方法
- (NSInteger)numberOfSectionInPhotosInPickerBrowser:(ZLPhotoPickerBrowserViewController *)pickerBrowser{

    return 1;
}
- (NSInteger)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section{
    
    
    
    NSInteger  count = self.assets.count;
    
    return count;

   
}
#pragma mark - 点击Cell通知拍照代理
- (void)pickerCollectionViewSelectCamera:(ZLPhotoPickerViewController *)pickerVc withImage:(UIImage *)image{
    NSLog(@" --- 拍照回调: %@",image);
}

#pragma mark - <ZLPhotoPickerBrowserViewControllerDelegate>
#pragma mark 删除调用
- (void)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser removePhotoAtIndexPath:(NSIndexPath *)indexPath{
    // 删除照片时调用
    if (indexPath.row > [self.assets count]) return;
    
    [self.assets removeObjectAtIndex:indexPath.row];
    [self.arrayPhotos  removeObjectAtIndex:indexPath.row];
    [self.arrayPhotos removeLastObject];
    
    [self  reloadImagesView];
}

- (ZLPhotoPickerBrowserPhoto *) photoBrowser:(ZLPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath{
    ZLPhotoAssets *imageObj = [self.assets objectAtIndex:indexPath.row];
    // 包装下imageObj 成 ZLPhotoPickerBrowserPhoto 传给数据源
    ZLPhotoPickerBrowserPhoto *photo = [ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:imageObj];
    if ([imageObj isKindOfClass:[UIImage class]]) {
        photo.thumbImage = (UIImage *)imageObj;
    }else {
        photo.thumbImage = imageObj.originImage;
    }

       return photo;
}




#pragma mark - other
//切换控制器
- (void)changeSelectedVC:(NSInteger)selectedIndex
{
    
    [self.navigationController.tabBarController setSelectedIndex:selectedIndex];
    [(RootTabBarViewController *)(self.navigationController.tabBarController) changeIndexToSelected:selectedIndex];
}
//发送;
- (void)changeSendButtonStateToEnable:(BOOL)enable
{
    [self.sendButton setEnabled:enable];
}
//存放照片的数组
- (NSMutableArray *)imagesArr
{
    if (self.arrayPhotos.count < kImagesCount)
    {
        MTPickerInfo *pictureInfo = [MTPickerInfo new];
        pictureInfo.isSelectImage = YES;
        pictureInfo.image = [UIImage imageNamed:@"asd_btn_addimage"];
        [self.arrayPhotos addObject:pictureInfo];
        
    }
    return self.arrayPhotos;
}
//重新加载存放图片的视图
- (void)reloadImagesView
{
    [self.imagesView reloadDataWithImagesInfo:[self imagesArr]];
    self.askScrollview.contentSize = CGSizeMake(kScreenSizeWidth, CGRectGetMaxY(self.imagesView.frame) + kBottomTabBarHeight);
}
//新的视图数组
- (NSMutableArray *)newImagesWithImages:(NSMutableArray *)infos
{
    NSMutableArray *newImages = [[NSMutableArray alloc] initWithArray:infos];
    
    MTPickerInfo *info = [newImages lastObject];
    if (info.isSelectImage)
    {
        [newImages removeObject:info];
    }
    return newImages;
}
#pragma mark----相册回调
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    
    [self.arrayPhotos removeLastObject];
    
    
    
    for (int i=0; i<assets.count; i++) {
        ZLPhotoAssets *Asset = assets[i];
        
        if (self.assets.count<=6) {
             [self.assets addObject:Asset];
        }
        if (self.arrayPhotos.count <= 6) {
             [self.arrayPhotos addObject:Asset];
        }
    
       
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        //TODO: 更新UI
        //显示图片
        [self reloadImagesView];
    });
}


@end
