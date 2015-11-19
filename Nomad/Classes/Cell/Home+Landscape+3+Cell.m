#import "Home+Landscape+3+Cell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Movie+Model.h"
#import "Serial+Model.h"
@implementation Home_Landscape_3_Cell
- (void)set:(id)model {
    NSDictionary *image_data;
    if([model isKindOfClass:[Movie_Model class]]) {
        Movie_Model *movie_model = (Movie_Model *)model;
        [self.lbl_title setText:movie_model.title];
        image_data = movie_model.images;
    }else if([model isKindOfClass:[Serial_Model class]]) {
        Serial_Model *serial_model = (Serial_Model *)model;
        [self.lbl_title setText:serial_model.title];
        image_data = serial_model.images;
    }
    NSString *image_url = text_blank;
    if([Global_Controller isNotNull:[image_data objectForKey:@"by_width"]]) {
        image_url = [[image_data objectForKey:@"by_width"] stringByReplacingOccurrencesOfString:@"{width}" withString:[NSString stringWithFormat:@"%.f", self.frame.size.width]];
    }else if([image_data objectForKey:@"youtube"] != nil) {
        image_url = [[image_data objectForKey:@"youtube"] objectForKey:@"hq"];
    }
    [self.image sd_setImageWithURL:[NSURL URLWithString:image_url] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageCacheMemoryOnly];
}
@end