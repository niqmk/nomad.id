#import "Search+Model.h"
@interface Search_Cell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) IBOutlet UILabel *lbl_value;
@property (nonatomic, strong) IBOutlet UILabel *lbl_type;
- (void)set:(Search_Model *)search_model;
@end