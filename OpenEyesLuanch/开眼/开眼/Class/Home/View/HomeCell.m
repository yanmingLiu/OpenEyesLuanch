//
//  HomeCell.m
//  开眼
//
//  Created by liuyanming on 2017/3/28.
//  Copyright © 2017年 liuyanming. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

+ (instancetype)loadView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
}

+ (NSString *)cellId {
    return NSStringFromClass(self);
}

- (void)setIsHighlightRow:(BOOL)isHighlightRow AtIsAnimation:(BOOL)animations
{
    _isHighlightRow = isHighlightRow;
    if (isHighlightRow) {
        if (animations) {
            _isAnimations = true;
            [UIView animateWithDuration:0.2 animations:^{
                _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
                _titleLabel.alpha = 0.0f;
                _subTitle.alpha = 0.0f;
            } completion:^(BOOL finished) {
                _isAnimations = !finished;
            }];
        } else {
            _isAnimations = animations;
            _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        }
    } else {
        _isAnimations = true;
        if (animations) {
            [UIView animateWithDuration:0.2 animations:^{
                _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];
                _titleLabel.alpha = 1.0f;
                _subTitle.alpha = 1.0f;
            } completion:^(BOOL finished) {
                _isAnimations = !finished;
            }];
        } else {
            _isAnimations = animations;
            _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
