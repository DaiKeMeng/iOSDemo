//
//  ViewController.m
//  Demo-多图画线
//
//  Created by 代克孟 on 2017/8/9.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import "ViewController.h"
#import "DKMView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DKMView* v = [[DKMView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:v];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
