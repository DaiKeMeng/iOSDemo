//
//  DKMWebImage.m
//  DKMWebImage
//
//  Created by 代克孟 on 2017/8/10.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import "DKMWebImage.h"

@implementation DKMWebImage
static DKMWebImage*webImage;
+(instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webImage = [[[self class] alloc] initPrivate];
    });
    return webImage;
}
-(instancetype)init
{
    return [DKMWebImage shared];
}
-(instancetype)initPrivate{
    self = [super init];
    if (self) {
        _dataSource = [NSMutableDictionary dictionary];
    }
    return self;
}


@end
