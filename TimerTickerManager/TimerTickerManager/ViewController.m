//
//  ViewController.m
//  TimerTickerManager
//
//  Created by game3108 on 16/4/15.
//  Copyright © 2016年 game3108. All rights reserved.
//

#import "ViewController.h"
#import "TimerTicker.h"

@interface ViewController ()<TimerTickerDelegate>{
    UILabel *_label;
    TimerTicker *_timerTicker;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 20)];
    _label.backgroundColor = [UIColor blackColor];
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_label];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 150, 100, 100)];
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(onButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)onButtonAction{
    _timerTicker = [[TimerTicker alloc]init];
    _timerTicker.tickerGap = 1.0f;
    _timerTicker.startTime = 20.0f;
    _timerTicker.endTime = 0;
    _timerTicker.delegate = self;
    [_timerTicker timeTickerDown];
    
}

- (void) onTimerStop{
    _label.text = @"stop";
}
- (void) onTimerTicker:(CGFloat) ticker{
    _label.text = [NSString stringWithFormat:@"%f",ticker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
