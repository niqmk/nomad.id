#import "Download+List+Cell.h"
@interface Download_List_Controller : UIViewController
<UITableViewDataSource,
UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *lst_download;
@property (nonatomic, strong) IBOutlet Download_List_Cell *download_list_cell;
@end
