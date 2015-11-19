#import "Member+Review+View.h"
#import "Modal+Controller.h"
#import "Movie+URL+Manager.h"
@implementation Member_Review_View {
@private
    UIViewController *controller;
    UITapGestureRecognizer *tap_recognizer;
    long _id;
    Member_Comment_Model *member_comment_data;
    long star;
}
- (id)init {
    Member_Review_View *member_review_view = [[[NSBundle mainBundle] loadNibNamed:@"Member+Review+View" owner:nil options:nil] objectAtIndex:0];
    if([member_review_view isKindOfClass:[Member_Review_View class]]) {
        return member_review_view;
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
    if(star == 0) {
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_star_blank"]
                         Delegate:nil];
        return;
    }
    [App_Controller showLoading:controller];
    [Movie_URL_Manager MovieReview:_id
                       Description:desc
                              Rate:star
                           Headers:[App_Controller getHeaders]
    Complete:^(NSDictionary *result) {
        [App_Controller closeLoading];
        [self.delegate didMemberReviewViewSucceeded:result];
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
      Review:(Member_Comment_Model *)member_comment_model
    Delegate:(id<Member_Review_View_Delegate>)delegate {
    controller = view_controller;
    _id = id;
    member_comment_data = member_comment_model;
    self.delegate = delegate;
    if(member_comment_model == nil) {
        star = 0;
    }else {
        star = member_comment_data.rate;
        [self setRate];
        [self.txt_description setText:member_comment_data.desc];
    }
    [self.vw_main rounded];
    [self.txt_description rounded];
    [self.txt_description stroke:0.5f];
    [App_Controller addKeyboardListen:self
                       onKeyboardShow:@selector(keyboardWillShow:)
                       onKeyboardHide:@selector(keyboardWillHide:)];
    tap_recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
}
- (IBAction)doStar1:(id)sender {
    star = 1;
    [self.btn_star_1 setSelected:true];
    [self.btn_star_2 setSelected:false];
    [self.btn_star_3 setSelected:false];
    [self.btn_star_4 setSelected:false];
    [self.btn_star_5 setSelected:false];
}
- (IBAction)doStar2:(id)sender {
    star = 2;
    [self.btn_star_1 setSelected:true];
    [self.btn_star_2 setSelected:true];
    [self.btn_star_3 setSelected:false];
    [self.btn_star_4 setSelected:false];
    [self.btn_star_5 setSelected:false];
}
- (IBAction)doStar3:(id)sender {
    star = 3;
    [self.btn_star_1 setSelected:true];
    [self.btn_star_2 setSelected:true];
    [self.btn_star_3 setSelected:true];
    [self.btn_star_4 setSelected:false];
    [self.btn_star_5 setSelected:false];
}
- (IBAction)doStar4:(id)sender {
    star = 4;
    [self.btn_star_1 setSelected:true];
    [self.btn_star_2 setSelected:true];
    [self.btn_star_3 setSelected:true];
    [self.btn_star_4 setSelected:true];
    [self.btn_star_5 setSelected:false];
}
- (IBAction)doStar5:(id)sender {
    star = 5;
    [self.btn_star_1 setSelected:true];
    [self.btn_star_2 setSelected:true];
    [self.btn_star_3 setSelected:true];
    [self.btn_star_4 setSelected:true];
    [self.btn_star_5 setSelected:true];
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
- (void)setRate {
    [self.btn_star_1 setSelected:true];
    if(star > 1) {
        [self.btn_star_2 setSelected:true];
    }
    if(star > 2) {
        [self.btn_star_3 setSelected:true];
    }
    if(star > 3) {
        [self.btn_star_4 setSelected:true];
    }
    if(star > 4) {
        [self.btn_star_5 setSelected:true];
    }
}
@end