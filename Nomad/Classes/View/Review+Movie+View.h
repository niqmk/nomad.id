#import "Review+Movie+Cell.h"
#import "Movie+Detail+Model.h"
@protocol Review_Movie_View_Delegate <NSObject>
@optional
- (void)didReviewMovieViewWriteReview;
- (void)didReviewMovieViewEditReview:(Member_Comment_Model *)member_comment_model;
@end
@interface Review_Movie_View : UIView <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) id<Review_Movie_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UITableView *lst_review;
@property (nonatomic, strong) IBOutlet UIView *vw_no_result;
@property (nonatomic, strong) IBOutlet UIButton *btn_write_review;
@property (nonatomic, strong) IBOutlet UILabel *lbl_sample;
@property (nonatomic, strong) IBOutlet Review_Movie_Cell *review_movie_cell;
- (void)show:(Movie_Detail_Model *)movie_detail_model
       Width:(float)width;
@end