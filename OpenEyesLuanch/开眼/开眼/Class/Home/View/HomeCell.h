//
//  HomeCell.h
//  开眼
//
//  Created by liuyanming on 2017/3/28.
//  Copyright © 2017年 liuyanming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewCell;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UILabel *textLabels;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;


@property (nonatomic, assign) BOOL isHighlightRow;

@property (assign, nonatomic, readonly) BOOL isAnimations;

+ (instancetype)loadView;

+ (NSString *)cellId;


- (void)setIsHighlightRow:(BOOL)isHighlightRow AtIsAnimation:(BOOL)animations;

@end
