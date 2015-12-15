//
//  UIScrollView+LGKeyboard.m
//  AgricultureNet
//
//  Created by gft  on 13-11-7.
//  Copyright (c) 2013年 gft . All rights reserved.
//

#import "UIScrollView+LGKeyboard.h"
#import <objc/runtime.h>

static char const * const CurrentInputView = "CurrentInputView";
static char const * const HasEnabled = "HasEnabled";
static char const * const KeyboardFrame = "KeyboardFrame";
static char const * const KeyboardShow = "KeyboardShow";

//Getting UIKeyboardSize.
//kbSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
@implementation UIScrollView (LGKeyboard)

- (void)enableAvoidKeyboard{
    if (![self hasEnabled]) {
        [self addKeyboardNotification];
        [self setHasEnabled:YES];
    }
}

- (void)disableAvoidKeyboard{
    if ([self hasEnabled]) {
        [self removeKeyboardNotification];
        [self setHasEnabled:NO];
    }
}

- (void)addKeyboardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    /*Registering for textField notification*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    
    /*Registering for textView notification*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewdDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:nil];
}

- (void)removeKeyboardNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIKeyboad Delegate methods

- (void)keyboardWillHide:(NSNotification*)aNotification
{
    //设置键盘是否显示标志们为NO
    [self setKeyboardShow:NO];
    
    double duration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self setContentInset:UIEdgeInsetsZero];
        [self setContentOffset:CGPointZero];//添加过的代码???????
        self.scrollIndicatorInsets = UIEdgeInsetsZero;
    }];
}

//UIKeyboard Did show
-(void)keyboardDidShow:(NSNotification*)aNotification
{
    UIView *object = [self currentInputView];
    CGRect keyboardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //设置键盘是否显示标志们为YES
    [self setKeyboardShow:YES];
    
    //设置键盘高宽
    [self setKeyboardFrame:keyboardFrame];
    
    [self avoidKeyboard:object keyboardFrame:keyboardFrame];
}

- (void)avoidKeyboard:(UIView *)inputView keyboardFrame:(CGRect)frame{
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    CGFloat scrollViewMaxY = CGRectGetMaxY(self.bounds);
    
    //取得键盘所在区域相对于scrollView的坐标
    CGRect keyboardRect = [self convertRect:frame fromView:nil];
    CGFloat keyboardMaxY = CGRectGetMaxY(keyboardRect);
    contentInsets.bottom = frame.size.height - (keyboardMaxY - scrollViewMaxY);
    [self setContentInset:contentInsets];
    self.scrollIndicatorInsets = contentInsets;
    
    //计算输入框滚动时, 需要的偏移量
    //取得当前输入框, 相对于self.view的坐标
    CGRect rect = [inputView convertRect:inputView.bounds toView:self];
    
    //输入框的最底部坐标
    CGFloat viewBottom = rect.size.height + rect.origin.y;
    //计算需要偏移的量(输入框相对于scrollView的bottom - 键盘相对于scrollView的top)
    CGFloat shouldOffset = viewBottom - keyboardRect.origin.y;
    //如果偏移量为负的, 则输入框已可见
    if (shouldOffset > 0) {
        
        [self setContentOffset:CGPointMake(0, self.contentOffset.y + shouldOffset) animated:YES];
    }
}

#pragma mark - UITextField Delegate methods
//Fetching UITextField object from notification.
-(void)textFieldDidBeginEditing:(NSNotification*)notification
{
    if ([notification.object isDescendantOfView:self]) {
        [self setCurrentInputView:notification.object];
    }
    
    //如果键盘已显示, 则不会再接收到键盘显示通知, 需要手动调整位置
    if ([self isKeyboardShow]) {
        [self commonDidBeginEditing];
    }
}

//Removing fetched object.
-(void)textFieldDidEndEditing:(NSNotification*)notification
{
    if ([notification.object isDescendantOfView:self]) {
        [self setCurrentInputView:nil];
    }
}

#pragma mark - UITextView Delegate methods
//Fetching UITextView object from notification.
-(void)textViewDidBeginEditing:(NSNotification*)notification
{
    if ([notification.object isDescendantOfView:self]) {
        [self setCurrentInputView:notification.object];
    }
    
    //如果键盘已显示, 则不会再接收到键盘显示通知, 需要手动调整位置
    if ([self isKeyboardShow]) {
        [self commonDidBeginEditing];
    }
}

//Removing fetched object.
-(void)textViewdDidEndEditing:(NSNotification*)notification
{
    if ([notification.object isDescendantOfView:self]) {
        [self setCurrentInputView:nil];
    }
}

// Common code to perform on begin editing
-(void)commonDidBeginEditing {
    if ([self isKeyboardShow])
    {
        // keyboard is already showing. adjust frame.
        [self adjustFrameWithDuration:0];
    }
}

//调整键盘
- (void)adjustFrameWithDuration:(CGFloat)aDuration{
    
    //设置键盘是否显示标志们为YES
    [self setKeyboardShow:YES];
    
    UIView *object = [self currentInputView];
    CGRect keyboardFrame = [self keyboardFrame];
    [self avoidKeyboard:object keyboardFrame:keyboardFrame];
}

//取得当前活动的inputView
- (UIView *)currentInputView{
    return objc_getAssociatedObject(self, CurrentInputView);
}

//设置当前活动的inputView
- (void)setCurrentInputView:(UIView *)textInputView{
    objc_setAssociatedObject(self, CurrentInputView, textInputView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//取得是否启用自动调整键盘
- (BOOL)hasEnabled{
    return [objc_getAssociatedObject(self, HasEnabled) boolValue];
}

//设置是否启用自动调整键盘
- (void)setHasEnabled:(BOOL)hasEnabled{
    NSNumber *number = [NSNumber numberWithBool:hasEnabled];
    objc_setAssociatedObject(self, HasEnabled, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//第四个参数代表强引用
}

//取得键盘是否显示
- (BOOL)isKeyboardShow{
    return [objc_getAssociatedObject(self, KeyboardShow) boolValue];
}

//设置键盘是否显示
- (void)setKeyboardShow:(BOOL)keyboardShow{
    
    NSNumber *show = [NSNumber numberWithBool:keyboardShow];
    objc_setAssociatedObject(self, KeyboardShow, show, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//取得键盘的高宽
- (CGRect)keyboardFrame{
    
    return CGRectFromString(objc_getAssociatedObject(self, KeyboardFrame));
}

//设置键盘的高宽
- (void)setKeyboardFrame:(CGRect)keyboardFrame{
    
    NSString *sizeStr = NSStringFromCGRect(keyboardFrame);
    objc_setAssociatedObject(self, KeyboardFrame, sizeStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)convertFrameWithView:(UIView *)aview bview:(UIView *)bview cview:(UIView *)cview float1:(CGFloat)float1 float2:(CGFloat)float2
{
    CGPoint point = self.contentOffset;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat headerViewHeight =aview.frame.size.height;
    CGFloat subHeaderViewHeight = bview.frame.size.height;
    CGFloat tabviewDy = headerViewHeight + subHeaderViewHeight - point.y;
    if (self.contentOffset.y >= 0 && self.contentOffset.y <float1 - 64
        ) {
        DLOG(@"%@",NSStringFromCGPoint(self.contentOffset));
        aview.frame = CGRectMake(0, -point.y, width, headerViewHeight);
        bview.frame = CGRectMake(0, headerViewHeight - point.y, width, subHeaderViewHeight);
        cview.frame = CGRectMake(0,headerViewHeight + subHeaderViewHeight - point.y, width,height - tabviewDy - 50);
    }
    if (self.contentOffset.y <= -0.0000009) {
        aview.frame = CGRectMake(0, 0, width, float1);
        bview.frame = CGRectMake(0, float1, width, subHeaderViewHeight);
        cview.frame = CGRectMake(0, headerViewHeight + subHeaderViewHeight, width, height - float2 - subHeaderViewHeight - 49);
    }
    if (self.contentOffset.y >= float1 - float2) {
        bview.frame = CGRectMake(0, float2, width, subHeaderViewHeight);
        cview.frame = CGRectMake(0, float2 + subHeaderViewHeight, width, height - float2 - subHeaderViewHeight - 49);
    }

}

@end
