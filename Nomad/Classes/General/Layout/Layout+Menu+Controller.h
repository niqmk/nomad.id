#import "Home+Menu+View.h"
@protocol Layout_Menu_Controller_Delegate
@optional
- (void)didLayoutMenuPotraitSelected:(id)model;
- (void)didLayoutMenuLandscapeSelected:(id)model;
@end
@interface Layout_Menu_Controller : NSObject
+ (UIView *)getLayout:(NSString *)key
           CategoryID:(long)category_id
            VideoType:(VideoType)video_type
                Width:(float)width
             Delegate:(id<Home_Menu_View_Delegate>)delegate;
- (NSMutableArray *)getHomeLayout:(NSString *)key
                       CategoryID:(long)category_id
                        VideoType:(VideoType)video_type
                            Width:(float)width
                         Delegate:(id<Layout_Menu_Controller_Delegate>)delegate;
@end