#import <UIKit/UIKit.h>
#import "SBFLockScreenDateViewController.h"

@implementation SBFLockScreenDateViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
  [self _addObservers];
  [self setDateProvider:nil];
 }
 return self;
}
-(id)dateView {
 [self view];
}
-(id)dateViewIfExists {
 if ([self isViewLoaded]) {
  return [self view];
 }
 return nil;
}
-(void)setScreenOff:(BOOL)screenOff {
 if (_screenOff != screenOff) {
  _screenOff = screenOff;
  [self _updateState];
 }
}
-(BOOL)isSubtitleHidden] {
 return [[self dateViewIfExists]isSubtitleHidden];
}
-(void)setSubtitleHidden:(BOOL)subtitleHidden {
 [[self dateView] setSubtitleHidden:subtitleHidden];
}
-(void)loadView {
 SBFLockScreenDateView* dateView = [[SBFLockScreenDateView alloc] initWithFrame:CGRectMake(0,0,0,0)];
 [dateView setUserInteractionEnabled:NO];
 [dateView setLegibilitySettings:self->_legibilitySettings];
 [self setView:r15];
 [self _updateLegibilityStrength];
 [dateView setDate:[self->_dateProvider date]];
}
-(void)setView:(UIView*)view {
 [super setView:view];
 if (!view) {
  [self _stopUpdateTimer];
 }
}
-(void)willMoveToParentViewController:(id)something {
 if (!something) {
  [self setView:nil];
 }
}
-(void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 self->_isVisible = YES;
 [self _updateState];
}
-(void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 self->_isVisible = NO;
 [self _updateState];
}
-(BOOL)_canShowWhileLocked {
 return YES;
}
-(void)settings:(id)settings changedValueForKey:(id)arg1 {
 if ([SBFLegibilityDomain rootSettings] == settings) {
  [self _updateLegibilityStrength];
 }
}
-(void)_updateFormatIfEnabled {
 if (!_disablesUpdates) {
  [self _updateFormat];
 }
}
-(void)_updateFormat {
 id view = [self dateViewIfExists];
 [view updateFormat];
 [view _updateView];
 return view;
}
@end
