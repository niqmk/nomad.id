#import "Price+Model.h"
@interface Price_Cell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) IBOutlet UILabel *lbl_price;
@property (nonatomic, strong) IBOutlet UILabel *lbl_expiry;
- (void)set:(Price_Model *)price_model;
@end