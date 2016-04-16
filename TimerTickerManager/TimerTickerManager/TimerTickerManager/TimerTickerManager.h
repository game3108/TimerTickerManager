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
@end
