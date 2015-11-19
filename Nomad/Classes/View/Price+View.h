#import "Price+Cell.h"
@protocol Price_View_Delegate <NSObject>
@required
- (void)didPriceViewSelected:(long)index;
- (void)didPriceViewCancelled;
@end
@interface Price_View : UIView
<UITableViewDataSource,
UITableViewDelegate>
@property (nonatomic, assign) id<Price_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
@property (nonatomic, strong) IBOutlet UIView *vw_main;
@property (nonatomic, strong) IBOutlet UITableView *lst_prices;
@property (nonatomic, strong) IBOutlet UIButton *btn_cancel;
@property (nonatomic, strong) IBOutlet UIButton *btn_select;
@property (nonatomic, strong) IBOutlet Price_Cell *price_cell;
- (void)show:(UIViewController *)view_controller
        List:(NSMutableArray *)list
    Delegate:(id<Price_View_Delegate>)delegate;
@end