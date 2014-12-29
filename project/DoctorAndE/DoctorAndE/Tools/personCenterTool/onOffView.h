
// 自定义开关

#import <UIKit/UIKit.h>

@class onOffView;
@protocol onOffViewDelegate
-(void)swipeLeftFromOnOffView:(onOffView *)aView;
-(void)swipeRightFromOnOffView:(onOffView *)aView;
@end


@interface onOffView : UIView
{
    CGPoint beginPoint;
}
@property (assign, nonatomic)__unsafe_unretained id <onOffViewDelegate>delegate;
@property (strong, nonatomic)UIImageView *bgImageV;
@property (strong, nonatomic)UIImageView *onOffBtn;
@property (assign)BOOL isShowListViewRight;

- (void)setisShowListViewRight:(BOOL)bol;
-(void)swipeLeftView;
-(void)swipeRightView;

@end
