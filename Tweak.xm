#import <UIKit/UIKit.h>

@interface SCSnapController : UIViewController
- (void)viewDidLoad;
- (void)saveSnap;
@end

@interface SCChatViewController : UIViewController
- (void)viewDidLoad;
@end

@interface SCScreenshotDetector : NSObject
+ (instancetype)sharedInstance;
- (void)stopMonitoring;
@end

@interface SCReplayManager : NSObject
+ (instancetype)sharedInstance;
- (void)setUnlimitedReplays:(BOOL)unlimited;
@end

// ------ اللمسة البنفسجية ------
%hook SCChatViewController
- (void)viewDidLoad {
    %orig;
    self.view.backgroundColor = [UIColor colorWithRed:0.75 green:0.35 blue:0.85 alpha:1.0]; // بنفسجي
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.75 green:0.35 blue:0.85 alpha:1.0];
    self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.75 green:0.35 blue:0.85 alpha:1.0];
}
%end

// ------ 1. حفظ السنابات تلقائياً ------
%hook SCSnapController
- (void)viewDidLoad {
    %orig;
    // إضافة زر الحفظ
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    saveButton.frame = CGRectMake(self.view.frame.size.width - 60, 50, 40, 40);
    [saveButton setTitle:@"💾" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveSnap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
}
%end

// ------ 2. إعادة تشغيل غير محدودة ------
%hook SCReplayManager
- (void)setup {
    %orig;
    [self setUnlimitedReplays:YES];
}
%end

// ------ 3. منع إشعارات التصوير ------
%hook SCScreenshotDetector
- (void)startMonitoring {
    %orig;
    [[SCScreenshotDetector sharedInstance] stopMonitoring]; // إيقاف المراقبة
}
%end

// ------ 4. تفعيل مميزات سناب شات بلس ------
%hook SCPlusHandler
- (BOOL)isPlusSubscriber {
    return YES; // تزوير الاشتراك
}
- (void)showPlusFeatures {
    %orig;
    // يمكن إضافة المزيد من التفاصيل هنا
}
%end
