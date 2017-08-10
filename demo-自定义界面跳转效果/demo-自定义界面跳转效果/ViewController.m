//
//  ViewController.m
//  demo-自定义界面跳转效果
//
//  Created by 代克孟 on 2017/4/17.
//  Copyright © 2017年 代克孟. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title  = @"ViewController";
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    label.text = @"ViewController";
    [self.view addSubview:label];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self presentViewController:[SecondViewController new] animated:YES completion:nil];
}







@end
