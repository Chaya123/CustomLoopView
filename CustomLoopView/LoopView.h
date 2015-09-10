//
//  LoopView.h
//  CustomLoopView
//
//  Created by LCJMac on 15-9-10.
//  Copyright (c) 2015年 LCJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoopView : UIView

/**
 *  一个存放图片的数组
 */
@property (nonatomic,strong) NSArray * imageArray;

+ (instancetype) customLoopViewWithframe:(CGRect)frame AndView:(UIView *)SuperView AndImageArray:(NSArray *)imageArray;

- (instancetype)initWithFrame:(CGRect)frame AndImageArray:(NSArray *)imageArray;




@end
