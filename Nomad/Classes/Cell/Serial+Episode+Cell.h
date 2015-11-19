#import "Serial+Detail+Model.h"
@interface Serial_Episode_Cell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) IBOutlet UIImageView *img_episode;
@property (nonatomic, strong) IBOutlet UILabel *lbl_title;
- (void)set:(Serial_Detail_Model *)serial_detail_model;
@end