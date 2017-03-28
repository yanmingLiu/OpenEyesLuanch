//
//  VideoDetailsViewController.h
//  开眼
//
//  Created by liuyanming on 2017/3/28.
//  Copyright © 2017年 liuyanming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoDetailsViewController;

@protocol VideoDetailsViewControllerDelegate <NSObject>
@optional
- (void)videoDetailsViewController:(VideoDetailsViewController *)videoDetailsViewController updateIndexPath:(NSIndexPath *)indexPath;

@end

@interface VideoDetailsViewController : UIViewController

@property (nonatomic, assign) CGRect startFrame;
@property (nonatomic, strong) id     resources;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak)   UITableView *tableView;
@property (nonatomic, weak)   id<VideoDetailsViewControllerDelegate> delegate;

@property (nonatomic, assign) CGFloat rowH;

@end
