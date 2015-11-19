#import "Menu+Model.h"
@interface Menu_Cell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) IBOutlet UIImageView *img_menu;
@property (nonatomic, strong) IBOutlet UILabel *lbl_menu;
- (void)set:(id)model;
@end