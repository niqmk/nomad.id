#import "Search+Cell.h"
@implementation Search_Cell
- (void)set:(Search_Model *)search_model {
    [self.lbl_value setText:search_model.title];
    [self.lbl_type setText:[NSString stringWithFormat:@"in %@", search_model.type]];
}
@end