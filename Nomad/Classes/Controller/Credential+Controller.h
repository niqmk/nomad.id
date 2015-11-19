@interface Credential_Controller : UIViewController <UITextFieldDelegate>
@property (nonatomic, strong) IBOutlet UIButton *btn_login;
@property (nonatomic, strong) IBOutlet UIButton *btn_register;
@property (nonatomic, strong) IBOutlet UIButton *btn_facebook;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
@property (nonatomic, strong) IBOutlet UIView *vw_loading;
@property (nonatomic, strong) IBOutlet UIView *vw_login;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_login;
@property (nonatomic, strong) IBOutlet UITextField *txt_login_email;
@property (nonatomic, strong) IBOutlet UITextField *txt_login_password;
@property (nonatomic, strong) IBOutlet UIButton *btn_login_action;
@property (nonatomic, strong) IBOutlet UIView *vw_register;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_register;
@property (nonatomic, strong) IBOutlet UITextField *txt_register_username;
@property (nonatomic, strong) IBOutlet UITextField *txt_register_email;
@property (nonatomic, strong) IBOutlet UITextField *txt_register_password;
@property (nonatomic, strong) IBOutlet UITextField *txt_register_confirm_password;
@property (nonatomic, strong) IBOutlet UIButton *btn_register_action;
@end