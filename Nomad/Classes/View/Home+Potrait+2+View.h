#import "Layout+Menu+Controller.h"
@interface Home_Potrait_2_View : UIView
@property (nonatomic, assign) id<Layout_Menu_Controller_Delegate> layout_menu_controller_delegate;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
@property (nonatomic, strong) IBOutlet UIButton *btn_refresh;
@property (nonatomic, strong) IBOutlet UIView *vw_loading;
- (void)show:(NSString *)key
  CategoryID:(long)category_id
         URL:(NSString *)url
   VideoType:(VideoType)video_type
       Width:(float)width;
@end