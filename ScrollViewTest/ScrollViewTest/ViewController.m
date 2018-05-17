//
//  ViewController.m
//  ScrollViewTest
//
//  Created by Daniel Nagy on 2018. 05. 17..
//  Copyright © 2018. Daniel Nagy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic) BOOL shouldShowStatusBar;

@end

@implementation ViewController {
    IBOutlet UIScrollView *_scrollView;
    
}

- (void)setShouldShowStatusBar:(BOOL)shouldShowStatusBar animated:(BOOL)animated {
    if (_shouldShowStatusBar == shouldShowStatusBar) {
        return;
    }
    _shouldShowStatusBar = shouldShowStatusBar;
    
    dispatch_block_t changes = ^{
        [self setNeedsStatusBarAppearanceUpdate];
    };
    if (animated) {
        [UIView animateWithDuration:0.3 animations:changes];
    } else {
        changes();
    }
}

- (void)setShouldShowStatusBar:(BOOL)shouldShowStatusBar {
    [self setShouldShowStatusBar:shouldShowStatusBar animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView.translatesAutoresizingMaskIntoConstraints = YES;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = UIColor.redColor;
    self.shouldShowStatusBar = YES;
    [_scrollView addSubview:view];
    _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    _scrollView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _scrollView.frame = self.view.bounds;
    _scrollView.contentSize = UIEdgeInsetsInsetRect(_scrollView.bounds, _scrollView.contentInset).size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setShouldShowStatusBar:scrollView.contentOffset.y < 0 animated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return !self.shouldShowStatusBar;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

@end
