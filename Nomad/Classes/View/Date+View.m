#import "Date+View.h"
@implementation Date_View
- (id)init {
    Date_View *date_view = [[[NSBundle mainBundle] loadNibNamed:@"Date+View" owner:nil options:nil] objectAtIndex:0];
    if([date_view isKindOfClass:[Date_View class]]) {
        return date_view;
    }else {
        return nil;
    }
}
- (IBAction)doSelect:(id)sender {
    [self.delegate didDateViewSelected:[Global_Controller getTimestamp:self.dtp_date.date]];
}
- (IBAction)doCancel:(id)sender {
    [self.delegate didDateViewCancel];
}
- (void)open:(NSDate *)default_date SubsMinYear:(int)subs_min_year SubsMaxYear:(int)subs_max_year {
    self.vw_layout.frame = CGRectMake((self.frame.size.width - self.vw_layout.frame.size.width) / 2, (self.frame.size.height - self.vw_layout.frame.size.height) / 2, self.vw_layout.frame.size.width, self.vw_layout.frame.size.height);
    [self.vw_layout rounded];
    [self.scv_main addSubview:self.vw_layout];
    [self.dtp_date setMinimumDate:[Global_Controller getDateSubsYear:subs_min_year]];
    [self.dtp_date setMaximumDate:[Global_Controller getDateSubsYear:subs_max_year]];
    [self.dtp_date setDate:default_date];
}
@end