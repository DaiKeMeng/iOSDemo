//
//  ViewController.m
//  多组图片上传
//
//  Created by 代克孟 on 2017/5/3.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <CTAssetsPickerController.h>

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CTAssetsPickerControllerDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"CTAssetsPickerController.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *img_path = [bundle pathForResource:@"Checkmark" ofType:@"png"];
    UIImage* image = [UIImage imageWithContentsOfFile:img_path];
    
    UIImageView* imageV = [[UIImageView alloc] init];
    imageV.image        = image;
    imageV.frame        = CGRectMake(30, 300, 60, 60);
    [self.view addSubview:imageV];
    
}


- (IBAction)openCarmerAction {
    CTAssetsPickerController* picker = [[CTAssetsPickerController alloc] init];
    picker.delegate                  = self;
    // 设置图片的选取路径。
    picker.assetCollectionSubtypes   = @[@(PHAssetCollectionSubtypeSmartAlbumUserLibrary),@(PHAssetCollectionSubtypeAlbumRegular)];
    // 不显示空的相片夹
    picker.showsEmptyAlbums = NO;
    [self presentViewController:picker animated:YES completion:nil];
}


#pragma mark - CTAssetsPickerControllerDelegate
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    NSMutableArray<UIImage*> * imagesArray = [NSMutableArray array];
    for (int i = 0; i < picker.selectedAssets.count; ++i) {
        PHAsset* item = picker.selectedAssets[i];
        PHImageRequestOptions* options = [[PHImageRequestOptions alloc] init];
        // 图片质量
        options.deliveryMode           = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        // 图片显示的宽高
        options.resizeMode             = PHImageRequestOptionsResizeModeExact;
        // 从一个PHAsset类获取其中的包含的图片
        [[PHImageManager defaultManager] requestImageForAsset:item
                                                   targetSize:CGSizeMake(item.pixelWidth / 2, item.pixelHeight / 2)
                                                  contentMode:PHImageContentModeDefault
                                                      options:options
                                                resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            UIImageView* imageV = [[UIImageView alloc] init];
            imageV.image        = result;
            imageV.frame        = CGRectMake(30 + i * 80, 300, 60, 60);
            [self.view addSubview:imageV];
                                                    [imagesArray addObject:result];
        }];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 是否要选取图片
-(BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset
{
    // 在这里设置选取图片的张数
    if (picker.selectedAssets.count > 4) {
        return NO;
    }
    return YES;
}


//#pragma mark UIImagePickerControllerDelegate
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
//{
//    NSLog(@"didFinishPickingMediaWithInfo");
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
//
//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}



@end
