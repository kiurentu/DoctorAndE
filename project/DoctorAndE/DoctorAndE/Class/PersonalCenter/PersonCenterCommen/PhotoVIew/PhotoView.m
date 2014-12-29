//
//  PhotoView.m
//  DoctorAndE
//
//  Created by UI08 on 14-11-26.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "PhotoView.h"

@interface PhotoView ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIViewController *_vec;
    NSMutableArray *_imageArr;
}

@end

@implementation PhotoView
+ (PhotoView*)instance
{
    return [[NSBundle mainBundle] loadNibNamed:@"PhotoView" owner:nil options:nil][0];
}

-(instancetype)initWithViewController:(UIViewController *)ViewController withImageArr:(NSMutableArray *)imageArr
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.55];
        _vec = ViewController;
        _imageArr = imageArr;
    }
    
    return self;
}


- (IBAction)takePhotoClick:(id)sender {
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"设备不可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    self.hidden = YES;
    [_vec presentViewController:imagePicker animated:YES completion:NULL];
}

- (IBAction)choosePhotoClick:(id)sender {

    
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    //选择类型相机，相册还是什么
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    //允许编辑
    imagePicker.allowsEditing = YES;
    self.hidden = YES;
    //显示相册
    [_vec presentViewController:imagePicker animated:YES completion:^{
    }];
    
    
}
// 选中照片

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [_imageArr addObject:image];
    
    if (_delegate && [_delegate respondsToSelector:@selector(choosePhotoImage:)]) {
        [_delegate choosePhotoImage:image];
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



// 取消相册
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self removeFromSuperview];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

@end
