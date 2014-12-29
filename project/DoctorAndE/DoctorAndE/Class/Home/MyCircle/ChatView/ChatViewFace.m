//
//  ChatViewFace.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-18.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "ChatViewFace.h"
#import "UIImage+Scale.h"

@interface ChatViewFace () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
{
    float   w;      // cell大小
    int     totle;  // cell总数
    int     ld;     // 最后一个删除按钮的位置
}
@property (weak, nonatomic) IBOutlet UIPageControl      *pagerControl;
@property (weak, nonatomic) IBOutlet UICollectionView   *collectionView;
@property (strong, nonatomic) NSArray                   *datas;
@property (weak, nonatomic) UITextView                  *tv;
@end

@implementation ChatViewFace

+ (ChatViewFace *)instance
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"ChatViewFace" owner:nil options:nil];

    return [nibView objectAtIndex:0];
}

- (instancetype)init
{
    self = [super init];

    if (self) {
        _datas = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"faces" ofType:@"plist"]];
        _pagerControl.numberOfPages = _datas.count / 20 + (_datas.count % 20 ? 1 : 0);
        totle = _pagerControl.numberOfPages * 21;
        ld = _datas.count % 20;

        if (ld) {
            ld /= 7;
            ld = (_pagerControl.numberOfPages - 1) * 21 - 1 + 21 + ld - 2;
        } else {
            ld = -1;
        }

        w = self.frame.size.width / 7 - 11.8f;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }

    return self;
}

- (instancetype)initWIthTextView:(UITextView *)tv
{
    self = [self init];

    if (self) {
        self.tv = tv;
    }

    return self;
}

// 位置转换
- (int)changeIndex:(int)indexPath
{
    int row = indexPath - indexPath / 21;
    int y = row / 20; // 页数

    if (((y != _pagerControl.numberOfPages) && indexPath && !((indexPath + 1) % 21)) || (indexPath == ld)) {
        return -1;
    } else {
        int h = (row + row / 20) % 3;   // 行数
        int l = (row - y * 20) / 3;     // 列数
        int i = y * 20 + h * 7 + l;
        return i;
    }
}

#pragma mark - UICollectionViewDataSoure
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return totle;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];

    if (!cell.backgroundView) {
        cell.backgroundView = [[UIImageView alloc] init];
        cell.selectedBackgroundView = [[UIImageView alloc] init];
    }

    int i = [self changeIndex:indexPath.row];

    if (i == -1) {
        ((UIImageView *)cell.backgroundView).image = IMAGE(@"emotion_del_normal");
        ((UIImageView *)cell.selectedBackgroundView).image = IMAGE(@"emotion_del_down");
    } else {
        NSString *img = i < _datas.count ? _datas[i][@"img"] : @"";
        ((UIImageView *)cell.backgroundView).image = IMAGE(img);
        ((UIImageView *)cell.selectedBackgroundView).image = IMAGE(img);
    }

    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    int i = [self changeIndex:indexPath.row];

    NSRange         r = _tv.selectedRange;
    NSMutableString *text = [_tv.text mutableCopy];

    if ((i == -1) && [text length] && r.location) {
        if (r.length) {
            [text replaceCharactersInRange:r withString:@""];
            r.length = 0;
        } else {
            r.location -= 1;
            r.length = 1;
            NSString *willR = [text substringWithRange:r];

            if ([willR isEqualToString:@"]"]) {
                NSRange rg = [text rangeOfString:@"[" options:NSBackwardsSearch];

                if (r.location - rg.location - 1 < 4) {
                    r.length = r.location - rg.location + 1;
                    r.location = rg.location;
                }
            }

            [text replaceCharactersInRange:r withString:@""];
            r.length = 0;
        }
    } else if (i < _datas.count) {
        NSString *faceStr = _datas[i][@"name"];

        if (r.length) {
            [text replaceCharactersInRange:r withString:faceStr];
        } else if([text length]){
            [text insertString:faceStr atIndex:r.location];
        } else {
            [text appendString:faceStr];
        }

        r.length = 0;
        r.location += [faceStr length];
    }

    _tv.text = text;
    _tv.selectedRange = r;
    [_tv scrollRangeToVisible:r];
    if ([_tv.delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [_tv.delegate textViewDidChange:_tv];
    }
}

#pragma mark - UICollectionUICollectionViewDelegateFlowLayoutView
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize) {w, w};
}

#pragma mark - UIScrollerViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pagerControl.currentPage = (scrollView.contentOffset.x + 30) / scrollView.frame.size.width;
}

@end