#import "Comment+Serial+Cell.h"
#import "Serial+Detail+Model.h"
@protocol Comment_Serial_View_Delegate <NSObject>
@optional
- (void)didCommentSerialViewWriteComment;
- (void)didCommentSerialViewEditComment;
@end
@interface Comment_Serial_View : UIView <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) id<Comment_Serial_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UITableView *lst_comment;
@property (nonatomic, strong) IBOutlet UIView *vw_no_result;
@property (nonatomic, strong) IBOutlet UIButton *btn_write_comment;
@property (nonatomic, strong) IBOutlet UILabel *lbl_sample;
@property (nonatomic, strong) IBOutlet Comment_Serial_Cell *comment_serial_cell;
- (void)show:(Serial_Detail_Model *)serial_detail_model
       Width:(float)width;
@end