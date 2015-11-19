#import "Global+Controller.h"
#import <Reachability/Reachability.h>
@implementation Global_Controller {
@private
    Global_Variables *gb_variables;
}
+ (bool)isNotNull:(NSString *)value {
    if(value == nil) {
        return NO;
    }
    BOOL is_not_null = YES;
    if([[self trim:value] isEqualToString:@""]) {
        is_not_null = NO;
    }
    return is_not_null;
}
+ (bool)isEmail:(NSString *)value {
    if(value == nil) {
        return NO;
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger match = [regex numberOfMatchesInString:value options:0 range:NSMakeRange(0, [value length])];
    if(match == 0) {
        return NO;
    }
    return YES;
}
+ (bool)isLengthValid:(NSString *)value Length:(long)length {
    if(![self isNotNull:value]) {
        return false;
    }
    if([value length] >= length) {
        return true;
    }else {
        return false;
    }
}
+ (NSString *)trim:(NSString *)value {
    return [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
+ (NSString *)format:(double)value {
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setGroupingSeparator:@"."];
    [fmt setGroupingSize:3];
    [fmt setUsesGroupingSeparator:YES];
    [fmt setDecimalSeparator:@","];
    [fmt setNumberStyle:NSNumberFormatterDecimalStyle];
    [fmt setMaximumFractionDigits:2];
    return [fmt stringFromNumber:[NSNumber numberWithFloat:value]];
}
+ (UIColor *)hexColor:(NSString *)value {
    unsigned rgb = 0;
    NSScanner *scanner = [NSScanner scannerWithString:value];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgb];
    return [UIColor colorWithRed:((rgb & 0xFF0000) >> 16)/255.0 green:((rgb & 0xFF00) >> 8)/255.0 blue:(rgb & 0xFF)/255.0 alpha:1.0];
}
+ (NSDate *)getDate:(long)timestamp {
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}
+ (NSString *)getDate:(NSDate *)date Format:(NSString *)format {
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:format];
    return [date_formatter stringFromDate:date];
}
+ (NSDate *)getDateFromString:(NSString *)date Format:(NSString *)format {
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:format];
    return [date_formatter dateFromString:date];
}
+ (NSDate *)setDate:(int)year Month:(int)month Day:(int)day {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:day];
    [components setMonth:month];
    [components setYear:year];
    NSDate *date = [[NSDate alloc] initWithTimeInterval:0 sinceDate:[[NSCalendar currentCalendar] dateFromComponents:components]];
    return date;
}
+ (long)getTimestamp:(NSString *)date DateFormat:(NSString *)date_format {
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:date_format];
    NSDate *date_ = [date_formatter dateFromString:date];
    return [date_ timeIntervalSince1970];
}
+ (long)getTimestamp:(NSDate *)date {
    return [date timeIntervalSince1970];
}
+ (double)getCurrentTimestamp {
    return [NSDate timeIntervalSinceReferenceDate];
}
+ (double)getUTCTimestamp {
    return [[NSDate date] timeIntervalSince1970];
}
+ (NSDate *)getDateSubsYear:(int)year {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offset_components = [[NSDateComponents alloc] init];
    [offset_components setYear:(year * -1)];
    return [gregorian dateByAddingComponents:offset_components toDate:[NSDate date] options:0];
}
+ (NSInteger)divideAndRoundUp:(NSInteger)a with:(NSInteger)b {
    if(a % b != 0) {
        return a / b + 1;
    }
    return a / b;
}
+ (NSString *)readDataFromAssets:(NSString *)filename Type:(NSString *)type {
    NSString *file_path = [[NSBundle mainBundle] pathForResource:filename ofType:type];
    return [NSString stringWithContentsOfFile:file_path encoding:NSUTF8StringEncoding error:NULL];
}
+ (bool)isNetworkConnected {
    Reachability *network_reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus network_status = [network_reachability currentReachabilityStatus];
    if(network_status == NotReachable) {
        return false;
    }else {
        return true;
    }
}
+ (NSString *)saveImage:(NSData *)data FileName:(NSString *)file_name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents_directory = [paths objectAtIndex:0];
    NSString *file_path = [documents_directory stringByAppendingPathComponent:file_name];
    [data writeToFile:file_path atomically:NO];
    return file_path;
}
+ (NSData *)getImage:(NSString *)file_name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents_directory = [paths objectAtIndex:0];
    NSString *app_file = [documents_directory stringByAppendingPathComponent:file_name];
    NSData *data = [[NSData alloc] initWithContentsOfFile:app_file];
    return data;
}
+ (NSString *)dictToJSON:(NSDictionary *)data {
    if(data == nil) {
        return @"{}";
    }
    NSError *error;
    NSData *json_data = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
    if(!json_data) {
        return @"{}";
    }else {
        return [[NSString alloc] initWithData:json_data encoding:NSUTF8StringEncoding];
    }
}
+ (NSDictionary *)jsonToDict:(NSString *)data {
    NSData *object = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:object
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
    return json;
}
+ (void)call:(NSString *)number {
    NSString *phone = [@"tel://" stringByAppendingString:number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}
+ (void)openWeb:(NSString *)url {
    NSURL *web = [NSURL URLWithString:url];
    if(![url hasPrefix:@"http"]) {
        web = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"http", url]];
    }
    [[UIApplication sharedApplication] openURL:web];
}
+ (void)focusOnRect:(UIScrollView *)scroll_view
              Frame:(CGRect)rect
     OptionalHeight:(float)height
          OptionalX:(float)x
       Notification:(NSNotification *)note {
    CGRect keyboard_rect = [Global_Controller getKeyboardRect:note];
    [scroll_view setContentOffset:CGPointMake(x, height + rect.origin.y + rect.size.height - keyboard_rect.origin.y) animated:YES];
}
+ (CGRect)getKeyboardRect:(NSNotification *)note {
    NSDictionary *info  = note.userInfo;
    NSValue *value = info[UIKeyboardFrameEndUserInfoKey];
    return [value CGRectValue];
}
+ (void)setSelectedTableViewCell:(UITableViewCell *)cell {
    UIView *custom_color_view = [[UIView alloc] init];
    custom_color_view.backgroundColor = [UIColor colorWithRed:242.0f/255.0f green:103.f/255.0f blue:23.0f/255.0f alpha:.5f];
    cell.selectedBackgroundView = custom_color_view;
}
+ (void)setDefaultBacgroundWithLogo:(UINavigationController *)navigation_controller {
    [Global_Controller removeAllViews:navigation_controller];
    UIImageView *img_view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-Logo"]];
    img_view.frame = CGRectMake(0, 5, navigation_controller.navigationBar.frame.size.width, navigation_controller.navigationBar.frame.size.height - 10);
    img_view.contentMode = UIViewContentModeScaleAspectFit;
    img_view.tag = 1001;
    [navigation_controller.navigationBar addSubview:img_view];
}
+ (void)removeAllViews:(UINavigationController *)navigation_controller {
    for(UIView *view in [navigation_controller.navigationBar subviews]) {
        if([view isKindOfClass:[UIImageView class]]) {
            UIImageView *img = (UIImageView *)view;
            if(img.tag == 1001) {
                [view removeFromSuperview];
            }
        }
    }
}
+ (void)setChildBackground:(UINavigationController *)navigation_controller {
    [Global_Controller removeAllViews:navigation_controller];
    [navigation_controller.navigationBar setTranslucent:NO];
    [navigation_controller.navigationBar setBackgroundImage:[Global_Controller imageFromColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
    navigation_controller.navigationBar.titleTextAttributes =
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold"
                                          size:20.0]};
}
+ (void)setDefaultBackButton:(UIViewController *)view_controller Action:(SEL)action {
    UIButton *left_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [left_button setFrame:BACK_BUTTON_WIDTH];
    [left_button setImage:[UIImage imageNamed:@"button+back+navigation"] forState:UIControlStateNormal];
    [left_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [left_button addTarget:view_controller action:action forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:left_button];
    view_controller.navigationItem.leftBarButtonItem = left;
}
+ (void)setDefaultBackButton:(UIViewController *)view_controller Default:(id)default_controller Action:(SEL)action {
    UIButton *left_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [left_button setFrame:BACK_BUTTON_WIDTH];
    [left_button setImage:[UIImage imageNamed:@"button+back+navigation"] forState:UIControlStateNormal];
    [left_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [left_button addTarget:default_controller action:action forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:left_button];
    view_controller.navigationItem.leftBarButtonItem = left;
}
+ (void)setDefaultCloseButton:(UIViewController *)view_controller Action:(SEL)action {
    UIButton *left_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [left_button setFrame:BACK_BUTTON_WIDTH];
    [left_button setImage:[UIImage imageNamed:@"button+close"] forState:UIControlStateNormal];
    [left_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [left_button addTarget:view_controller action:action forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:left_button];
    view_controller.navigationItem.leftBarButtonItem = left;
}
+ (void)setDefaultCloseButton:(UIViewController *)view_controller Default:(id)default_controller Action:(SEL)action {
    UIButton *left_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [left_button setFrame:BACK_BUTTON_WIDTH];
    [left_button setImage:[UIImage imageNamed:@"button+close"] forState:UIControlStateNormal];
    [left_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [left_button addTarget:default_controller action:action forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:left_button];
    view_controller.navigationItem.leftBarButtonItem = left;
}
+ (void)setImageLeftButton:(UIViewController *)view_controller ImageNamed:(NSString *)name Title:(NSString *)title Action:(SEL)action {
    UIButton *left_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [left_button setFrame:CGRectMake(0.0f, 0.0f, 27.0f, 27.0f)];
    [left_button setTitle:title forState:UIControlStateNormal];
    [left_button addTarget:view_controller action:action forControlEvents:UIControlEventTouchUpInside];
    [left_button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    left_button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [left_button sizeToFit];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:left_button];
    view_controller.navigationItem.leftBarButtonItem = left;
}
+ (void)setImageLeftButton:(UIView *)view NavigationItem:(UINavigationItem *)nav_item ImageNamed:(NSString *)name Title:(NSString *)title Action:(SEL)action {
    UIButton *left_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [left_button setFrame:CGRectMake(0.0f, 0.0f, 27.0f, 27.0f)];
    [left_button setTitle:title forState:UIControlStateNormal];
    [left_button addTarget:view action:action forControlEvents:UIControlEventTouchUpInside];
    [left_button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [left_button sizeToFit];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:left_button];
    nav_item.leftBarButtonItem = left;
}
+ (void)setImageRightButton:(UIViewController *)view_controller ImageNamed:(NSString *)name Title:(NSString *)title Action:(SEL)action {
    UIButton *right_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [right_button setFrame:CGRectMake(0.0f, 0.0f, 27.0f, 27.0f)];
    [right_button setTitle:title forState:UIControlStateNormal];
    [right_button addTarget:view_controller action:action forControlEvents:UIControlEventTouchUpInside];
    [right_button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [right_button sizeToFit];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:right_button];
    view_controller.navigationItem.rightBarButtonItem = right;
}
+ (void)setImageRightButton:(UIView *)view NavigationItem:(UINavigationItem *)nav_item ImageNamed:(NSString *)name Title:(NSString *)title Action:(SEL)action {
    UIButton *right_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [right_button setFrame:CGRectMake(0.0f, 0.0f, 27.0f, 27.0f)];
    [right_button setTitle:title forState:UIControlStateNormal];
    [right_button addTarget:view action:action forControlEvents:UIControlEventTouchUpInside];
    [right_button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [right_button sizeToFit];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:right_button];
    nav_item.rightBarButtonItem = right;
}
+ (void)setImageRightButton:(UIViewController *)view_controller View:(UIView *)view {
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:view];
    view_controller.navigationItem.rightBarButtonItem = right;
}
+ (void)setListBackground:(UITableView *)lst_table {
    UIImageView *img_view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bg-List"]];
    [img_view setFrame:lst_table.frame];
    lst_table.backgroundView = img_view;
}
+ (void)setSelectedCell:(UITableViewCell *)cell
                  Color:(UIColor *)color {
    UIView *custom_color_view = [[UIView alloc]initWithFrame:cell.bounds];
    custom_color_view.backgroundColor = color;
    cell.selectedBackgroundView = custom_color_view;
}
+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (bool)isPushNotificationOn {
    return ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]);
}
+ (void)getContentLength:(NSString *)url
                Complete:(void (^)(long long))completeHandler {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"HEAD";
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    request.timeoutInterval = 10.0;
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
    completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSDictionary *dictionary = [(NSHTTPURLResponse *)response allHeaderFields];
        if([dictionary objectForKey:@"Content-Length"] != nil) {
            long long content_length = [[dictionary objectForKey:@"Content-Length"] longLongValue];
            completeHandler(content_length);
        }else {
            completeHandler(0);
        }
    }];
}
@end
@implementation UIView (a)
- (void)rounded {
    CALayer * l = [self layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:5];
}
- (void)stroke {
    [self stroke:1.0f];
}
- (void)stroke:(float)width {
    [[self layer] setBorderWidth:1.0f];
    [[self layer] setBorderColor:[UIColor blackColor].CGColor];
}
@end
@implementation UIImage (a)
+ (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size,NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
@implementation UITextField (a)
- (void)changePlaceHolderColor:(UIColor *)color {
    if([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.attributedPlaceholder.string attributes:@{NSForegroundColorAttributeName:color}];
    }
}
@end