//
//  UIImageView+DKMImageView1.m
//  DKMWebImage
//
//  Created by 代克孟 on 2017/8/10.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import "UIImageView+DKMImageView1.h"
#import "DKMWebImage.h"

@implementation UIImageView (DKMImageView1)
-(void)setImageWithUrl:(NSURL*)url andDefaultImage:(UIImage*)image
{
    if ([[DKMWebImage shared].dataSource objectForKey:url]) {
        self.image = [[DKMWebImage shared].dataSource objectForKey:url];
    }else{
        self.image = image;
        dispatch_async(dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT), ^{
            NSURLSession* session      = [NSURLSession sharedSession];
            NSURLSessionDataTask* task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSLog(@"返回值：data ：%@ , response : %@ ,error : %@",data,response,error);
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage* image = [UIImage imageWithData:data];
                    if (image != nil) {
                        self.image = image;
                        [[DKMWebImage shared].dataSource setObject:image forKey:url];
                    }
                });
            }];
            [task resume];
        });
    }
}
@end
