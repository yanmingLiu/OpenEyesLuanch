//
//  HomeController.m
//  开眼
//
//  Created by liuyanming on 2017/3/27.
//  Copyright © 2017年 liuyanming. All rights reserved.
//

#import "HomeController.h"
#import "HeaderContentView.h"
#import "MJDIYHeader.h"
#import "MJRefresh.h"
#import "HomeCell.h"
#import "VideoDetailsViewController.h"

//屏幕高度
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
//屏幕宽度
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

#define GLJCalculateWithHeight(height) ((ScreenHeight) > 568 ? ScreenWidth*(height)/720.0 : (height)/2.0)

@interface HomeController () <UITableViewDelegate, UITableViewDataSource, VideoDetailsViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) HeaderContentView *headerView;
@property (weak, nonatomic) IBOutlet UIView *effectView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *effectTopLayout;

@property (nonatomic, assign) CGFloat rowH;

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize newSize = [self getDefaultSize];
    CGFloat rowH = newSize.height;
    _rowH = rowH;
    
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,rowH)];
    _headerView = [HeaderContentView loadView];
    [_tableView.tableHeaderView addSubview:_headerView];
    _headerView.frame = CGRectMake(0, 0, ScreenWidth, rowH);
    
    
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    
    _tableView.rowHeight = rowH;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeCell class]) bundle:nil] forCellReuseIdentifier:[HomeCell cellId]];
    

    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (CGSize) getDefaultSize
{
    CGSize imageSize = [UIImage imageNamed:@"addd"].size;
    CGSize newSize = CGSizeMake([UIScreen mainScreen].bounds.size.width ,[UIScreen mainScreen].bounds.size.width * (imageSize.height/imageSize.width));
    return newSize;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        if (_tableView.contentOffset.y <= 0) {
             _tableView.tableHeaderView.clipsToBounds = NO;
            
            CGFloat height = _rowH -  _tableView.contentOffset.y;
            CGFloat width = ScreenWidth*(height)/_rowH;
            CGFloat x = -(width - ScreenWidth)/2;
            _headerView.frame = CGRectMake(x, _tableView.contentOffset.y, width, height);
            
        }
        if (_tableView.contentOffset.y >= 0 && _tableView.contentOffset.y<= _rowH) {
            _tableView.tableHeaderView.clipsToBounds = YES;
            _headerView.frame = CGRectMake(0, _tableView.contentOffset.y, ScreenWidth, _rowH);
            
        }
        _headerView.maskView.alpha = _tableView.contentOffset.y  / _rowH;
    }
    
}


#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeCell cellId] forIndexPath:indexPath];
    if (!(indexPath.row%2)) {
        cell.contentView.backgroundColor = [UIColor redColor];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];

    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    {
        UIImageView *maseView = [[UIImageView alloc] initWithImage:cell.imageViewCell.image];
        maseView.frame = rect;
        NSLog(@"rect ----%@", NSStringFromCGRect(rect));
        maseView.layer.masksToBounds = true;
        maseView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:maseView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [maseView removeFromSuperview];
        });
    }
    
    
    UIViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoDetailsViewController"];
    [vc setValue:cell.imageViewCell.image forKey:@"resources"];
    [vc setValue:[NSValue valueWithCGRect:rect] forKey:@"startFrame"];

    [vc setValue:indexPath forKey:@"indexPath"];
    [vc setValue:tableView forKey:@"tableView"];
    [vc setValue:self forKey:@"delegate"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:vc animated:YES completion:nil];
    });
}

/*
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setIsHighlightRow:true AtIsAnimation:true];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setIsHighlightRow:false AtIsAnimation:true];
}
*/

#pragma mark VideoDetailsViewControllerDelegate
- (void)videoDetailsViewController:(UIViewController *)videoDetailsViewController updateIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *indexPaths = [_tableView indexPathsForVisibleRows];
    BOOL rolling = true;
    for (NSIndexPath *path in indexPaths) {
        if (path.section == indexPath.section && path.row == indexPath.row) {
            rolling = false;
        }
    }
    if (rolling) {
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
}

@end
