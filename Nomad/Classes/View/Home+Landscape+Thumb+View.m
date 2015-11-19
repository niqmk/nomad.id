#import "Home+Landscape+Thumb+View.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Movie+Model.h"
#import "Serial+Model.h"
@implementation Home_Landscape_Thumb_View
- (id)init {
    Home_Landscape_Thumb_View *home_landscape_thumb_view = [[[NSBundle mainBundle] loadNibNamed:@"Home+Landscape+Thumb+View" owner:nil options:nil] objectAtIndex:0];
    if([home_landscape_thumb_view isKindOfClass:[Home_Landscape_Thumb_View class]]) {
        return home_landscape_thumb_view;
    }else {
        return nil;
    }
}
- (IBAction)doSelect:(id)sender {
    if(self.delegate != nil) {
        [self.delegate didHomeLandscapeThumbViewSelected:data];
    }
}
- (void)set:(id)model {
    data = model;
    NSDictionary *image_data;
    if([model isKindOfClass:[Movie_Model class]]) {
        image_data = ((Movie_Model *)model).images;
    }else if([model isKindOfClass:[Serial_Model class]]) {
        image_data = ((Serial_Model *)model).images;
    }
    NSString *image_url = text_blank;
    if([Global_Controller isNotNull:[image_data objectForKey:@"by_width"]]) {
        image_url = [[image_data objectForKey:@"by_width"] stringByReplacingOccurrencesOfString:@"{width}" withString:[NSString stringWithFormat:@"%.f", self.frame.size.width * 2]];
    }else if([image_data objectForKey:@"youtube"] != nil) {
        image_url = [[image_data objectForKey:@"youtube"] objectForKey:@"hq"];
    }
    [self.image sd_setImageWithURL:[NSURL URLWithString:image_url] placeholderImage:[UIImage imageNamed:@"Image-Preload"] options:SDWebImageRetryFailed|SDWebImageCacheMemoryOnly];
}
@end