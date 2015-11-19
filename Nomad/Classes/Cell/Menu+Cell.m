#import "Menu+Cell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation Menu_Cell
- (void)set:(id)model {
    if([model isKindOfClass:[Menu_Model class]]) {
        Menu_Model *menu_model = (Menu_Model *)model;
        NSString *image_url = [[menu_model.images objectForKey:@"by_width"] stringByReplacingOccurrencesOfString:@"{width}" withString:[NSString stringWithFormat:@"%.f", self.img_menu.frame.size.width * 2]];
        [self.lbl_menu setText:menu_model.name];
        [self.img_menu sd_setImageWithURL:[NSURL URLWithString:image_url] placeholderImage:nil options:SDWebImageRetryFailed];
    }else if([model isKindOfClass:[Menu_Category_Model class]]) {
        Menu_Category_Model *menu_category_model = (Menu_Category_Model *)model;
        NSString *image_url = [[menu_category_model.images objectForKey:@"by_width"] stringByReplacingOccurrencesOfString:@"{width}" withString:[NSString stringWithFormat:@"%.f", self.img_menu.frame.size.width * 2]];
        [self.lbl_menu setText:menu_category_model.name];
        [self.img_menu sd_setImageWithURL:[NSURL URLWithString:image_url] placeholderImage:nil options:SDWebImageRetryFailed];
    }
}
@end