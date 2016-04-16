//
//  TimerTickerManager.h
//  TimerTickerManager
//
//  Created by game3108 on 16/4/16.
//  Copyright © 2016年 game3108. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerTicker.h"

@interface TimerTickerManager : NSObject
+ (instancetype) sharedInstrance;
- (void)startTimerTicker:(id<TimerTickerDelegate>)delegate
                 withKey:(NSString *)key
         withStartNumber:(CGFloat)startNumber
           withEndNumber:(CGFloat)endNumber
           withTickerGap:(CGFloat)tickerGap;
- (void)startTimerTicker:(id<TimerTickerDelegate>)delegate
                 withKey:(NSString *)key
         withStartNumber:(CGFloat)startNumber
           withTickerGap:(CGFloat)tickerGap;
- (void)startTimerTicker:(id<TimerTickerDelegate>)delegate
                 withKey:(NSString *)key
           withTickerGap:(CGFloat)tickerGap;

- (void) setTimerTickerDelegate:(id<TimerTickerDelegate>) delegate
                        withKey:(NSString *)key;
- (void) removeTimerTickerDelegate:(id<TimerTickerDelegate>) delegate
                           withKey:(NSString *)key;
- (void) removeTimerTickerWithKey:(NSString *)key;
- (void) setTimerTickerStop:(NSString *)key;
- (void) setTimerTickerPause:(NSString *)key;
- (void) setTimerTickerResume:(NSString *)key;
@end
