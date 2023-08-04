#import <UIKit/UIKit.h>
#import "SBFLockScreenDateView.h"

@implementation SBFLockScreenDateView
-(instancetype)initWithFrame:(CGRect)frame {
 self = [super initWithFrame:frame];
 if (self) {
  [[_UILegibilitySettings alloc]initWithStyle:YES];
  self->_alignmentPercent = 0;
  self->_maximumSubtitleWidth = INFINITY;
  _timeZone = 0;
  [[getSBUILegibilityLabelClass() alloc]initWithSettings:? strength:@"" string:? font:?];
  [_timeLabel setBackgroundColor:[UIColor clearColor]];
  [self addSubview:_timeLabel];
  [[SBFLockScreenDateSubtitleDateView alloc]initWithDate:nil];
  [self _dateSubtitleView];
  [self setAccessibilityIdentifier:@"lockscreen-date-view"];
  [self updateFormat];
 }
 return self;
}
-(void)_setDate:(NSDate *)date inTimeZone:(NSTimeZone*)timeZone {
    _timeZone = timeZone;
    _date = date;
    [self _updateLabels];
}
-(void)setDate:(NSDate *)date {
 [self _setDate:date inTimeZone:nil];
}
-(void)setTextColor:(UIColor *)textColor {
 if (_overrideTextColor != textColor) {
  _overrideTextColor = textColor;
  [self->_timeLabel setTextColor:_overrideTextColor];
  [self _updateLabelAlpha];
 }
}
-(void)updateFormat {
 [[BSDateFormatterCache sharedInstance] resetFormattersIfNecessary];
}
-(CGFloat)contentAlpha {
 return _timeAlpha;
}
-(void)_updateLabels {
 id thing = [BSDateFormatterCache formatterForDateAsTimeNoAMPMWithLocale:[NSLocale autoupdatingCurrentLocale]];
 [thing setTimeZone:rbx->_timeZone];
 NSString *stringFromDate = [thing stringFromDate:_date];
 id timeLabel = self->_timeLabel;
 NSString *string; = @"";
 if (_date) {
  string = stringFromDate;
 }
 [timeLabel setString:string];
 [self _updateUsesCompactDateFormat];
 [self->_dateSubtitleView _setDate:_date inTimeZone:self->_timeZone];
 [self->_timeLabel sizeToFit];
 [self->_dateSubtitleView sizeToFit];
 [self setNeedsLayout];
}
@end
