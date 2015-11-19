#import "Serial+Detail+Model.h"
@protocol Related_Serial_View_Delegate <NSObject>
@required
- (void)didRelatedSerialViewSelected:(Serial_Detail_Model *)serial_detail_model;
@end
@interface Related_Serial_View : UIView
@property (nonatomic, assign) id<Related_Serial_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
- (void)show:(Serial_Detail_Model *)model
       Width:(float)width;
@end