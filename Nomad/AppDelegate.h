@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
- (void)checkSession;
- (void)openHomeController;
- (void)openLandController:(bool)show_login;
- (void)openHome;
- (void)openHome:(UIViewController *)view_controller;
@end