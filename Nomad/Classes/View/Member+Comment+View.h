#import "Member+Model.h"
@protocol Member_Comment_View_Delegate <NSObject>
@required
- (void)didMemberCommentViewSucceeded:(NSDictionary *)result;
- (void)didMemberCommentViewCancelled;
@end
@interface Member_Comment_View : UIView <UITextViewDelegate>
@property (nonatomic, assign) id<Member_Comment_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
@property (nonatomic, strong) IBOutlet UIView *vw_main;
@property (nonatomic, strong) IBOutlet UITextView *txt_description;
- (void)show:(UIViewController *)view_controller
          ID:(long)id
    Delegate:(id<Member_Comment_View_Delegate>)delegate;
@end