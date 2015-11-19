#import "Price+Cell.h"
@implementation Price_Cell
- (void)set:(Price_Model *)price_model {
    [self.lbl_price setText:[NSString stringWithFormat:@"%@ points", [Global_Controller format:price_model.price]]];
    [self.lbl_expiry setText:[NSString stringWithFormat:@"%ld days", price_model.expiry_days]];
}
@end