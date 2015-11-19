#import "Date+View.h"
@protocol DateDelegate <NSObject>
- (void)didDateCancel;
- (void)didDateSelected:(long)timestamp;
@end
@interface Date_Controller : NSObject <DateViewDelegate> {
@private
    Date_View *date_view;
    id<DateDelegate> delegate;
}
- (id)init:(id<DateDelegate>)d;
- (void)open:(NSDate *)default_date
 SubsMinYear:(int)subs_min_year
 SubsMaxYear:(int)subs_max_year;
@end