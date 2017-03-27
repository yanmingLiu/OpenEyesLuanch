//
//  TBController.m
//  开眼
//
//  Created by liuyanming on 2017/3/23.
//  Copyright © 2017年 liuyanming. All rights reserved.
//

#import "TBController.h"
#import "LaunchView.h"

@interface TBController ()

@end

@implementation TBController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [LaunchView loadShowView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
