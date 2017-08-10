//
//  ViewController.m
//  Demo-相机
//
//  Created by 代克孟 on 2017/8/9.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CMTime time;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (nonatomic ,copy) NSURL* url;

@property (nonatomic ,strong) AVPlayer* player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)takeCarmerAction {
    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController* pickerC = [[UIImagePickerController alloc] init];
        pickerC.sourceType = type;
        pickerC.allowsEditing = YES;
        pickerC.delegate = self;
        [self presentViewController:pickerC animated:YES completion:nil];
    }
}
- (IBAction)takeMovieAction {
    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController* pickerC = [[UIImagePickerController alloc] init];
        pickerC.sourceType = type;
        pickerC.mediaTypes = @[(__bridge NSString*)kUTTypeMovie];
        pickerC.allowsEditing = YES;
        pickerC.delegate = self;
        [self presentViewController:pickerC animated:YES completion:nil];
    }
}

/**
 1 视频的播放需要两个控件
 AVPlayer       播放器
 AVPlayerLayer  播放器的大小位置，承载播放器的显示位置
 **/
- (IBAction)playMovieAction {
    if (self.url.absoluteString.length == 0) {
        return;
    }
    if (self.player != nil) {
        [self.player seekToTime:time];
        [self.player play];
        return;
    }
    AVPlayerItem* item = [AVPlayerItem playerItemWithURL:self.url];
    AVPlayer* player           = [AVPlayer playerWithPlayerItem:item];
    AVPlayerLayer* playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = CGRectMake(100, 500, 200, 200);
    [self.view.layer addSublayer:playerLayer];
    [player play];
    self.player = player;
    
}
- (IBAction)parseMovieAction:(id)sender {
    [self.player pause];
    time = [self.player currentTime];
}
- (IBAction)replayMoviewAction {
    [self.player.currentItem reversePlaybackEndTime];
}

#pragma mark UIImagePickerControllerDelegate
// 完成的图片的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"didFinishPickingMediaWithInfo");
    NSLog(@"视频地址:%@",info[UIImagePickerControllerMediaURL]);
    NSURL* url = info[UIImagePickerControllerMediaURL];
    self.url = url;
    UISaveVideoAtPathToSavedPhotosAlbum(url.path, nil, nil, nil);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

// 拍照取消
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"imagePickerControllerDidCancel");
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
