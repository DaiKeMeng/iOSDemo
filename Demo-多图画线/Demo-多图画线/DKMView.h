//
//  DKMView.h
//  Demo-多图画线
//
//  Created by 代克孟 on 2017/8/9.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKMLineView.h"
@interface DKMView : UIView

@property (nonatomic ,strong) NSMutableArray* finishedLines;
@property (nonatomic ,strong) DKMLineView* currentLine;
@property (nonatomic ,strong) NSMutableDictionary* linesInProgress;
@end
