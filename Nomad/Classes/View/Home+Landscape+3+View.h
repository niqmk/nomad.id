#import "Layout+Menu+Controller.h"
#import "Home+Landscape+3+Cell.h"
@interface Home_Landscape_3_View : UIView <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) id<Layout_Menu_Controller_Delegate> layout_menu_controller_delegate;
@property (nonatomic, strong) IBOutlet UITableView *lst_main;
@property (nonatomic, strong) IBOutlet UIView *vw_loading;
@property (nonatomic, strong) IBOutlet UIView *vw_refresh;
@property (nonatomic, strong) IBOutlet Home_Landscape_3_Cell *home_landscape_3_cell;
- (void)show:(NSString *)key
  CategoryID:(long)category_id
         URL:(NSString *)url
   VideoType:(VideoType)video_type
       Width:(float)width;
@end