#import "Home+View.h"
#import "Detail+Movie+View.h"
#import "Review+Movie+View.h"
#import "Related+Movie+View.h"
#import "Detail+Serial+View.h"
#import "Comment+Serial+View.h"
#import "Related+Serial+View.h"
@protocol Layout_Controller_Delegate
@optional
- (void)didLayoutPotraitSelected:(id)model;
- (void)didLayoutLandscapeSelected:(id)model;
@end
@interface Layout_Controller : NSObject
//Info
extern NSString *const info_genre;
extern NSString *const info_release;
extern NSString *const info_director;
extern NSString *const info_cast;
extern NSString *const info_runtime;
extern NSString *const info_language;
extern NSString *const info_subtitle;
+ (UIView *)getLayout:(NSString *)key
                Width:(float)width
             Delegate:(id<Home_View_Delegate>)delegate;
+ (UIView *)getDetailMovieLayout:(NSString *)key
                          Detail:(Movie_Detail_Model *)movie_detail_model
                           Width:(float)width
                  DetailDelegate:(id<Detail_Movie_View_Delegate>)detail_delegate
                  ReviewDelegate:(id<Review_Movie_View_Delegate>)review_delegate
                 RelatedDelegate:(id<Related_Movie_View_Delegate>)related_delegate;
+ (UIView *)getDetailSerialLayout:(NSString *)key
                           Detail:(Serial_Detail_Model *)serial_detail_model
                            Width:(float)width
                   DetailDelegate:(id<Detail_Serial_View_Delegate>)detail_delegate
                   ReviewDelegate:(id<Comment_Serial_View_Delegate>)review_delegate
                  RelatedDelegate:(id<Related_Serial_View_Delegate>)related_delegate;
+ (UIView *)getInfoLayout:(Movie_Detail_Model *)movie_detail_model
                    Width:(float)width
                     Font:(UIFont *)font;
- (NSMutableArray *)getHomeLayout:(NSString *)key
                            Width:(float)width
                         Delegate:(id<Layout_Controller_Delegate>)delegate;
@end