#import "Movie+Detail+Model.h"
@protocol Related_Movie_View_Delegate <NSObject>
@required
- (void)didRelatedMovieViewSelected:(id)model;
@end
@interface Related_Movie_View : UIView
@property (nonatomic, assign) id<Related_Movie_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
- (void)show:(Movie_Detail_Model *)model
       Width:(float)width;
@end