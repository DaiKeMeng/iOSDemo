//
//  DKMWebImage.h
//  DKMWebImage
//
//  Created by 代克孟 on 2017/8/10.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DKMWebImage : NSObject
@property (nonatomic ,strong) NSMutableDictionary* dataSource;
+(instancetype)shared;

@end
