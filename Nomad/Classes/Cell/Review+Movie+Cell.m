#import "Review+Movie+Cell.h"
@implementation Review_Movie_Cell
static bool state;
- (UIColor *)set:(Member_Comment_Model *)member_comment_model
       UserRated:(bool)user_rated {
    float x = 0;
    if(user_rated) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.vw_rate.frame.size.width, self.vw_rate.frame.size.height)];
        [label setFont:[UIFont fontWithName:@"Helvetica Neue" size:10.0f]];
        [label setText:[App_Controller getLabel:@"label_user_rated"]];
        [label sizeToFit];
        [self.vw_rate addSubview:label];
        label.frame = CGRectMake(0, 0, label.frame.size.width, self.vw_rate.frame.size.height);
        x = label.frame.size.width + 10;
    }
    for(long counter = 1; counter <= member_comment_model.rate; counter++) {
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Button-Rated"]];
        image.frame = CGRectMake(x, 0, self.vw_rate.frame.size.height, self.vw_rate.frame.size.height);
        [self.vw_rate addSubview:image];
        x += self.vw_rate.frame.size.height + 5;
    }
    [self.lbl_username setText:member_comment_model.member_username];
    [self.lbl_date setText:[Global_Controller getDate:[Global_Controller getDate:member_comment_model.created_at] Format:date_format]];
    [self.lbl_value setText:member_comment_model.desc];
    [self.lbl_value sizeToFit];
    UIColor *color;
    state = !state;
    if(state) {
        color = [UIColor whiteColor];
    }else {
        color = [Global_Controller hexColor:@"#cfcfcf"];
    }
    [self.view setBackgroundColor:color];
    return color;
}
@end