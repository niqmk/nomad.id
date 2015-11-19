#import <MarqueeLabel/MarqueeLabel.h>
#import "Member+Model.h"
@interface Comment_Serial_Cell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) IBOutlet MarqueeLabel *lbl_username;
@property (nonatomic, strong) IBOutlet UILabel *lbl_date;
@property (nonatomic, strong) IBOutlet UILabel *lbl_value;
- (void)set:(Member_Comment_Model *)member_comment_model;
- (void)setColor:(UIColor *)color;
@end