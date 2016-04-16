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
    TimerTicker *objcTimerTicker = [_timerTickerDic objectForKey:key];
    if ( objcTimerTicker ){
        objcTimerTicker.tickerGap = tickerGap;
        objcTimerTicker.startNumber = startNumber;
        objcTimerTicker.endNumber = endNumber;
        objcTimerTicker.needStop = needStop;
        objcTimerTicker.delegate = delegate;
        [objcTimerTicker startTimeTicker];
        NSLog(@"timeticker reuse ticker");
    }else{
        TimerTicker *timerTicker = [[TimerTicker alloc]init];
        timerTicker.tickerGap = tickerGap;
        timerTicker.startNumber = startNumber;
        timerTicker.endNumber = endNumber;
        timerTicker.needStop = needStop;
        timerTicker.delegate = delegate;
        [_timerTickerDic setObject:timerTicker forKey:key];
        [timerTicker startTimeTicker];
        NSLog(@"timeticker new ticker");
    }
}

- (void) setTimerTickerDelegate:(id<TimerTickerDelegate>) delegate
                        withKey:(NSString *)key{
    TimerTicker *objcTimerTicker = [_timerTickerDic objectForKey:key];
    if ( objcTimerTicker != nil )
        objcTimerTicker.delegate = delegate;
}

- (void) removeTimerTickerDelegate:(id<TimerTickerDelegate>) delegate
                           withKey:(NSString *)key{
    TimerTicker *objcTimerTicker = [_timerTickerDic objectForKey:key];
    if ( objcTimerTicker != nil )
        objcTimerTicker.delegate = nil;
}

- (void) removeTimerTickerWithKey:(NSString *)key{
    [_timerTickerDic removeObjectForKey:key];
}


- (void) setTimerTickerStop:(NSString *)key{
    TimerTicker *objcTimerTicker = [_timerTickerDic objectForKey:key];
    if ( objcTimerTicker != nil )
        [objcTimerTicker stopTimerTicker];
}

- (void) setTimerTickerPause:(NSString *)key{
    TimerTicker *objcTimerTicker = [_timerTickerDic objectForKey:key];
    if ( objcTimerTicker != nil )
        [objcTimerTicker pauseTimerTicker];
}

- (void) setTimerTickerResume:(NSString *)key{
    TimerTicker *objcTimerTicker = [_timerTickerDic objectForKey:key];
    if ( objcTimerTicker != nil )
        [objcTimerTicker resumeTimerTicker];
}
- (BOOL) judgeTimerTickerOnFire:(NSString *)key{
    
    return YES;
}
- (BOOL) judgeExistTimerTicker:(NSString *)key{
    return [[_timerTickerDic allKeys] containsObject:key];;
}
- (TimerTickerType)getTimerTickerType:(NSString *)key{
    TimerTicker *objcTimerTicker = [_timerTickerDic objectForKey:key];
    if ( objcTimerTicker != nil )
        return [objcTimerTicker getTimerTickerType];
    else
        return TypeNone;
}



@end
