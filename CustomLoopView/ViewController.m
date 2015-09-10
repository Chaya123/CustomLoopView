//
//  ViewController.m
//  CustomLoopView
//
//  Created by LCJMac on 15-9-10.
//  Copyright (c) 2015年 LCJ. All rights reserved.//

#import "ViewController.h"
#import "LoopView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *array  = @[@"img_01",@"img_02",@"img_03",@"img_04",@"img_05"];
    
    
    [LoopView customLoopViewWithframe:CGRectMake(0, 0, self.view.frame.size.width, 300) AndView:self.view AndImageArray:array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
