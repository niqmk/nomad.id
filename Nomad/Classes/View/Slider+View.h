#import "Slider+Model.h"
@protocol Slider_View_Delegate <NSObject>
@required
- (void)didSliderViewClicked:(Slider_Model *)slider_model;
@end
@interface Slider_View : UIView {
@private
    Slider_Model *slider_data;
}
@property (nonatomic, assign) id<Slider_View_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UIImageView *img_background;
@property (nonatomic, strong) IBOutlet UIImageView *image;
- (void)set:(Slider_Model *)slider_model
      Width:(float)width
     Height:(float)height;
@end