#import "Comment+Serial+Cell.h"
@implementation Comment_Serial_Cell
- (void)set:(Member_Comment_Model *)member_comment_model {
    [self.lbl_username setText:member_comment_model.member_username];
    [self.lbl_date setText:[Global_Controller getDate:[Global_Controller getDate:member_comment_model.created_at] Format:date_format]];
    [self.lbl_value setText:member_comment_model.desc];
    [self.lbl_value sizeToFit];
}
- (void)setColor:(UIColor *)color {
    [self.view setBackgroundColor:color];
}
@end