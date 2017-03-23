//
//  LaunchView.h
//  开眼
//
//  Created by liuyanming on 2017/3/23.
//  Copyright © 2017年 liuyanming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchView : UIView


@property (weak, nonatomic) IBOutlet UILabel *t1;
@property (weak, nonatomic) IBOutlet UILabel *t2;
@property (weak, nonatomic) IBOutlet UILabel *t3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutY;
@property (weak, nonatomic) IBOutlet UIImageView *maskView;

+ (instancetype)loadShowView;

@end
