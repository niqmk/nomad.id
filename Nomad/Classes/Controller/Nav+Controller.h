@interface Nav_Controller : UINavigationController
- (void)openMenu;
- (void)openDefaultRoot;
- (void)openAsRoot:(UIViewController *)view_controller;
- (void)reload;
- (BOOL)isAutorotate;
@end