//
//  ViewController.m
//  TimerTickerManager
//
//  Created by game3108 on 16/4/15.
//  Copyright © 2016年 game3108. All rights reserved.
//

#import "ViewController.h"
#import "TimerTickerManager.h"

@interface ViewController ()<TimerTickerDelegate>{
    UILabel *_label;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 200, 20)];
    _label.backgroundColor = [UIColor blackColor];
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_label];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, 150, 50, 50)];
    button.backgroundColor = [UIColor blackColor];
    [button setTitle:@"start" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(150, 150, 50, 50)];
    button2.backgroundColor = [UIColor blackColor];
    [button2 setTitle:@"stop" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(onButtonAction2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(50, 250, 50, 50)];
    button3.backgroundColor = [UIColor blackColor];
    [button3 setTitle:@"pause" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(onButtonAction3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc]initWithFrame:CGRectMake(150, 250, 50, 50)];
    button4.backgroundColor = [UIColor blackColor];
    [button4 setTitle:@"resume" forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(onButtonAction4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)onButtonAction{
    [[TimerTickerManager sharedInstrance]startTimerTicker:self
                                                  withKey:@"key1"
                                          withStartNumber:30
                                            withEndNumber:20
                                            withTickerGap:0.5];
}

- (void)onButtonAction2{
    [[TimerTickerManager sharedInstrance]setTimerTickerStop:@"key1"];
}

- (void)onButtonAction3{
    [[TimerTickerManager sharedInstrance]setTimerTickerPause:@"key1"];
}

- (void)onButtonAction4{
    [[TimerTickerManager sharedInstrance]setTimerTickerResume:@"key1"];
}

#pragma mark TimerTickerDelegate

- (void) onTimerStop{
    _label.text = @"stop";
    NSLog(@"timer stop");
}
- (void) onTimerTicker:(CGFloat) ticker{
    _label.text = [NSString stringWithFormat:@"%f",ticker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
