#import "Slider+View.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation Slider_View
- (id)init {
    Slider_View *slider_view = [[[NSBundle mainBundle] loadNibNamed:@"Slider+View" owner:nil options:nil] objectAtIndex:0];
    if([slider_view isKindOfClass:[Slider_View class]]) {
        return slider_view;
    }else {
        return nil;
    }
}
- (IBAction)doClick:(id)sender {
    if(self.delegate != nil) {
        [self.delegate didSliderViewClicked:slider_data];
    }
}
- (void)set:(Slider_Model *)slider_model
      Width:(float)width
     Height:(float)height {
    slider_data = slider_model;
    NSString *image_preload = [[slider_model.images objectForKey:@"by_width"] stringByReplacingOccurrencesOfString:@"{width}" withString:[NSString stringWithFormat:@"%.f", 10.0f]];
    [self.img_background sd_setImageWithURL:[NSURL URLWithString:image_preload] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(image == nil) {
            return;
        }
        NSString *image_slider = [[slider_model.images objectForKey:@"by_width"] stringByReplacingOccurrencesOfString:@"{width}" withString:[NSString stringWithFormat:@"%.f", width]];
        [self.image sd_setImageWithURL:[NSURL URLWithString:image_slider] placeholderImage:image options:SDWebImageRetryFailed];
    }];
}
@end