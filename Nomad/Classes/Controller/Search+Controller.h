#import "Search+Cell.h"
@interface Search_Controller : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *lst_result;
@property (nonatomic, strong) IBOutlet UIView *vw_message;
@property (nonatomic, strong) IBOutlet UILabel *lbl_message;
@property (nonatomic, strong) IBOutlet UIView *vw_loading;
@property (nonatomic, strong) UITextField *txt_search;
@property (nonatomic, strong) IBOutlet Search_Cell *search_cell;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
               Search:(NSString *)search;
@end