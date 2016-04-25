//
//  BaseViewController.m
//  Coolading
//
//  Created by bejoy on 14/10/30.
//  Copyright (c) 2014年 zeng. All rights reserved.
//

#import "BaseViewController.h"
#import "Manager.h"
#import "IBJButton.h"

#import "IBJImageView.h"



@implementation BaseViewController



#pragma mark -  life cycle
#pragma mark -  UITableView
#pragma mark -  CustomDelegate
#pragma mark -  event response
#pragma mark -  private methods
#pragma mark -  getters and setters


#pragma mark - view cycle

- (void)loadView {
    [super loadView];
    
    self.manager = [Manager sharedManager];
//    self.view.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1];
//    
//    
//    self.statusBarView = [[IBJView alloc] initWithFrame:CGRectMake(0, 0, KDeviceWidth, 20)];
//    self.statusBarView.backgroundColor = KInsBlue;
//    self.statusBarView.hidden = YES;
//    [self.view addSubview: self.statusBarView];;
//
//    
//    self.navBarView = [[IBJView alloc] initWithFrame:CGRectMake(0, 20, KDeviceWidth, 44)];
//    self.navBarView.backgroundColor = KInsBlue;
//    
//    lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KDeviceWidth, 44)];
//    lable.textAlignment = NSTextAlignmentCenter;
//    lable.font = [UIFont systemFontOfSize:20];
//    [self.navBarView addSubview:lable];
//    
//    [self.view addSubview: self.navBarView];;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
//    [self.navigationController setNavigationBarHidden:YES];
//    
//    [self.view bringSubviewToFront:self.navBarView];
//    [self.view bringSubviewToFront:self.statusBarView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];

    
//    self.navigationController.navigationBar.translucent = YES;
//    // for ios7
//    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
//    }
//    // for under ios7
//    else {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"]
//             forBarMetrics:UIBarMetricsDefault];
//    }
}



#pragma mark -  private methods

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
    
}

- (void)hiddenNavbar {
    self.navBarView.alpha = 0;
    self.statusBarView.alpha = 0;
}

- (void)cleanNavAndStatus {
    
    self.statusBarView.backgroundColor = [UIColor clearColor];
    self.navBarView.backgroundColor = [UIColor clearColor];
}

- (void)backPop:(UIButton *)button {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)addPopBack {
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
    //      initWithImage:[UIImage imageNamed:@"返回按钮-"]
    //              style:UIBarButtonItemStylePlain
    //             target:self
    //             action:@selector(back:)];
    
    
    IBJButton *userButton = [IBJButton buttonWithType:UIButtonTypeCustom];
    [userButton setImage:[UIImage imageNamed:@"title_back"] forState:UIControlStateNormal];
    [userButton addTarget:self action:@selector(backPop:) forControlEvents:UIControlEventTouchUpInside];
    userButton.frame = CGRectMake(0, 0, 44, 44);
    
    
    [self.navBarView addSubview:userButton];
}


- (void)addNavBack {
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
    //      initWithImage:[UIImage imageNamed:@"返回按钮-"]
    //              style:UIBarButtonItemStylePlain
    //             target:self
    //             action:@selector(back:)];
    
    
    IBJButton *userButton = [IBJButton buttonWithType:UIButtonTypeCustom];
    [userButton setImage:[UIImage imageNamed:@"title_back"] forState:UIControlStateNormal];
    [userButton addTarget:self action:@selector(backNav:) forControlEvents:UIControlEventTouchUpInside];
    userButton.frame = CGRectMake(0, 0, 44, 44);
    
    
    [self.navBarView addSubview:userButton];
}

- (void)openShare {
    
}

- (void)backNav:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavBarTitle:(NSString *)title; {
    lable.text = title;
    lable.textColor = Kwhite;
}




@end

@implementation BaseViewController(GestureRecognizer)

    
@end

