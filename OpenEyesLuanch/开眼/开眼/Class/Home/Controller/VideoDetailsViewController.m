//
//  VideoDetailsViewController.m
//  开眼
//
//  Created by liuyanming on 2017/3/28.
//  Copyright © 2017年 liuyanming. All rights reserved.
//

#import "VideoDetailsViewController.h"
#import "HyInteractiveTransition.h"


@interface VideoDetailsViewController () <UIScrollViewDelegate,UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *imgv;

@property (nonatomic, strong) HyInteractiveTransition *transitionManage;

@property (nonatomic, strong) dispatch_queue_t mainQueue;

@property (nonatomic, assign) CGRect endRect;

@end

@implementation VideoDetailsViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    if (self) {
        self = [super initWithCoder:aDecoder];
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        _transitionManage = [[HyInteractiveTransition alloc] init];
        _transitionManage.transitionStyleType = HyTransitionStyleTypeVideoDetails;
        
        _endRect = CGRectZero;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)setResources:(id)resources
{
    _resources = resources;
    _transitionManage.resources = _resources;
}

- (void)setStartFrame:(CGRect)startFrame
{
    _startFrame = startFrame;
    _transitionManage.startFrame = _startFrame;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    //这里我们初始化presentType
    _transitionManage.type = HyPresentOneTransitionTypePresent;
    return _transitionManage;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //这里我们初始化dismissType
    _transitionManage.type = HyPresentOneTransitionTypeDismiss;
    return _transitionManage;
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    
    
    if ([_delegate respondsToSelector:@selector(videoDetailsViewController:updateIndexPath:)]) {
        [_delegate videoDetailsViewController:self updateIndexPath:[NSIndexPath indexPathForRow:_indexPath.row inSection:_indexPath.section]];
    }
    CGRect rectInTableView = [_tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:_indexPath.row  inSection:_indexPath.section]];
    /*
    CGRect rect = [_tableView convertRect:rectInTableView toView:[_tableView superview]];
    MoreInfoView *show = [_scrollView viewWithTag:viewTag + index];
    _transitionManage.startFrame = rect;
    _transitionManage.resources = show.imageView.image;
     */
    [super dismissViewControllerAnimated:flag completion:completion];
}


@end
