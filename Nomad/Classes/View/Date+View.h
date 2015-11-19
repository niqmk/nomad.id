@protocol DateViewDelegate <NSObject>
- (void)didDateViewCancel;
- (void)didDateViewSelected:(long)timestamp;
@end
@interface Date_View : UIView
@property (nonatomic, strong) id<DateViewDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIScrollView *scv_main;
@property (nonatomic, strong) IBOutlet UIView *vw_layout;
@property (nonatomic, strong) IBOutlet UIDatePicker *dtp_date;
- (void)open:(NSDate *)default_date SubsMinYear:(int)subs_min_year SubsMaxYear:(int)subs_max_year;
@end