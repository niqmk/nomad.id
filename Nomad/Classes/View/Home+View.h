#import "Slider+View.h"
@protocol Home_View_Delegate
@optional
- (void)didHomeViewSliderSelected:(Slider_Model *)slider_model;
- (void)didHomeViewPotraitSelected:(id)model;
- (void)didHomeViewLandscapeSelected:(id)model;
@end
@interface Home_View : UIView
@property (nonatomic, assign) id<Home_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_slider;
- (void)show:(float)width;
- (void)showWoSlider:(NSString *)key
               Width:(float)width;
@end