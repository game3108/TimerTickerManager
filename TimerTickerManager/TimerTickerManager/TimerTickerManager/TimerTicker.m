//
//  TimerTicker.m
//  TimerTickerManager
//
//  Created by game3108 on 16/4/15.
//  Copyright © 2016年 game3108. All rights reserved.
//

#import "TimerTicker.h"

@interface TimerTicker(){
    dispatch_source_t _timer;
    BOOL _onFire;
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


#pragma mark TimerTicker function
- (dispatch_source_t)startTimeTicker{
    if ( _timer ){
        if ( !_onFire )
            dispatch_resume(_timer);
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    CGFloat endNumber   = _endNumber;
    CGFloat startNumber = _startNumber;
    BOOL needStop       = _needStop;
    CGFloat tickerGap   = _tickerGap;
    BOOL timerTickerUp  = YES;
    if ( _tickerGap < 0 ){
        tickerGap = - _tickerGap;
        timerTickerUp = NO;
    }
    
    if ( (endNumber == startNumber) && needStop ){
        [_delegate onTimerStop];
        return nil;
    }
    if ( !_needStop ){
        endNumber = startNumber;
    }
    __block CGFloat timerTicker = (startNumber - endNumber) / tickerGap;
    if ( timerTicker > 0 ){
        timerTickerUp = NO;
    }
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), tickerGap*NSEC_PER_SEC, tickerGap*NSEC_PER_SEC*0.1);
    
    __weak TimerTicker *weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        BOOL judgeStop = [weakSelf judgeStop:timerTicker andTimeTickerUp:timerTickerUp andNeedStop:needStop];
        if(judgeStop) {
            [weakSelf onTimerStop];
        }else{
            [weakSelf onTimertTicker:timerTicker andTickerGap:tickerGap andEndNumber:endNumber];
            if ( timerTickerUp )
                timerTicker++;
            else
                timerTicker--;
            //NSLog(@"!!!!!!!!!%f",timerTicker);
        }
    });
    dispatch_resume(_timer);
    _onFire = YES;
    return _timer;
}

- (void)stopTimerTicker{
    if ( _timer ){
        if ( !_onFire )
            dispatch_resume(_timer);
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

- (void)pauseTimerTicker{
    if ( _timer && _onFire ){
        dispatch_suspend(_timer);
        _onFire = NO;
    }
}

- (void)resumeTimerTicker{
    if ( _timer && !_onFire ){
        dispatch_resume(_timer);
        _onFire = YES;
    }
}

- (TimerTickerType)getTimerTickerType{
    if ( !_timer )
        return TypeStop;
    else if ( _onFire )
        return TypeOnFire;
    else
        return TypePause;
}

#pragma mark startTimeTicker related function

- (BOOL) judgeStop:(CGFloat)timerTicker andTimeTickerUp:(BOOL)ifUp andNeedStop:(BOOL)needStop{
    BOOL state1 = needStop && ifUp && timerTicker >=0;
    BOOL state2 = needStop && !ifUp && timerTicker <= 0;
    return state1 || state2;
}

- (void)onTimerStop{
    dispatch_source_cancel(_timer);
    dispatch_sync(dispatch_get_main_queue(), ^{
        [_delegate onTimerStop];
    });
}

- (void)onTimertTicker:(CGFloat)timerTicker andTickerGap:(CGFloat)tickerGap andEndNumber:(CGFloat)endNumber{
    dispatch_sync(dispatch_get_main_queue(), ^{
        [_delegate onTimerTicker:timerTicker*tickerGap+endNumber];
    });
}

#pragma mark dealloc

-(void)dealloc{
    [self stopTimerTicker];
    NSLog(@"timer ticker dealloc");
}

@end
