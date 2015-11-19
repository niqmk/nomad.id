#import "Point+Cell.h"
@implementation Point_Cell
- (void)set:(Paid_Point_Model *)paid_point_model {
    [self.lbl_point setText:[NSString stringWithFormat:@"%@ points", [Global_Controller format:paid_point_model.point]]];
    [self.lbl_price_in_idr setText:[NSString stringWithFormat:@"Rp. %@", [Global_Controller format:paid_point_model.price_in_idr]]];
}
@end