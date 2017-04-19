//
//  SecondViewController.m
//  demo-自定义界面跳转效果
//
//  Created by 代克孟 on 2017/4/17.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewController.h"


@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor   = [UIColor orangeColor];
    self.title  = @"SecondViewController";
    UILabel* label              = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    label.text                  = @"SecondViewController";
    [self.view addSubview:label];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
