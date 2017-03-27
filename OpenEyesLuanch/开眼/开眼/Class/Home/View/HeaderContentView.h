//
//  HeaderContentView.h
//  开眼
//
//  Created by liuyanming on 2017/3/27.
//  Copyright © 2017年 liuyanming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderContentView : UIView

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, assign) double date;
+ (instancetype) loadView;

@end
