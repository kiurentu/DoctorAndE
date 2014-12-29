//
//  ScanViewController.m
//  DoctorAndE
//
//  Created by kang on 14-12-15.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "ScanViewController.h"
#import "CircleEdge.h"
#import "ZBarSDK.h"
#define  kSymbolData @"symbolData"
@interface ScanViewController ()< ZBarReaderViewDelegate >
{
    UIView *_QrCodeline;
    NSTimer *_timer;
    //设置扫描画面
    UIView *_scanView;
    ZBarReaderView *_readerView;
}
@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"条形码/二维码扫描" withViewController:self];
    //初始化扫描界面
    [ self setScanView ];
    _readerView = [[ ZBarReaderView alloc ] init ];
    _readerView . frame = self.view.frame;
    _readerView . tracksSymbols = NO ;
    _readerView . readerDelegate = self ;
    [ _readerView addSubview : _scanView ];
    //关闭闪光灯
    _readerView . torchMode = 0 ;
    [ self . view addSubview : _readerView ];
    //扫描区域
    //readerView.scanCrop =
    [ _readerView start ];
    [ self createTimer ];

}


- (void) readerView:(ZBarReaderView *)readerView didReadSymbols: (ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    ZBarSymbol * s = nil;
    for (s in symbols)
    {
        NSLog(@"%@",s.data);
        break;
        
    }
    //使用blcok传序列号
    if (s.data!=nil) {
        if (self.blcok) {
            self.blcok(s.data);
             [self.navigationController popViewControllerAnimated:YES];
        }
   }
  

}

- ( void )setScanView
{
    _scanView =[[ UIView alloc ] initWithFrame : self.view.frame];
    _scanView . backgroundColor =[ UIColor clearColor ];
    _scanCropView.layer.borderColor =[UIColor greenColor].CGColor;
    CGRect frame = _scanCropView.frame;
    _QrCodeline = [[ UIView alloc ] initWithFrame : CGRectMake (frame.origin.x ,frame.origin.y ,frame.size.width , 1 )];
    _QrCodeline.backgroundColor = [ UIColor greenColor];
    [ _scanView addSubview:_QrCodeline ];
    [self.view insertSubview:_topView aboveSubview:_scanView];
    [self.view insertSubview:_leftView aboveSubview:_scanView];
    [self.view insertSubview:_rightView aboveSubview:_scanView];
    [self.view insertSubview:_bottomView aboveSubview:_scanView];
    [_scanView addSubview:_topView];
    [_scanView addSubview:_leftView];
    [_scanView addSubview:_rightView];
    [_scanView addSubview:_bottomView];
}

- ( void )viewWillDisappear:( BOOL )animated
{
    [ super viewWillDisappear :animated];
    if ( _readerView . torchMode == 1 ) {
        _readerView . torchMode = 0 ;
    }
    [ self stopTimer ];
    [ _readerView stop ];
  
  
}

- ( void )moveUpAndDownLine
{     CGRect frame = _scanCropView.frame;
    CGFloat Y= _QrCodeline.frame.origin.y ;
    if (frame.origin.y==Y){
         _QrCodeline.alpha =1;
        [UIView beginAnimations: @"asa" context: nil ];
        [UIView setAnimationDuration: 1 ];
        _QrCodeline.frame=CGRectMake(frame.origin.x,self.bottomView.frame.origin.y, frame.size.width, 1 );
        [UIView commitAnimations];

    } else if (self.bottomView.frame.origin.y==Y){
       
                _QrCodeline.alpha =0;
        _QrCodeline.frame=CGRectMake (frame.origin.x,frame.origin.y,frame.size.width,1);
    }
}

- ( void )createTimer
{
    //创建一个时间计数
    _timer=[NSTimer scheduledTimerWithTimeInterval: 0.9 target: self selector: @selector (moveUpAndDownLine) userInfo: nil repeats: YES ];
}
- ( void )stopTimer
{
    if ([_timer isValid] == YES ) {
        [_timer invalidate];
        _timer = nil ;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
