#import "Layout+Controller.h"
@interface Home_Potrait_View : UIView
@property (nonatomic, assign) id<Layout_Controller_Delegate> layout_controller_delegate;
@property (nonatomic, strong) IBOutlet UILabel *lbl_title;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
@property (nonatomic, strong) IBOutlet UIButton *btn_refresh;
- (void)show:(NSString *)title
         Url:(NSString *)url
   VideoType:(VideoType)video_type;
@end