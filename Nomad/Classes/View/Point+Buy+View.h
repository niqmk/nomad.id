#import "Point+Cell.h"
@protocol Point_Buy_View_Delegate <NSObject>
@required
- (void)didPointBuyViewSelected:(Paid_Point_Model *)paid_point_model;
@end
@interface Point_Buy_View : UIView <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) id<Point_Buy_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UITableView *lst_point;
@property (nonatomic, strong) IBOutlet UIView *vw_loading;
@property (nonatomic, strong) IBOutlet Point_Cell *point_cell;
- (void)show;
@end