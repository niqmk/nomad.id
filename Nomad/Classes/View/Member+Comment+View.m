#import "Member+Comment+View.h"
#import "Modal+Controller.h"
#import "Serial+URL+Manager.h"
@implementation Member_Comment_View {
@private
    UIViewController *controller;
    UITapGestureRecognizer *tap_recognizer;
    long _id;
}
- (id)init {
    Member_Comment_View *member_comment_view = [[[NSBundle mainBundle] loadNibNamed:@"Member+Comment+View" owner:nil options:nil] objectAtIndex:0];
    if([member_comment_view isKindOfClass:[Member_Comment_View class]]) {
        return member_comment_view;
    }else {
        return nil;
    }
}
- (IBAction)doCancel:(id)sender {
    [self closeFocus];
    [self close];
}
- (IBAction)doSubmit:(id)sender {
    [self closeFocus];
    NSString *desc = self.txt_description.text;
    if(![Global_Controller isNotNull:desc]) {
        desc = text_blank;
    }
    [App_Controller showLoading:controller];
    [Serial_URL_Manager SerialComment:_id
                          Description:desc
                              Headers:[App_Controller getHeaders]
    Complete:^(NSDictionary *result) {
        [App_Controller closeLoading];
        [self.delegate didMemberCommentViewSucceeded:result];
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
- (void)show:(UIViewController *)view_controller
          ID:(long)id
    Delegate:(id<Member_Comment_View_Delegate>)delegate {
    controller = view_controller;
    _id = id;
    self.delegate = delegate;
    [self.vw_main rounded];
    [self.txt_description rounded];
    [self.txt_description stroke:0.5f];
    [App_Controller addKeyboardListen:self
                       onKeyboardShow:@selector(keyboardWillShow:)
                       onKeyboardHide:@selector(keyboardWillHide:)];
    tap_recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
}
- (void)keyboardWillShow:(NSNotification *)note {
    [self addGestureRecognizer:tap_recognizer];
    CGRect rect = self.vw_main.frame;
    [Global_Controller focusOnRect:self.scv_main
                             Frame:rect
                    OptionalHeight:0
                         OptionalX:0
                      Notification:note];
}
- (void)keyboardWillHide:(NSNotification *)note {
    [self removeGestureRecognizer:tap_recognizer];
    [self.scv_main setContentOffset:CGPointZero animated:YES];
}
- (void)didTapAnywhere:(UITapGestureRecognizer *)recognizer {
    [self closeFocus];
}
- (void)closeFocus {
    if([self.txt_description isFirstResponder]) {
        [self.txt_description resignFirstResponder];
    }
}
- (void)close {
    [App_Controller removeKeyboardListen:self];
    [Modal_Controller close];
}
@end