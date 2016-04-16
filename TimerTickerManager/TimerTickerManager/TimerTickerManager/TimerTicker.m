//
//  TimerTicker.m
//  TimerTickerManager
//
//  Created by game3108 on 16/4/15.
//  Copyright © 2016年 game3108. All rights reserved.
//

#import "TimerTicker.h"

@interface TimerTicker(){
    BOOL _forceStop;
    CGFloat _startNumber;
    CGFloat _endNumber;
}

@end

@implementation TimerTicker

- (instancetype)init{
    self = [super init];
    if ( self ){
        _tickerGap = 1;
        _startNumber = 0;
        _endNumber = 0;
        _needStop = NO;
    }
    return self;
}

#pragma mark reset endNumber setter
- (void)setEndNumber:(CGFloat)endNumber{
    _endNumber = endNumber;
    _needStop = YES;
}


#pragma mark TimerTicker function
- (dispatch_source_t)startTimeTicker{
    CGFloat endNumber   = _endNumber;
    CGFloat startNumber = _startNumber;
    CGFloat tickerGap   = _tickerGap;
    BOOL needStop       = _needStop;
    if (  tickerGap <= 0 ){
        [_delegate onTimerStop];
        return nil;
    }
    if ( (endNumber == startNumber) && needStop ){
        [_delegate onTimerStop];
        return nil;
    }
    if ( !_needStop ){
        endNumber = startNumber;
    }
    _forceStop = NO;
    __block CGFloat timerTicker = (startNumber - endNumber) / tickerGap;
    BOOL timeTickerUp = YES;
    if ( timerTicker > 0 ){
        timeTickerUp = NO;
    }
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), _tickerGap*NSEC_PER_SEC, _tickerGap*NSEC_PER_SEC*0.1);
    
    dispatch_source_set_event_handler(timer, ^{
        BOOL judgeStop = [self judgeStop:timerTicker andTimeTickerUp:timeTickerUp andNeedStop:needStop andForceStop:_forceStop];
        if(judgeStop) {
            dispatch_source_cancel(timer);
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self onTimerStop];
            });
        }else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self onTimertTicker:timerTicker andTickerGap:tickerGap andEndNumber:endNumber];
            });
            if ( timeTickerUp )
                timerTicker++;
            else
                timerTicker--;
            NSLog(@"!!!!!!!!!%f",timerTicker);
        }
    });
    dispatch_resume(timer);
    return timer;
}

- (void)forceTimeTickerStop{
    _forceStop = YES;
}

#pragma mark startTimeTicker related function

- (BOOL) judgeStop:(CGFloat)timerTicker andTimeTickerUp:(BOOL)ifUp andNeedStop:(BOOL)needStop andForceStop:(BOOL)forceStop{
    BOOL state1 = forceStop;
    BOOL state2 = needStop && ifUp && timerTicker >=0;
    BOOL state3 = needStop && !ifUp && timerTicker <= 0;
    return state1 || state2 || state3;
}

- (void)onTimerStop{
    [_delegate onTimerStop];
}

- (void)onTimertTicker:(CGFloat)timerTicker andTickerGap:(CGFloat)tickerGap andEndNumber:(CGFloat)endNumber{
    [_delegate onTimerTicker:timerTicker*tickerGap+endNumber];
}

#pragma mark dealloc

-(void)dealloc{
    NSLog(@"timer ticker dealloc");
}

@end
