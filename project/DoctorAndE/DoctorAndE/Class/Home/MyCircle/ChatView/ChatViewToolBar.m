//
//  ChatViewToolBar.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-18.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "ChatViewToolBar.h"
#import "ChatViewFace.h"

@interface ChatViewToolBar () <UITextViewDelegate>
{
    CGRect  toolViewF;
    CGRect  tbF;
    CGRect  horF;
    CGRect  sViewF;
    CGRect  btnFaceF;
    CGRect  tvF;
}
@property (weak, nonatomic) IBOutlet UIButton   *btnSend;
@property (weak, nonatomic) IBOutlet UIView     *horView;
@property (weak, nonatomic) IBOutlet UIView     *sView;
@property (weak, nonatomic) IBOutlet UIButton   *btnFace;
@property (weak, nonatomic) IBOutlet UITextView *tv;
@property (weak, nonatomic) IBOutlet UIButton   *btnWay;
@property (weak, nonatomic) IBOutlet UIButton   *btnVoice;
@property (strong, nonatomic) UIView            *addView;
@property (strong, nonatomic) ChatViewFace      *faceView;
@end

@implementation ChatViewToolBar

+ (ChatViewToolBar *)instance
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"ChatViewToolBar" owner:nil options:nil];

    return [nibView objectAtIndex:0];
}

- (instancetype)init
{
    self = [super init];

    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationWillResignActiveNotification object:nil];
        _tv.delegate = self;
        [_btnFace setBackgroundImage:IMAGE(@"tabbar_ic表情pressed") forState:UIControlStateHighlighted];
        [_btnWay setImage:IMAGE(@"tabbar_ic键盘-normal") forState:UIControlStateSelected];
        self.frame = (CGRect) {{0, SCREEN_HEIGHT - self.frame.size.height - 64}, self.frame.size};
        toolViewF = self.frame;
        horF = _horView.frame;
        sViewF = _sView.frame;
        btnFaceF = _btnFace.frame;
        tvF = _tv.frame;
        self.addView = [[NSBundle mainBundle] loadNibNamed:@"ChatViewAddData" owner:nil options:nil][0];
        self.faceView = [[ChatViewFace instance] initWIthTextView:_tv];
        [self.btnSend setBackgroundImage:[Tools createImageWithColor:RGBCOLOR(5, 126, 101)] forState:UIControlStateHighlighted];
        [self.btnVoice setBackgroundImage:IMAGE(@"btn_pressed") forState:UIControlStateHighlighted];
    }

    return self;
}

- (instancetype)initWithTableView:(UITableView *)tb
{
    self = [self init];

    if (self) {
        self.tbView = tb;
    }

    return self;
}

- (void)setTbView:(UITableView *)tbView
{
    _tbView = tbView;
    tbF = _tbView.frame;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

// 隐藏AddView
- (void)hideAddView {
    if ([_addView superview]) {
        [UIView animateWithDuration:.2f animations:^{
            [_addView removeFromSuperview];
            self.frame = (CGRect) {{0, SCREEN_HEIGHT - self.frame.size.height - 64}, self.frame.size};
            _tbView.frame = tbF;
//            _tbView.frame = (CGRect){ tbF.origin, {tbF.size.width, tbF.size.height - 44 - self.frame.size.height} }; // tbView暂未调整大小
        }];
    }
}

// 隐藏表情选择
- (void)hideFaceView {
    if([_faceView superview]) {
        [UIView animateWithDuration:.2f animations:^{
            [_faceView removeFromSuperview];
            self.frame = (CGRect) {{0, SCREEN_HEIGHT - self.frame.size.height - 64}, self.frame.size};
            _tbView.frame = tbF;
            //            _tbView.frame = (CGRect){ tbF.origin, {tbF.size.width, tbF.size.height - 44 - self.frame.size.height} };
        }];
    }
}

// 转换到文字输入
- (void)changeToWord {
    if (_btnWay.isSelected) {
        _btnVoice.hidden = YES;
        [_tv becomeFirstResponder];
        [self textViewDidChange:_tv];
        _btnWay.selected = NO;
    }
}

- (IBAction)voiceStartClick:(id)sender {
    [_btnVoice setTitle:@"松开 发送" forState:UIControlStateNormal];
}

- (IBAction)voiceEndUp:(id)sender {
    [_btnVoice setTitle:@"按住 说话" forState:UIControlStateNormal];
}

- (IBAction)voiceCancleEvent:(id)sender {
    [_btnVoice setTitle:@"按住 说话" forState:UIControlStateNormal];
}

- (IBAction)btnWayClick:(UIButton *)sender
{
    BOOL isSelect = sender.selected;

    if (isSelect) {
        [self changeToWord];
    } else {
        [self hideAddView];
        [self hideFaceView];
        [self.superview endEditing:YES];
        _btnVoice.hidden = NO;
        _btnSend.hidden = YES;
        self.frame = toolViewF;
    }

    sender.selected = !isSelect;
}

- (IBAction)btnFaceClick:(id)sender
{
    if (![_faceView superview]) {
        [self hideAddView];
        [self.superview endEditing:YES];
        CGRect f = _faceView.frame;
        _faceView.frame = (CGRect) {
            {0, SCREEN_HEIGHT - 64}, f.size
        };
        [self.superview addSubview:_faceView];
        
        [UIView animateWithDuration:.2f animations:^{
            _faceView.frame = (CGRect) {
                {0, SCREEN_HEIGHT - f.size.height - 64}, f.size
            };
            self.frame = (CGRect) {
                {0, SCREEN_HEIGHT - f.size.height - self.frame.size.height - 64}, self.frame.size
            };
            _tbView.frame = (CGRect) {
                {0, 0}, {tbF.size.width, tbF.size.height - f.size.height}
            };
        }];
    } else {
        [self hideFaceView];
    }
}

- (IBAction)btnSendClick:(id)sender
{
    _tv.text = @"";
    [self textViewDidChange:_tv];
}

- (IBAction)btnAddClick:(id)sender
{
    if (![_addView superview]) {
        [self changeToWord];
        [self hideFaceView];
        [self.superview endEditing:YES];
        CGRect f = _addView.frame;
        _addView.frame = (CGRect) {
            {0, SCREEN_HEIGHT - 64}, f.size
        };
        [self.superview addSubview:_addView];

        [UIView animateWithDuration:.2f animations:^{
            _addView.frame = (CGRect) {
                {0, SCREEN_HEIGHT - f.size.height - 64}, f.size
            };
            self.frame = (CGRect) {
                {0, SCREEN_HEIGHT - f.size.height - self.frame.size.height - 64}, self.frame.size
            };
            _tbView.frame = (CGRect) {
                {0, 0}, {tbF.size.width, tbF.size.height - f.size.height}
            };
        }];
    } else {
        [self hideAddView];
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self hideAddView];
    [self hideFaceView];
    [UIView animateWithDuration:.2f animations:^{
        self.frame = (CGRect) {
            {0, self.frame.origin.y - 216}, self.frame.size
        };
        _tbView.frame = (CGRect) {tbF.origin, {tbF.size.width, tbF.size.height - 216}};
    }];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:.2f animations:^{
        self.frame = self.frame = (CGRect) {{0, SCREEN_HEIGHT - self.frame.size.height - 64}, self.frame.size};;
        _tbView.frame = tbF;
    }];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text length]) {
        [textView scrollRangeToVisible:range];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGSize size = [textView.text sizeWithFont:textView.font];
    int length = size.height;
    int colomNumber = length?textView.contentSize.height/length:1;
    [UIView animateWithDuration:.1f animations:^{
        if(colomNumber > 1) {
            self.frame = (CGRect){ {0, toolViewF.origin.y - (_faceView.superview?_faceView.frame.size.height:216) - tvF.size.height/2}, {toolViewF.size.width, toolViewF.size.height+tvF.size.height/2} };
        } else {
            self.frame = (CGRect) { {0, toolViewF.origin.y - (_faceView.superview?_faceView.frame.size.height:216)}, toolViewF.size};
        }
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.01f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.1f animations:^{
            if (![textView.text length]) {
                _btnSend.hidden = YES;
                _horView.frame = horF;
                _sView.frame = sViewF;
                _btnFace.frame = btnFaceF;
                _tv.frame = tvF;
            } else {
                _btnSend.hidden = NO;
                _horView.frame = (CGRect) {_horView.frame.origin, {horF.size.width - 25, horF.size.height}};
                _sView.frame = (CGRect) {
                    {sViewF.origin.x - 25, _sView.frame.origin.y}, sViewF.size
                };
                _btnFace.frame = (CGRect) {
                    {btnFaceF.origin.x - 25, _btnFace.frame.origin.y}, btnFaceF.size
                };
                _tv.frame = (CGRect) {_tv.frame.origin, {tvF.size.width - 25, _tv.frame.size.height}};
            }
        }];
    });
}

#pragma mark - Notification
- (void)applicationDidBecomeActive:(NSNotification *)ntf
{
    [self.superview endEditing:YES];
}

@end