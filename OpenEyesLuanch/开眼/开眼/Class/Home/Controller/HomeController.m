//
//  HomeController.m
//  开眼
//
//  Created by liuyanming on 2017/3/27.
//  Copyright © 2017年 liuyanming. All rights reserved.
//

#import "HomeController.h"
#import "HeaderContentView.h"
//屏幕高度
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
//屏幕宽度
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

#define GLJCalculateWithHeight(height) ((ScreenHeight) > 568 ? ScreenWidth*(height)/720.0 : (height)/2.0)

@interface HomeController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) HeaderContentView *headerView;
@property (weak, nonatomic) IBOutlet UIView *effectView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *effectTopLayout;

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,GLJCalculateWithHeight(440))];
    _headerView = [HeaderContentView loadView];
    [_tableView.tableHeaderView addSubview:_headerView];
    _headerView.frame = CGRectMake(0, 0, ScreenWidth, GLJCalculateWithHeight(440));
    
    
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        if (_tableView.contentOffset.y <= 0) {
             _tableView.tableHeaderView.clipsToBounds = NO;
            
            CGFloat height = GLJCalculateWithHeight(440) -  _tableView.contentOffset.y;
            CGFloat width = ScreenWidth*(height)/GLJCalculateWithHeight(440);
            CGFloat x = -(width - ScreenWidth)/2;
            _headerView.frame = CGRectMake(x, _tableView.contentOffset.y, width, height);
            
        }
        if (_tableView.contentOffset.y >= 0&& _tableView.contentOffset.y<=GLJCalculateWithHeight(440)) {
            _tableView.tableHeaderView.clipsToBounds = YES;
            _headerView.frame = CGRectMake(0, _tableView.contentOffset.y, ScreenWidth, GLJCalculateWithHeight(440));
        }
        
    }
    
}




#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    if (!(indexPath.row%2)) {
        cell.contentView.backgroundColor = [UIColor redColor];
    }
    return cell;
}


@end
