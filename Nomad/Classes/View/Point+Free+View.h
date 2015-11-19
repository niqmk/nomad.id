#import "Point+Free+Cell.h"
@interface Point_Free_View : UIView <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *lst_point;
@property (nonatomic, strong) IBOutlet UIView *vw_loading;
@property (nonatomic, strong) IBOutlet Point_Free_Cell *point_free_cell;
- (void)show;
@end