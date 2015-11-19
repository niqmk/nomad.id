#import "Video+Profile+Cell.h"
@protocol Video_Profile_View_Delegate <NSObject>
@required
- (void)didVideoProfileViewSelected:(long)index;
- (void)didVideoProfileViewCancelled;
@end
@interface Video_Profile_View : UIView
<UITableViewDataSource,
UITableViewDelegate>
@property (nonatomic, assign) id<Video_Profile_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
@property (nonatomic, strong) IBOutlet UIView *vw_main;
@property (nonatomic, strong) IBOutlet UITableView *lst_video_profiles;
@property (nonatomic, strong) IBOutlet UIButton *btn_cancel;
@property (nonatomic, strong) IBOutlet Video_Profile_Cell *video_profile_cell;
- (void)show:(UIViewController *)view_controller
        Data:(NSDictionary *)data
    Delegate:(id<Video_Profile_View_Delegate>)delegate;
@end