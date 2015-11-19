#import "Credential+Controller.h"
#import "Forgot+Password+View.h"
#import "URL+Manager.h"
#import "Modal+Controller.h"
#import "Facebook+Controller.h"
#import "Login+Model.h"
typedef NS_ENUM(NSUInteger, LandState) {
    LOGIN,
    REGISTER
};
@implementation Credential_Controller {
@private
    Forgot_Password_View *forgot_password_view;
    Global_Variables *gb_variables;
    UITapGestureRecognizer *tap_recognizer;
    UITextField *active_field;
    LandState land_state;
    float y;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        gb_variables = [Global_Variables instance];
    }
    return self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([self.txt_login_email isFirstResponder]) {
        [self.txt_login_email resignFirstResponder];
        [self.txt_login_password becomeFirstResponder];
        return NO;
    }else if([self.txt_login_password isFirstResponder]) {
        [self.txt_login_password resignFirstResponder];
        [self doLoginAction:self];
        return NO;
    }else if([self.txt_register_email isFirstResponder]) {
        [self.txt_register_email resignFirstResponder];
        [self.txt_register_username becomeFirstResponder];
        return NO;
    }else if([self.txt_register_username isFirstResponder]) {
        [self.txt_register_username resignFirstResponder];
        [self.txt_register_password becomeFirstResponder];
        return NO;
    }else if([self.txt_register_password isFirstResponder]) {
        [self.txt_register_password resignFirstResponder];
        [self.txt_register_confirm_password becomeFirstResponder];
        return NO;
    }else if([self.txt_register_confirm_password isFirstResponder]) {
        [self doRegisterAction:self];
        return NO;
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    active_field = textField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInitial];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGSize size = self.scv_main.frame.size;
    self.vw_login.frame = CGRectMake(0, 0, size.width, size.height);
    self.vw_register.frame = CGRectMake(size.width, 0, size.width, size.height);
    self.scv_main.contentSize = CGSizeMake(size.width * 2, size.height);
    [self.vw_loading setHidden:true];
}
- (IBAction)doFacebookLogin:(id)sender {
    [App_Controller showLoading:self];
    [Facebook_Controller login:self
                      Complete:^(Facebook_Model *facebook_model) {
        [URL_Manager FBLogin:facebook_model.fb_id
                       Email:facebook_model.email
                    Fullname:facebook_model.fullname
        Complete:^(NSDictionary *response) {
            [App_Controller closeLoading];
            Login_Model *login_model = [Login_Model init:response];
            [gb_variables->user_session openSession:login_model];
            [self close:true];
        } Failed:^(NSString *message) {
            [App_Controller closeLoading];
            [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                              Message:message
                             Delegate:nil];
        } Error:^(NSInteger status_code, NSDictionary *response) {
            [App_Controller closeLoading];
            [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                              Message:[App_Controller getError:@"error_request_failed"]
                             Delegate:nil];
        }];
    } Cancelled:^{
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_facebook_cancelled"]
                         Delegate:nil];
    } Failed:^{
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_facebook_failed"]
                         Delegate:nil];
    }];
}
- (IBAction)doForgotPassword:(id)sender {
    forgot_password_view = [[Forgot_Password_View alloc] init];
    forgot_password_view.frame = self.view.bounds;
    [forgot_password_view show:self];
    [Modal_Controller show:self View:forgot_password_view];
}
- (IBAction)doLogin:(id)sender {
    [self closeFocus];
    land_state = LOGIN;
    [self setState];
}
- (IBAction)doRegister:(id)sender {
    [self closeFocus];
    land_state = REGISTER;
    [self setState];
}
- (IBAction)doLoginCancel:(id)sender {
    [self closeFocus];
    [self close:false];
}
- (IBAction)doLoginAction:(id)sender {
    [self closeFocus];
    NSString *email = self.txt_login_email.text;
    NSString *password = self.txt_login_password.text;
    if(![Global_Controller isEmail:email]) {
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_email"]
                         Delegate:nil];
        return;
    }else if(![Global_Controller isNotNull:password]) {
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_password_blank"]
                         Delegate:nil];
        return;
    }
    [App_Controller showLoading:self];
    [URL_Manager Login:email
              Password:password
    Complete:^(NSDictionary *response) {
        [App_Controller closeLoading];
        Login_Model *login_model = [Login_Model init:response];
        [gb_variables->user_session openSession:login_model];
        [self close:true];
    } Failed:^(NSString *message) {
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:message
                         Delegate:nil];
    } Error:^(NSInteger status_code, NSDictionary *response) {
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_request_failed"]
                         Delegate:nil];
    }];
}
- (IBAction)doRegisterCancel:(id)sender {
    [self closeFocus];
    [App_Controller closeCredential:nil];
}
- (IBAction)doRegisterAction:(id)sender {
    y = 0;
    [self closeFocus];
    NSString *username = self.txt_register_username.text;
    NSString *email = self.txt_register_email.text;
    NSString *password = self.txt_register_password.text;
    NSString *confirm_password = self.txt_register_confirm_password.text;
    if(![Global_Controller isEmail:email]) {
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_email"]
                         Delegate:nil];
        return;
    }else if(![Global_Controller isNotNull:password]) {
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_password_blank"]
                         Delegate:nil];
        return;
    }else if(![password isEqualToString:confirm_password]) {
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_password_not_same"]
                         Delegate:nil];
        return;
    }
    [App_Controller showLoading:self];
    [URL_Manager Register:email
                 Username:username
                 Password:password
     PasswordConfirmation:confirm_password
    Complete:^(NSDictionary *response) {
        [App_Controller closeLoading];
        Login_Model *login_model = [Login_Model init:response];
        [gb_variables->user_session openSession:login_model];
        [App_Controller closeCredential:^{
            [App_Controller openHomeController];
        }];
    } Failed:^(NSString *message) {
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:message
                         Delegate:nil];
    } Error:^(NSInteger status_code, NSDictionary *response) {
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_request_failed"]
                         Delegate:nil];
    }];
}
- (void)setInitial {
    [self.btn_facebook rounded];
    [[self.btn_facebook imageView] setContentMode: UIViewContentModeScaleAspectFit];
    [self.btn_facebook setImage:[UIImage imageNamed:@"Icon-Facebook"] forState:UIControlStateNormal];
    [self.scv_main addSubview:self.vw_login];
    [self.scv_main addSubview:self.vw_register];
    self.scv_register.contentSize = CGSizeMake(self.scv_register.frame.size.width, self.txt_register_confirm_password.frame.origin.y + self.txt_register_confirm_password.frame.size.height + 20);
    [App_Controller addKeyboardListen:self
                       onKeyboardShow:@selector(keyboardWillShow:)
                       onKeyboardHide:@selector(keyboardWillHide:)];
    tap_recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    land_state = LOGIN;
    [self setState];
}
- (void)keyboardWillShow:(NSNotification *)note {
    [self.view addGestureRecognizer:tap_recognizer];
    if(active_field != nil) {
        if(land_state == LOGIN) {
            CGRect rect = self.btn_login_action.frame;
            [Global_Controller focusOnRect:self.scv_login
                                     Frame:rect
                            OptionalHeight:active_field.frame.origin.y - 5
                                 OptionalX:0
                              Notification:note];
        }else if(land_state == REGISTER) {
            CGRect rect = self.btn_register_action.frame;
            y = self.scv_register.contentOffset.y;
            [Global_Controller focusOnRect:self.scv_register
                                     Frame:rect
                            OptionalHeight:active_field.frame.origin.y - 5
                                 OptionalX:0
                              Notification:note];
        }
    }
}
- (void)keyboardWillHide:(NSNotification *)note {
    [self.view removeGestureRecognizer:tap_recognizer];
    if(land_state == LOGIN) {
        [self.scv_login setContentOffset:CGPointZero animated:YES];
    }else if(land_state == REGISTER) {
        CGPoint point = CGPointMake(0, y);
        [self.scv_register setContentOffset:point animated:YES];
    }
    active_field = nil;
}
- (void)didTapAnywhere:(UITapGestureRecognizer *)recognizer {
    [self closeFocus];
}
- (void)closeFocus {
    if([self.txt_login_email isFirstResponder]) {
        [self.txt_login_email resignFirstResponder];
    }else if([self.txt_login_password isFirstResponder]) {
        [self.txt_login_password resignFirstResponder];
    }else if([self.txt_register_username isFirstResponder]) {
        [self.txt_register_username resignFirstResponder];
    }else if([self.txt_register_email isFirstResponder]) {
        [self.txt_register_email resignFirstResponder];
    }else if([self.txt_register_password isFirstResponder]) {
        [self.txt_register_password resignFirstResponder];
    }else if([self.txt_register_confirm_password isFirstResponder]) {
        [self.txt_register_confirm_password resignFirstResponder];
    }
}
- (void)close:(bool)open_home {
    [App_Controller removeKeyboardListen:self];
    if(open_home) {
        [App_Controller closeCredential:^{
            [App_Controller openHomeController];
        }];
    }else {
        [App_Controller closeCredential:nil];
    }
}
- (void)setState {
    switch (land_state) {
        case LOGIN:
        {
            [self.btn_login setSelected:true];
            [self.btn_register setSelected:false];
            CGRect visible = CGRectMake(0, 0, self.scv_main.frame.size.width, self.scv_main.frame.size.height);
            [self.scv_main scrollRectToVisible:visible animated:YES];
            break;
        }
        case REGISTER:
        {
            [self.btn_login setSelected:false];
            [self.btn_register setSelected:true];
            CGRect visible = CGRectMake(self.scv_main.frame.size.width, 0, self.scv_main.frame.size.width, self.scv_main.frame.size.height);
            [self.scv_main scrollRectToVisible:visible animated:YES];
            break;
        }
        default:
            break;
    }
}
@end