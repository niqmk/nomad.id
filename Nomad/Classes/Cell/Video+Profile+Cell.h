@interface Video_Profile_Cell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) IBOutlet UILabel *lbl_profile;
- (void)set:(NSString *)value;
@end