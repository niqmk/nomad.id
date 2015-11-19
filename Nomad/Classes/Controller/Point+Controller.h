#import "Point+Cell.h"
@interface Point_Controller : UIViewController <UIScrollViewDelegate>
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
@property (nonatomic, strong) IBOutlet UIButton *btn_buy;
@property (nonatomic, strong) IBOutlet UIButton *btn_free;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
           FromDetail:(bool)from_detail;
@end