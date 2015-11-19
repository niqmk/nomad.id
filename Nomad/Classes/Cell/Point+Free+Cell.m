#import "Point+Free+Cell.h"
@implementation Point_Free_Cell
- (void)set:(Free_Point_Model *)free_point_model {
    [self.lbl_point setText:[NSString stringWithFormat:@"%@ points", [Global_Controller format:free_point_model.point]]];
    [self.lbl_name setText:free_point_model.name];
}
@end