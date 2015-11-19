#import "Menu+View.h"
#import "Layout+Controller.h"
@interface Home_Controller : UIViewController
<UIScrollViewDelegate,
Menu_View_Delegate,
Home_View_Delegate>
@property (nonatomic, strong) IBOutlet UIScrollView *scv_menu;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
@property (nonatomic, strong) UITextField *txt_search;
- (void)pushDetail:(id)data;
- (void)close;
@end