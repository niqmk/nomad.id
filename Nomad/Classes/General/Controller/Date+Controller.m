#import "Date+Controller.h"
@implementation Date_Controller
- (id)init:(id<DateDelegate>)d {
    if(self = [super init]) {
        delegate = d;
    }
    return self;
}
- (void)didDateViewSelected:(long)timestamp {
    [delegate didDateSelected:timestamp];
}
- (void)didDateViewCancel {
    [delegate didDateCancel];
}
- (void)open:(NSDate *)default_date
 SubsMinYear:(int)subs_min_year
 SubsMaxYear:(int)subs_max_year {
    if(date_view == nil) {
        date_view = [[Date_View alloc] init];
        date_view.delegate = self;
    }
    [date_view open:default_date SubsMinYear:subs_min_year SubsMaxYear:subs_max_year];
}
@end