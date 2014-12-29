
//

#import <UIKit/UIKit.h>

@protocol HearViewDelegate <NSObject>

@optional
-(void)leftButtonAction;//左边按钮点击
-(void)rightButtonAction;//右边按钮点击

@end

/**
 *  自定义导航栏
 */
@interface HearView : UIView
/**
 *  初始化一个导航栏
 *
 *  @param titleStr   导航栏的标题，为空时，不显示
 *  @param leftImage  导航栏左边的按钮图片，为空时，不显示
 *  @param rightImage 导航栏右边的按钮图片，为空时，不显示
 *  @param delegate   导航栏按钮点击的代理
 *
 *  @return 初始化好的导航栏
 */
-(id)initWithTitle:(NSString *)titleStr WithLeftText:(NSString *)leftText WithLeftImage:(NSString*)leftImage WithRightText:(NSString* )rightText WithRightImage:(NSString*)rightImage WithViewControl:(id<HearViewDelegate>) delegate;
@end

