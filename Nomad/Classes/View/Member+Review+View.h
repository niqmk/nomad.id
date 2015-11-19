#import "Member+Model.h"
@protocol Member_Review_View_Delegate <NSObject>
@required
- (void)didMemberReviewViewSucceeded:(NSDictionary *)result;
- (void)didMemberReviewViewCancelled;
@end
@interface Member_Review_View : UIView <UITextViewDelegate>
@property (nonatomic, assign) id<Member_Review_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
@property (nonatomic, strong) IBOutlet UIView *vw_main;
@property (nonatomic, strong) IBOutlet UIButton *btn_star_1;
@property (nonatomic, strong) IBOutlet UIButton *btn_star_2;
@property (nonatomic, strong) IBOutlet UIButton *btn_star_3;
@property (nonatomic, strong) IBOutlet UIButton *btn_star_4;
@property (nonatomic, strong) IBOutlet UIButton *btn_star_5;
@property (nonatomic, strong) IBOutlet UITextView *txt_description;
- (void)show:(UIViewController *)view_controller
          ID:(long)id
      Review:(Member_Comment_Model *)member_comment_model
    Delegate:(id<Member_Review_View_Delegate>)delegate;
@end