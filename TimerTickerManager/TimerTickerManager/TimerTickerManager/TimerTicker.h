//
//  TimerTicker.h
//  TimerTickerManager
//
//  Created by game3108 on 16/4/15.
//  Copyright © 2016年 game3108. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TimerTickerDelegate <NSObject>
- (void) onTimerStop;
- (void) onTimerTicker:(NSInteger) ticker;
@end

@interface TimerTicker : NSObject
@property (nonatomic, assign) CGFloat endTime;
@property (nonatomic, assign) CGFloat startTime;
@property (nonatomic, assign) CGFloat tickerGap;
@property (nonatomic, weak) id<TimerTickerDelegate> delegate;
- (dispatch_source_t)timeTickerDown;
- (dispatch_source_t)timeTickerUp;
@end
