#import <UIKit/UIKit.h>

@interface SCSnapController : UIViewController
- (void)saveSnap;
@end

@interface SCChatViewController : UIViewController
@end

@interface SCScreenshotDetector : NSObject
+ (instancetype)sharedInstance;
- (void)stopMonitoring;
@end

@interface SCReplayManager : NSObject
+ (instancetype)sharedInstance;
- (void)setUnlimitedReplays:(BOOL)unlimited;
@end

@interface SCPlusHandler : NSObject
- (BOOL)isPlusSubscriber;
- (void)showPlusFeatures;
@end

// ========== Purple UI ==========
%hook SCChatViewController
- (void)viewDidLoad {
    %orig;
    UIColor *purple = [UIColor colorWithRed:0.75 green:0.35 blue:0.85 alpha:1.0];
    self.view.backgroundColor = purple;
    self.navigationController.navigationBar.barTintColor = purple;
    self.tabBarController.tabBar.barTintColor = purple;
}
%end

// ========== Auto Save Snaps ==========
%hook SCSnapController
- (void)viewDidLoad {
    %orig;
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    saveBtn.frame = CGRectMake(self.view.frame.size.width - 60, 50, 40, 40);
    [saveBtn setTitle:@"💾" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveSnap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
}
%end

// ========== Unlimited Replays ==========
%hook SCReplayManager
- (void)setup {
    %orig;
    [self setUnlimitedReplays:YES];
}
%end

// ========== No Screenshot Alert ==========
%hook SCScreenshotDetector
- (void)startMonitoring {
    %orig;
    [[SCScreenshotDetector sharedInstance] stopMonitoring];
}
%end

// ========== Fake Snapchat Plus ==========
%hook SCPlusHandler
- (BOOL)isPlusSubscriber {
    return YES;
}
- (void)showPlusFeatures {
    %orig;
}
%end
