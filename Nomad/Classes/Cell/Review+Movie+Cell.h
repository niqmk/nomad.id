#import <MarqueeLabel/MarqueeLabel.h>
#import "Member+Model.h"
@interface Review_Movie_Cell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) IBOutlet UIView *vw_rate;
@property (nonatomic, strong) IBOutlet MarqueeLabel *lbl_username;
@property (nonatomic, strong) IBOutlet UILabel *lbl_date;
@property (nonatomic, strong) IBOutlet UILabel *lbl_value;
- (UIColor *)set:(Member_Comment_Model *)member_comment_model
       UserRated:(bool)user_rated;
@end