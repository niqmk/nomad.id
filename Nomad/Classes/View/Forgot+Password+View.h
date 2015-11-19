@interface Forgot_Password_View : UIView <UITextFieldDelegate, Alert_Delegate>
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
@property (nonatomic, strong) IBOutlet UIView *vw_main;
@property (nonatomic, strong) IBOutlet UITextField *txt_email;
@property (nonatomic, strong) IBOutlet UIButton *btn_cancel;
@property (nonatomic, strong) IBOutlet UIButton *btn_reset;
- (void)show:(UIViewController *)view_controller;
@end