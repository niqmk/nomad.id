#import "Menu+View.h"
#import "Layout+Menu+Controller.h"
@interface Home_Menu_Controller : UIViewController
<UIScrollViewDelegate,
Menu_View_Delegate,
Home_Menu_View_Delegate>
@property (nonatomic, strong) IBOutlet UIScrollView *scv_menu;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
@property (nonatomic, strong) UITextField *txt_search;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
            VideoType:(VideoType)type
                   ID:(long)id;
- (void)pushDetail:(id)data;
- (void)close;
@end