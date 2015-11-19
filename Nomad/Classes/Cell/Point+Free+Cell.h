#import "Free+Point+Model.h"
@interface Point_Free_Cell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) IBOutlet UILabel *lbl_name;
@property (nonatomic, strong) IBOutlet UILabel *lbl_point;
- (void)set:(Free_Point_Model *)free_point_model;
@end