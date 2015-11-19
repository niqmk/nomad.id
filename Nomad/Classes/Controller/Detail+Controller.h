#import "Menu+View.h"
#import "Layout+Controller.h"
@interface Detail_Controller : UIViewController
<UIScrollViewDelegate,
Menu_View_Delegate,
Detail_Movie_View_Delegate,
Review_Movie_View_Delegate,
Related_Movie_View_Delegate,
Detail_Serial_View_Delegate,
Comment_Serial_View_Delegate,
Related_Serial_View_Delegate>
@property (nonatomic, strong) IBOutlet UIScrollView *scv_menu;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
@property (nonatomic, strong) IBOutlet UIView *vw_loading;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
                 Data:(id)data;
- (void)reload;
- (BOOL)isAutorotate;
@end