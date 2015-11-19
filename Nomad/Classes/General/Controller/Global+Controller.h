@interface Global_Controller : NSObject
+ (bool)isNotNull:(NSString *)value;
+ (bool)isEmail:(NSString *)value;
+ (bool)isLengthValid:(NSString *)value Length:(long)length;
+ (NSString *)trim:(NSString *)value;
+ (NSString *)format:(double)value;
+ (UIColor *)hexColor:(NSString *)value;
+ (NSDate *)getDate:(long)timestamp;
+ (NSString *)getDate:(NSDate *)date Format:(NSString *)format;
+ (NSDate *)getDateFromString:(NSString *)date Format:(NSString *)format;
+ (NSDate *)setDate:(int)year Month:(int)month Day:(int)day;
+ (long)getTimestamp:(NSString *)date DateFormat:(NSString *)date_format;
+ (long)getTimestamp:(NSDate *)date;
+ (double)getCurrentTimestamp;
+ (double)getUTCTimestamp;
+ (NSDate *)getDateSubsYear:(int)year;
+ (NSInteger)divideAndRoundUp:(NSInteger)a with:(NSInteger)b;
+ (NSString *)readDataFromAssets:(NSString *)filename Type:(NSString *)type;
+ (bool)isNetworkConnected;
+ (NSString *)saveImage:(NSData *)data FileName:(NSString *)file_name;
+ (NSData *)getImage:(NSString *)file_name;
+ (NSString *)dictToJSON:(NSDictionary *)data;
+ (NSDictionary *)jsonToDict:(NSString *)data;
+ (void)call:(NSString *)number;
+ (void)openWeb:(NSString *)url;
+ (void)focusOnRect:(UIScrollView *)scroll_view
              Frame:(CGRect)rect
     OptionalHeight:(float)height
          OptionalX:(float)x
       Notification:(NSNotification *)note;
+ (CGRect)getKeyboardRect:(NSNotification *)note;
+ (void)setSelectedTableViewCell:(UITableViewCell *)cell;
+ (void)setDefaultBacgroundWithLogo:(UINavigationController *)navigation_controller;
+ (void)removeAllViews:(UINavigationController *)navigation_controller;
+ (void)setChildBackground:(UINavigationController *)navigation_controller;
+ (void)setDefaultBackButton:(UIViewController *)view_controller Action:(SEL)action;
+ (void)setDefaultBackButton:(UIViewController *)view_controller Default:(id)default_controller Action:(SEL)action;
+ (void)setDefaultCloseButton:(UIViewController *)view_controller Action:(SEL)action;
+ (void)setDefaultCloseButton:(UIViewController *)view_controller Default:(id)default_controller Action:(SEL)action;
+ (void)setImageLeftButton:(UIViewController *)view_controller ImageNamed:(NSString *)name Title:(NSString *)title Action:(SEL)action;
+ (void)setImageLeftButton:(UIView *)view NavigationItem:(UINavigationItem *)nav_item ImageNamed:(NSString *)name Title:(NSString *)title Action:(SEL)action;
+ (void)setImageRightButton:(UIViewController *)view_controller ImageNamed:(NSString *)name Title:(NSString *)title Action:(SEL)action;
+ (void)setImageRightButton:(UIView *)view NavigationItem:(UINavigationItem *)nav_item ImageNamed:(NSString *)name Title:(NSString *)title Action:(SEL)action;
+ (void)setImageRightButton:(UIViewController *)view_controller View:(UIView *)view;
+ (void)setListBackground:(UITableView *)lst_table;
+ (void)setSelectedCell:(UITableViewCell *)cell
                  Color:(UIColor *)color;
+ (UIImage *)imageFromColor:(UIColor *)color;
+ (bool)isPushNotificationOn;
+ (void)getContentLength:(NSString *)url
                Complete:(void (^)(long long size))completeHandler;
@end
@interface UIView (a)
- (void)rounded;
- (void)stroke;
- (void)stroke:(float)width;
@end
@interface UIImage (a)
+ (UIImage *)imageWithView:(UIView *)view;
@end
@interface UITextField (a)
- (void)changePlaceHolderColor:(UIColor *)color;
@end