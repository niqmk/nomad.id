#import "Layout+Menu+Controller.h"
#import "Home+Potrait+2+View.h"
#import "Home+Landscape+3+View.h"
#import "Layout+Config.h"
@implementation Layout_Menu_Controller
+ (UIView *)getLayout:(NSString *)key
           CategoryID:(long)category_id
            VideoType:(VideoType)video_type
                Width:(float)width
             Delegate:(id<Home_Menu_View_Delegate>)delegate {
    Home_Menu_View *home_menu_view = [[Home_Menu_View alloc] init];
    home_menu_view.delegate = delegate;
    [home_menu_view show:key
              CategoryID:category_id
               VideoType:video_type
                   Width:width];
    return home_menu_view;
}
- (NSMutableArray *)getHomeLayout:(NSString *)key
                       CategoryID:(long)category_id
                        VideoType:(VideoType)video_type
                            Width:(float)width
                         Delegate:(id<Layout_Menu_Controller_Delegate>)delegate {
    NSMutableArray *layout = [[NSMutableArray alloc] init];
    NSMutableDictionary *layout_list = [Layout_Menu_Controller getHomeList:key
                                                                 VideoType:video_type];
    if([[layout_list objectForKey:@"Type"] isEqualToString:layout_potrait_2]) {
        [layout
         addObject:[Layout_Menu_Controller getHomePotrait2Layout:key
                                                      CategoryID:category_id
                                                             URL:[layout_list objectForKey:@"URL"]
                                                       VideoType:video_type
                                                           Width:width
                                                        Delegate:delegate]];
    }else if([[layout_list objectForKey:@"Type"] isEqualToString:layout_landscape_3]) {
        [layout
         addObject:[Layout_Menu_Controller getHomeLandscape3Layout:key
                                                        CategoryID:category_id
                                                               URL:[layout_list objectForKey:@"URL"]
                                                         VideoType:video_type
                                                             Width:width
                                                          Delegate:delegate]];
    }
    return layout;
}
+ (NSMutableDictionary *)getHomeList:(NSString *)key
                           VideoType:(VideoType)video_type {
    Global_Variables *gb_variables = [Global_Variables instance];
    return [gb_variables->layout_plist valueForKey:[NSString stringWithFormat:@"%@-%d", key, video_type]];
}
+ (UIView *)getHomePotrait2Layout:(NSString *)key
                       CategoryID:(long)category_id
                              URL:(NSString *)url
                        VideoType:(VideoType)video_type
                            Width:(float)width
                         Delegate:(id<Layout_Menu_Controller_Delegate>)delegate {
    Home_Potrait_2_View *home_potrait_2_view = [[Home_Potrait_2_View alloc] init];
    home_potrait_2_view.layout_menu_controller_delegate = delegate;
    [home_potrait_2_view show:key
                   CategoryID:category_id
                          URL:url
                    VideoType:video_type
                        Width:width];
    return home_potrait_2_view;
}
+ (UIView *)getHomeLandscape3Layout:(NSString *)key
                         CategoryID:(long)category_id
                                URL:(NSString *)url
                          VideoType:(VideoType)video_type
                              Width:(float)width
                           Delegate:(id<Layout_Menu_Controller_Delegate>)delegate {
    Home_Landscape_3_View *home_landscape_3_view = [[Home_Landscape_3_View alloc] init];
    home_landscape_3_view.layout_menu_controller_delegate = delegate;
    [home_landscape_3_view show:key
                     CategoryID:category_id
                            URL:url
                      VideoType:video_type
                          Width:width];
    return home_landscape_3_view;
}
@end