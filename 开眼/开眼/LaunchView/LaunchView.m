//
//  LaunchView.m
//  开眼
//
//  Created by liuyanming on 2017/3/23.
//  Copyright © 2017年 liuyanming. All rights reserved.
//

#import "LaunchView.h"

#define SYSTEM_VERSION_LESS_THAN(v)                                            \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] ==       \
NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)                                \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] !=       \
NSOrderedDescending)

@implementation LaunchView

+ (instancetype)loadShowView
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *fullPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"launchImage.png"]];
//    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    UIWindow *window = (id)[self getMainView];
    NSArray * ar = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil];
    id obj = [ar firstObject];
    
    ((UIView *)obj).frame = window.bounds;
    ((UIView *)obj).autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [window.rootViewController.view addSubview:obj];
//    if (savedImage) {
//        ((LaunchView *)obj).imageView.image = savedImage;
//    }
    [((LaunchView *)obj) startAnimations];
    return obj;
}

+ (UIView *)getMainView {
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        if (!window)
            window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        return [window subviews].lastObject;
    } else {
        UIWindow *window =[[UIApplication sharedApplication] keyWindow];
        if (window == nil)
            window = [[[UIApplication sharedApplication] delegate] window];//#14
        return window;
    }
}

- (void)startAnimations
{
   // UIImage *lauchImage = [HyHelper getLauchImage];
    //self.maskView.image = lauchImage;
    
    self.backgroundColor = [UIColor clearColor];
    _imageView.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:1.0 animations:^{
        _maskView.alpha = 0.0f;
    }];
    
    [UIView animateWithDuration:4 delay:0.4 options:0 animations:^{
        _imageView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    } completion:nil];
    [UIView animateWithDuration:1 delay:4 options:0 animations:^{
        _imageView.alpha = 0.0f;
        _t1.alpha = 0.0f;
        _t2.alpha = 0.0f;
        _t3.alpha = 0.0f;
        _iconImage.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
