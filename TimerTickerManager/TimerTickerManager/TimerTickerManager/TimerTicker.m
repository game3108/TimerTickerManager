//
//  TimerTicker.m
//  TimerTickerManager
//
//  Created by game3108 on 16/4/15.
//  Copyright © 2016年 game3108. All rights reserved.
//

#import "TimerTicker.h"

@interface TimerTicker(){
    BOOL _downStop;
    BOOL _upStop;
    float _timerTicker;
}

@end

@implementation TimerTicker

- (instancetype)init{
    self = [super init];
    if ( self ){
        _tickerGap = 1;
        _startTime = 0;
        _endTime = 0;
    }
    return self;
}

- (dispatch_source_t)timeTickerDown
{
    if (  _endTime <= _startTime || _tickerGap <= 0 ){
        NSLog(@"error time format");
        return nil;
    }
    _downStop = NO;
    _timerTicker = (_endTime - _startTime) / _tickerGap;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), _tickerGap*NSEC_PER_SEC, _timerTicker);
    dispatch_source_set_event_handler(timer, ^{
        if(_timerTicker <= 0 || _downStop ) {
            dispatch_source_cancel(timer);
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (_delegate){
                    [_delegate onTimerStop];
                }
            });
        }else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (_delegate){
                    [_delegate onTimerTicker:_timerTicker];
                }
            });
            _timerTicker--;
            //cootek_log(@"!!!!!!!!!%d",_time_ticker);
        }
    });
    dispatch_resume(timer);
    return timer;
}

- (dispatch_source_t)timeTickerUp{
    _upStop = NO;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 0.1*NSEC_PER_SEC, _timerTicker);
    dispatch_source_set_event_handler(timer, ^{
        if (_upStop){
            dispatch_source_cancel(timer);
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (_delegate){
                    [_delegate onTimerStop];
                }
            });
        }else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (_delegate){
                    [_delegate onTimerTicker:_timerTicker];
                }
            });
            _timerTicker++;
            //cootek_log(@"!!!!!!!!!%d",_time_ticker);
        }
    });
    dispatch_resume(timer);
    return timer;
}

@end
