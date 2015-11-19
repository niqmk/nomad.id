#import "Serial+Episode+Cell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation Serial_Episode_Cell
- (void)set:(Serial_Detail_Model *)serial_detail_model {
    [self.lbl_title setText:serial_detail_model.title];
    NSDictionary *image_data = serial_detail_model.images;
    NSString *image_url = text_blank;
    if([Global_Controller isNotNull:[image_data objectForKey:@"by_width"]]) {
        image_url = [[image_data objectForKey:@"by_width"] stringByReplacingOccurrencesOfString:@"{width}" withString:[NSString stringWithFormat:@"%.f", self.frame.size.width]];
    }else if([image_data objectForKey:@"youtube"] != nil) {
        image_url = [[image_data objectForKey:@"youtube"] objectForKey:@"hq"];
    }
    [self.img_episode sd_setImageWithURL:[NSURL URLWithString:image_url] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageCacheMemoryOnly];
}
@end