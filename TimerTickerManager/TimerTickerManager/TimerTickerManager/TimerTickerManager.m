//
//  TimerTickerManager.m
//  TimerTickerManager
//
//  Created by game3108 on 16/4/16.
//  Copyright © 2016年 game3108. All rights reserved.
//

#import "TimerTickerManager.h"

static TimerTickerManager *instrance = nil;

@implementation TimerTickerManager

+ (void)initialize{
    instrance = [[TimerTickerManager alloc]init];
}

+ (instancetype) sharedInstrance{
    return instrance;
}



@end
