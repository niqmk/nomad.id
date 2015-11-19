#import "Forgot+Password+View.h"
#import "Modal+Controller.h"
#import "URL+Manager.h"
@implementation Forgot_Password_View {
@private
    UIViewController *controller;
    UITapGestureRecognizer *tap_recognizer;
}
- (id)init {
    Forgot_Password_View *forgot_password_view = [[[NSBundle mainBundle] loadNibNamed:@"Forgot+Password+View" owner:nil options:nil] objectAtIndex:0];
    if([forgot_password_view isKindOfClass:[Forgot_Password_View class]]) {
        return forgot_password_view;
    }else {
        return nil;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([self.txt_email isFirstResponder]) {
        [self.txt_email resignFirstResponder];
        [self doReset:self];
        return NO;
    }
    return YES;
}
- (void)didAlertActioned:(NSInteger)index {
    [Modal_Controller close];
}
- (void)didAlertCancelled {}
- (void)show:(UIViewController *)view_controller {
    controller = view_controller;
    [self.vw_main rounded];
    [self setInitial];
}
- (IBAction)doCancel:(id)sender {
    [Modal_Controller close];
}
- (IBAction)doReset:(id)sender {
    [self closeFocus];
    NSString *email = self.txt_email.text;
    if(![Global_Controller isNotNull:email]) {
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_email"]
                         Delegate:nil];
        return;
    }
    [App_Controller showLoading:controller];
    [URL_Manager ForgotPassword:email
    Complete:^(NSString *message) {
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:message
                         Delegate:self];
        return;
    } Failed:^(NSString *message) {
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:message
                         Delegate:nil];
        return;
    } Error:^(NSInteger status_code, NSDictionary *response) {
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_request_failed"]
                         Delegate:nil];
    }];
}
- (void)setInitial {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    tap_recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
}
- (void)keyboardWillShow:(NSNotification *)note {
    [self addGestureRecognizer:tap_recognizer];
    CGRect rect = self.vw_main.frame;
    [Global_Controller focusOnRect:self.scv_main Frame:rect OptionalHeight:5 OptionalX:0 Notification:note];
}
- (void)keyboardWillHide:(NSNotification *)note {
    [self removeGestureRecognizer:tap_recognizer];
    [self.scv_main setContentOffset:CGPointZero animated:YES];
}
- (void)didTapAnywhere:(UITapGestureRecognizer *)recognizer {
    [self closeFocus];
}
- (void)closeFocus {
    if([self.txt_email isFirstResponder]) {
        [self.txt_email resignFirstResponder];
    }
}
@end