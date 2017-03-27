//
//  HeaderContentView.m
//  开眼
//
//  Created by liuyanming on 2017/3/27.
//  Copyright © 2017年 liuyanming. All rights reserved.
//

#import "HeaderContentView.h"

@implementation HeaderContentView


+ (instancetype) loadView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
}

//- (void)setDate:(double)date
//{
//    _date = date;
//    NSString *time = [HyHelper timesTampConversion:_date AtDateFormat:@"yyyy-MM-dd"];
//    NSString *weakEnglish = [HyHelper featureWeekdayWithDate:time];
//    NSString *days = [time substringFromIndex:8];
//    NSString *info = [NSString stringWithFormat:@"- %@, Nov. %@ -",weakEnglish,days];
//    _titleLabel.text = info;
//}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

@end
