//
//  ImagePageView.m
//  ImagePageView
//
//  Created by skytoup on 14-12-26.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "ImagePageView.h"
#import "ImagePageViewCell.h"
#import "UIImageView+WebCache.h"

@interface ImagePageView () <UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@end

@implementation ImagePageView

+ (ImagePageView*)instacenView
{
    ImagePageView *view = [[NSBundle mainBundle] loadNibNamed:@"ImagePageView" owner:nil options:nil][0];
    if (view) {
        [view.collectionView registerNib:[UINib nibWithNibName:@"ImagePageViewCell" bundle:nil] forCellWithReuseIdentifier:@"ImagePageViewCell"];
        view.collectionView.delegate = view;
        view.collectionView.dataSource = view;
    }
    return view;
}

- (instancetype)initWithImaUrlArray:(NSArray*)imgUrls
{
    self = [self init];
    if(self) {
        _imgUrls = imgUrls;
    }
    return self;
}

- (void)setImgUrls:(NSArray *)imgUrls
{
    _imgUrls = imgUrls;
    _curP = 0;
    _leftBtn.hidden = YES;
    _rightBtn.hidden = imgUrls.count<2;
    [_collectionView reloadData];
}

- (IBAction)leftBtnClick:(id)sender {
    _curP--;
    [self updataView];
}

- (IBAction)rightBtnClick:(id)sender {
    _curP++;
    [self updataView];
}

/**
 *  刷新View
 */
- (void)updataView {
    _collectionView.contentOffset = CGPointMake(self.frame.size.width*_curP, 0);
    _leftBtn.hidden = !_collectionView.contentOffset.x;
    _rightBtn.hidden = _curP == (_imgUrls.count-1);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _curP = scrollView.contentOffset.x / self.frame.size.width;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imgUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImagePageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImagePageViewCell" forIndexPath:indexPath];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:_imgUrls[indexPath.row]] placeholderImage:[UIImage imageNamed:@"mall_service_info_top_image_button.png"] ];
    return cell;
}

@end
