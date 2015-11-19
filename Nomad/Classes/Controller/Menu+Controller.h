#import "Menu+Cell.h"
@interface Menu_Controller : UIViewController
<UITableViewDataSource,
UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UIButton *btn_submenu;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_menu;
@property (nonatomic, strong) IBOutlet UIView *vw_loading;
@property (nonatomic, strong) IBOutlet UITableView *lst_menu;
@property (nonatomic, strong) IBOutlet UIImageView *img_menu_footer;
@property (nonatomic, strong) IBOutlet Menu_Cell *menu_cell;
@end