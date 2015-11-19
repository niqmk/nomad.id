#import "Layout+Controller.h"
#import "Home+Potrait+View.h"
#import "Home+Landscape+View.h"
#import "Home+Landscape+2+View.h"
#import "Layout+Config.h"
@implementation Layout_Controller
//Info
NSString *const info_genre = @"genre";
NSString *const info_release = @"release";
NSString *const info_director = @"director";
NSString *const info_cast = @"cast";
NSString *const info_runtime = @"runtime";
NSString *const info_language = @"language";
NSString *const info_subtitle = @"subtitle";
+ (UIView *)getLayout:(NSString *)key
                Width:(float)width
             Delegate:(id<Home_View_Delegate>)delegate {
    Home_View *home_view = [[Home_View alloc] init];
    home_view.delegate = delegate;
    if([key isEqualToString:home_popular]) {
        [home_view show:width];
    }else {
        [home_view showWoSlider:key Width:width];
    }
    return home_view;
}
+ (UIView *)getDetailMovieLayout:(NSString *)key
                          Detail:(Movie_Detail_Model *)movie_detail_model
                           Width:(float)width
                  DetailDelegate:(id<Detail_Movie_View_Delegate>)detail_delegate
                  ReviewDelegate:(id<Review_Movie_View_Delegate>)review_delegate
                 RelatedDelegate:(id<Related_Movie_View_Delegate>)related_delegate {
    if([key isEqualToString:detail_details]) {
        Detail_Movie_View *detail_movie_view = [[Detail_Movie_View alloc] init];
        detail_movie_view.delegate = detail_delegate;
        [detail_movie_view show:movie_detail_model
                          Width:width];
        return detail_movie_view;
    }else if([key isEqualToString:detail_reviews]) {
        Review_Movie_View *review_movie_view = [[Review_Movie_View alloc] init];
        review_movie_view.delegate = review_delegate;
        [review_movie_view show:movie_detail_model
                          Width:width];
        return review_movie_view;
    }else if([key isEqualToString:detail_relateds]) {
        Related_Movie_View *related_movie_view = [[Related_Movie_View alloc] init];
        related_movie_view.delegate = related_delegate;
        [related_movie_view show:movie_detail_model
                           Width:width];
        return related_movie_view;
    }
    return nil;
}
+ (UIView *)getDetailSerialLayout:(NSString *)key
                           Detail:(Serial_Detail_Model *)serial_detail_model
                            Width:(float)width DetailDelegate:(id<Detail_Serial_View_Delegate>)detail_delegate
                   ReviewDelegate:(id<Comment_Serial_View_Delegate>)review_delegate
                  RelatedDelegate:(id<Related_Serial_View_Delegate>)related_delegate {
    if([key isEqualToString:detail_details]) {
        Detail_Serial_View *detail_serial_view = [[Detail_Serial_View alloc] init];
        detail_serial_view.delegate = detail_delegate;
        [detail_serial_view show:serial_detail_model
                           Width:width];
        return detail_serial_view;
    }else if([key isEqualToString:detail_comments]) {
        Comment_Serial_View *comment_serial_view = [[Comment_Serial_View alloc] init];
        comment_serial_view.delegate = review_delegate;
        [comment_serial_view show:serial_detail_model
                            Width:width];
        return comment_serial_view;
    }else if([key isEqualToString:detail_relateds]) {
        Related_Serial_View *related_serial_view = [[Related_Serial_View alloc] init];
        related_serial_view.delegate = related_delegate;
        [related_serial_view show:serial_detail_model
                            Width:width];
        return related_serial_view;
    }
    return nil;
}
+ (UIView *)getInfoLayout:(Movie_Detail_Model *)movie_detail_model
                    Width:(float)width
                     Font:(UIFont *)font {
    UIView *layout = [[UIView alloc] init];
    NSMutableDictionary *info_list = [Layout_Controller getInfoList];
    float y = 8;
    for(NSString *key in info_list) {
        UILabel *lbl_key = [[UILabel alloc] initWithFrame:CGRectMake(8, y, width / 3, 0)];
        UILabel *lbl_separator = [[UILabel alloc] initWithFrame:CGRectMake((width / 3) + 10, y, 3, 0)];
        UILabel *lbl_value = [[UILabel alloc] initWithFrame:CGRectMake((width / 3) + 15, y, width - ((width / 3) + 15), 0)];
        lbl_value.numberOfLines = 0;
        [lbl_key setFont:font];
        [lbl_value setFont:font];
        [lbl_separator setFont:font];
        [lbl_key setText:[info_list objectForKey:key]];
        [lbl_separator setText:@":"];
        if([key isEqualToString:info_genre]) {
            NSString *value = text_blank;
            for(Movie_Genre_Model *each in movie_detail_model.genres) {
                value = [value stringByAppendingString:[NSString stringWithFormat:@"%@, ", each.name]];
            }
            if([Global_Controller isNotNull:value]) {
                value = [value substringWithRange:NSMakeRange(0, [value length] - 2)];
            }
            [lbl_value setText:[NSString stringWithFormat:@"%@", value]];
        }else if([key isEqualToString:info_release]) {
            [lbl_value setText:[NSString stringWithFormat:@"%@", movie_detail_model.release_date]];
        }else if([key isEqualToString:info_director]) {
            NSString *value = text_blank;
            for(Movie_Director_Model *each in movie_detail_model.directors) {
                value = [value stringByAppendingString:[NSString stringWithFormat:@"%@, ", each.name]];
            }
            if([Global_Controller isNotNull:value]) {
                value = [value substringWithRange:NSMakeRange(0, [value length] - 2)];
            }
            [lbl_value setText:[NSString stringWithFormat:@"%@", value]];
        }else if([key isEqualToString:info_cast]) {
            NSString *value = text_blank;
            for(Movie_Cast_Model *each in movie_detail_model.casts) {
                value = [value stringByAppendingString:[NSString stringWithFormat:@"%@, ", each.name]];
            }
            if([Global_Controller isNotNull:value]) {
                value = [value substringWithRange:NSMakeRange(0, [value length] - 2)];
            }
            [lbl_value setText:[NSString stringWithFormat:@"%@", value]];
        }else if([key isEqualToString:info_runtime]) {
            [lbl_value setText:[NSString stringWithFormat:@"%ld menit", movie_detail_model.run_time_in_minute]];
        }else if([key isEqualToString:info_language]) {
            [lbl_value setText:[NSString stringWithFormat:@"%@", movie_detail_model.languages]];
        }else if([key isEqualToString:info_subtitle]) {
            [lbl_value setText:[NSString stringWithFormat:@"%@", movie_detail_model.subtitles]];
        }
        [lbl_key sizeToFit];
        [lbl_separator sizeToFit];
        [lbl_value sizeToFit];
        [layout addSubview:lbl_key];
        [layout addSubview:lbl_separator];
        [layout addSubview:lbl_value];
        if([Global_Controller isNotNull:lbl_value.text]) {
            y += lbl_value.frame.size.height + 5;
        }else {
            y += lbl_key.frame.size.height + 5;
        }
    }
    layout.frame = CGRectMake(0, 0, width, y);
    return layout;
}
- (NSMutableArray *)getHomeLayout:(NSString *)key
                            Width:(float)width
                         Delegate:(id<Layout_Controller_Delegate>)delegate {
    NSMutableArray *layout = [[NSMutableArray alloc] init];
    NSMutableDictionary *layout_list = [Layout_Controller getHomeList:key];
    for(NSDictionary *each in layout_list) {
        if([[each objectForKey:@"Type"] isEqualToString:layout_potrait]) {
            [layout
             addObject:[Layout_Controller getHomePotraitLayout:[each objectForKey:@"Name"]
                                                           URL:[each objectForKey:@"URL"]
                                                     VideoType:[[each objectForKey:@"VideoType"] intValue]
                                                         Width:width
                                                      Delegate:delegate]];
        }else if([[each objectForKey:@"Type"] isEqualToString:layout_landscape]) {
            [layout
             addObject:[Layout_Controller getHomeLandscapeLayout:[each objectForKey:@"Name"]
                                                             URL:[each objectForKey:@"URL"]
                                                       VideoType:[[each objectForKey:@"VideoType"] intValue]
                                                           Width:width
                                                        Delegate:delegate]];
        }else if([[each objectForKey:@"Type"] isEqualToString:layout_landscape_2]) {
            [layout
             addObject:[Layout_Controller getHomeLandscape2Layout:[each objectForKey:@"Name"]
                                                              URL:[each objectForKey:@"URL"]
                                                        VideoType:[[each objectForKey:@"VideoType"] intValue]
                                                            Width:width
                                                         Delegate:delegate]];
        }
    }
    return layout;
}
+ (NSMutableDictionary *)getHomeList:(NSString *)key {
    Global_Variables *gb_variables = [Global_Variables instance];
    return [gb_variables->layout_plist valueForKey:key];
}
+ (NSMutableDictionary *)getInfoList {
    Global_Variables *gb_variables = [Global_Variables instance];
    return [gb_variables->layout_plist valueForKey:@"Info"];
}
+ (UIView *)getHomePotraitLayout:(NSString *)title
                             URL:(NSString *)url
                       VideoType:(VideoType)video_type
                           Width:(float)width
                        Delegate:(id<Layout_Controller_Delegate>)delegate {
    Home_Potrait_View *home_potrait_view = [[Home_Potrait_View alloc] init];
    home_potrait_view.layout_controller_delegate = delegate;
    [home_potrait_view show:title
                        Url:url
                  VideoType:video_type];
    return home_potrait_view;
}
+ (UIView *)getHomeLandscapeLayout:(NSString *)title
                               URL:(NSString *)url
                         VideoType:(VideoType)video_type
                             Width:(float)width
                          Delegate:(id<Layout_Controller_Delegate>)delegate {
    Home_Landscape_View *home_landscape_view = [[Home_Landscape_View alloc] init];
    home_landscape_view.layout_controller_delegate = delegate;
    [home_landscape_view show:title
                          Url:url
                    VideoType:video_type];
    return home_landscape_view;
}
+ (UIView *)getHomeLandscape2Layout:(NSString *)title
                                URL:(NSString *)url
                          VideoType:(VideoType)video_type
                              Width:(float)width
                           Delegate:(id<Layout_Controller_Delegate>)delegate {
    Home_Landscape_2_View *home_landscape_2_view = [[Home_Landscape_2_View alloc] init];
    home_landscape_2_view.layout_controller_delegate = delegate;
    [home_landscape_2_view show:title
                            Url:url
                      VideoType:video_type];
    return home_landscape_2_view;
}
@end