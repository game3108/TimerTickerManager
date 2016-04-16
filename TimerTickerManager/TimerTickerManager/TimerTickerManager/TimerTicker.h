//
//  TimerTicker.h
//  TimerTickerManager
//
//  Created by game3108 on 16/4/15.
//  Copyright © 2016年 game3108. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , TimerTickerType){
    TypeStop = 0,
    TypeOnFire = 1,
    TypePause =2,
    TypeNone = 3
};

@protocol TimerTickerDelegate <NSObject>
- (void) onTimerStop;
- (void) onTimerTicker:(CGFloat) ticker;
@end

@interface TimerTicker : NSObject
@property (nonatomic, assign) CGFloat endNumber;
@property (nonatomic, assign) CGFloat startNumber;
@property (nonatomic, assign) CGFloat tickerGap;
@property (nonatomic, assign) BOOL needStop;
@property (nonatomic, weak) id<TimerTickerDelegate> delegate;
- (dispatch_source_t)startTimeTicker;
- (void)stopTimerTicker;
- (void)pauseTimerTicker;
- (void)resumeTimerTicker;
- (TimerTickerType)getTimerTickerType;
@end
