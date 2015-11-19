#import "YTPlayerView.h"
@interface Youtube_Controller : NSObject <YTPlayerViewDelegate>
@property (nonatomic, strong) IBOutlet YTPlayerView *vw_youtube;
- (void)open:(NSString *)url
        View:(UIView *)view;
- (void)close;
@end