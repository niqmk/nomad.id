#import "Paid+Point+Model.h"
@interface Point_Cell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) IBOutlet UILabel *lbl_point;
@property (nonatomic, strong) IBOutlet UILabel *lbl_price_in_idr;
- (void)set:(Paid_Point_Model *)paid_point_model;
@end