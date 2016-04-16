//
//  TimerTickerManager.m
//  TimerTickerManager
//
//  Created by game3108 on 16/4/16.
//  Copyright © 2016年 game3108. All rights reserved.
//

#import "TimerTickerManager.h"

@interface TimerTickerManager(){
    NSMutableDictionary *_timerTickerDic;
}

@end

static TimerTickerManager *instrance = nil;

@implementation TimerTickerManager

+ (void)initialize{
    instrance = [[TimerTickerManager alloc]init];
    instrance->_timerTickerDic = [[NSMutableDictionary alloc]init];
}

+ (instancetype) sharedInstrance{
    return instrance;
}


- (void)startTimerTicker:(id<TimerTickerDelegate>)delegate
                 withKey:(NSString *)key
         withStartNumber:(CGFloat)startNumber
           withEndNumber:(CGFloat)endNumber
           withTickerGap:(CGFloat)tickerGap{
    [self startTimerTicker:delegate
                   withKey:key
           withStartNumber:startNumber
             withEndNumber:endNumber
             withTickerGap:tickerGap
              withNeedStop:YES];
}
- (void)startTimerTicker:(id<TimerTickerDelegate>)delegate
                 withKey:(NSString *)key
         withStartNumber:(CGFloat)startNumber
           withTickerGap:(CGFloat)tickerGap{
    [self startTimerTicker:delegate
                   withKey:key
           withStartNumber:startNumber
             withEndNumber:startNumber
             withTickerGap:tickerGap
              withNeedStop:NO];

}
- (void)startTimerTicker:(id<TimerTickerDelegate>)delegate
                 withKey:(NSString *)key
           withTickerGap:(CGFloat)tickerGap{
    [self startTimerTicker:delegate
                   withKey:key
           withStartNumber:0
             withEndNumber:0
             withTickerGap:tickerGap
              withNeedStop:NO];
}

- (void)startTimerTicker:(id<TimerTickerDelegate>)delegate
                 withKey:(NSString *)key
         withStartNumber:(CGFloat)startNumber
           withEndNumber:(CGFloat)endNumber
           withTickerGap:(CGFloat)tickerGap
            withNeedStop:(BOOL)needStop{
    
    
    
}


@end
