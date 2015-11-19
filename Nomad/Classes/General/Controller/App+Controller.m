#import "App+Controller.h"
#import <MMDrawerController/MMDrawerController.h>
#import "AppDelegate.h"
#import "Nav+Controller.h"
#import "Credential+Controller.h"
#import "Home+Menu+Controller.h"
#import "Download+List+Controller.h"
#import "Video+Player+Controller.h"
#import "Point+Controller.h"
#import "Loading+Controller.h"
#import "Modal+Controller.h"
#import "File+Controller.h"
#import "Secure+Controller.h"
#import "URL+Manager.h"
#import "Movie+Detail+Model.h"
#import "Serial+Detail+Model.h"
@implementation App_Controller
static __strong Credential_Controller *credential_controller;
static __strong Home_Menu_Controller *home_menu_controller;
static __strong Download_List_Controller *download_list_controller;
static __strong Video_Player_Controller *video_player_controller;
static __strong Point_Controller *point_controller;
static __strong NSNotificationCenter *nc;
static Alert_Controller *alert_controller;
static Loading_Controller *loading_controller;
static Price_View *price_view;
static Video_Profile_View *video_profile_view;
static Member_Review_View *member_review_view;
static Member_Comment_View *member_comment_view;
+ (void)clearSession {
    [[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]];
    AppDelegate *app_delegate = (((AppDelegate *)[UIApplication sharedApplication].delegate));
    [app_delegate checkSession];
}
+ (NSDictionary *)getHeaders {
    Global_Variables *gb_variables = [Global_Variables instance];
    if([gb_variables->user_session isSession]) {
        NSMutableDictionary *headers = [[NSMutableDictionary alloc] init];
        [headers setObject:[[gb_variables->user_session getUser] auth_token] forKey:@"auth_token"];
        return [NSDictionary dictionaryWithDictionary:headers];;
    }
    return nil;
}
+ (void)getMe:(void (^)(Me_Model *))completeHandler
       Failed:(void (^)(NSString *))failedHandler
        Error:(void (^)())errorHandler {
    [URL_Manager Me:^(Me_Model *me_model) {
        if(completeHandler) {
            completeHandler(me_model);
        }
    } Failed:^(NSString *message) {
        if(failedHandler) {
            failedHandler(message);
        }
    } Expired:^{
        [App_Controller clearSession];
    } Error:^(NSInteger status_code, NSDictionary *response) {
        if(errorHandler) {
            errorHandler();
        }
    }];
}
+ (void)refreshMe {
    Global_Variables *gb_variables = [Global_Variables instance];
    if([gb_variables->user_session isSession]) {
        [App_Controller getMe:^(Me_Model *me_model) {
            [gb_variables->user_session updatePoint:me_model.total_points];
        } Failed:nil Error:nil];
    }
}
+ (VideoType)getVideoType:(id)model {
    if([model isKindOfClass:[Movie_Detail_Model class]]) {
        return MovieVideoType;
    }else if([model isKindOfClass:[Serial_Detail_Model class]]) {
        return SerialVideoType;
    }
    return NoneVideoType;
}
+ (Video_Player_Model *)generateVideoPlayerData:(NSString *)filename
                                      VideoType:(VideoType)video_type
                                          Title:(NSString *)title
                                            URL:(NSString *)url {
    Video_Player_Model *video_player_model =
        [Video_Player_Model init:[Global_Controller getUTCTimestamp]
                       VideoType:video_type
                           Title:title
                            Path:[File_Controller getPath:filename]
                        Filename:filename
                             URL:[Secure_Controller encrypt:url]];
    return video_player_model;
}
+ (void)showNotification:(NSString *)message {
    UILocalNotification *local_notification = [[UILocalNotification alloc] init];
    local_notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
    local_notification.alertBody = message;
    local_notification.alertAction = [App_Controller getTitle:@"title_app"];
    local_notification.soundName =  UILocalNotificationDefaultSoundName;
    local_notification.timeZone = [NSTimeZone defaultTimeZone];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:message forKey:@"message"];
    [local_notification setUserInfo:dictionary];
    [[UIApplication sharedApplication] scheduleLocalNotification:local_notification];
}
+ (void)showAlert:(NSString *)title
          Message:(NSString *)message
         Delegate:(id<Alert_Delegate>)delegate {
    if(alert_controller == nil) {
        alert_controller = [[Alert_Controller alloc] init];
    }
    if(![alert_controller isClosed]) {
        [alert_controller close];
    }
    [alert_controller showAlert:title
                        Message:message
                       Delegate:delegate];
}
+ (void)showQuestion:(NSString *)title
             Message:(NSString *)message
            Delegate:(id<Alert_Delegate>)delegate {
    if(alert_controller == nil) {
        alert_controller = [[Alert_Controller alloc] init];
    }
    if(![alert_controller isClosed]) {
        [alert_controller close];
    }
    [alert_controller showQuestion:title
                           Message:message
                          Delegate:delegate];
}
+ (void)showLoading:(UIViewController *)view_controller {
    [App_Controller showLoading:view_controller
                        Message:[App_Controller getMessage:@"message_loading"]
                     Cancelable:false];
}
+ (void)showLoading:(UIViewController *)view_controller
            Message:(NSString *)message
         Cancelable:(bool)cancelable {
    if(loading_controller == nil) {
        loading_controller = [[Loading_Controller alloc] init];
    }
    if(![loading_controller isClosed]) {
        [loading_controller close];
    }
    [loading_controller show:view_controller
                     Message:message
                  Cancelable:cancelable];
}
+ (void)closeLoading {
    if(loading_controller == nil) {
        return;
    }
    [loading_controller close];
}
+ (void)addKeyboardListen:(id)observer
           onKeyboardShow:(SEL)keyboard_show_selector
           onKeyboardHide:(SEL)keyboard_hide_selector {
    nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:observer selector:keyboard_show_selector name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:observer selector:keyboard_hide_selector name:UIKeyboardWillHideNotification object:nil];
}
+ (void)removeKeyboardListen:(id)observer {
    if(nc == nil) {
        return;
    }
    [nc removeObserver:observer name:UIKeyboardWillShowNotification object:nil];
    [nc removeObserver:observer name:UIKeyboardWillHideNotification object:nil];
}
+ (void)showPrice:(UIViewController *)view_controller
             List:(NSMutableArray *)list
         Delegate:(id<Price_View_Delegate>)delegate {
    price_view = [[Price_View alloc] init];
    price_view.frame = view_controller.view.bounds;
    [price_view show:view_controller
                List:list
            Delegate:delegate];
    [Modal_Controller show:view_controller
                      View:price_view];
}
+ (void)showVideoProfile:(UIViewController *)view_controller
                    Data:(NSDictionary *)data
                Delegate:(id<Video_Profile_View_Delegate>)delegate {
    video_profile_view = [[Video_Profile_View alloc] init];
    video_profile_view.frame = view_controller.view.bounds;
    [video_profile_view show:view_controller
                        Data:data
                    Delegate:delegate];
    [Modal_Controller show:view_controller
                      View:video_profile_view];
}
+ (void)showMemberReview:(UIViewController *)view_controller
                      ID:(long)id
                  Review:(Member_Comment_Model *)member_comment_model
                Delegate:(id<Member_Review_View_Delegate>)delegate {
    member_review_view = [[Member_Review_View alloc] init];
    member_review_view.frame = view_controller.view.bounds;
    [member_review_view show:view_controller
                          ID:id
                      Review:member_comment_model
                    Delegate:delegate];
    [Modal_Controller show:view_controller
                      View:member_review_view];
}
+ (void)showMemberComment:(UIViewController *)view_controller
                       ID:(long)id
                 Delegate:(id<Member_Comment_View_Delegate>)delegate {
    member_comment_view = [[Member_Comment_View alloc] init];
    member_comment_view.frame = view_controller.view.bounds;
    [member_comment_view show:view_controller
                           ID:id
                     Delegate:delegate];
    [Modal_Controller show:view_controller
                      View:member_comment_view];
}
+ (void)openLandController {
    AppDelegate *app_delegate = (((AppDelegate *)[UIApplication sharedApplication].delegate));
    [app_delegate openLandController:false];
}
+ (void)openHomeController {
    AppDelegate *app_delegate = (((AppDelegate *)[UIApplication sharedApplication].delegate));
    [app_delegate openHomeController];
}
+ (void)openHome:(UIViewController *)view_controller {
    MMDrawerController *drawer_controller = (MMDrawerController *)view_controller.parentViewController;
    [drawer_controller closeDrawerAnimated:true completion:^(BOOL finished) {
        if(finished) {
            AppDelegate *app_delegate = (((AppDelegate *)[UIApplication sharedApplication].delegate));
            [app_delegate openHome];
        }
    }];
}
+ (void)openHome:(UIViewController *)view_controller
       VideoType:(VideoType)type
              ID:(long)id {
    home_menu_controller = [[Home_Menu_Controller alloc] initWithNibName:@"Home+Menu+Controller"
                                                                  bundle:nil
                                                               VideoType:type
                                                                      ID:id];
    MMDrawerController *drawer_controller = (MMDrawerController *)view_controller.parentViewController;
    [drawer_controller closeDrawerAnimated:true completion:^(BOOL finished) {
        if(finished) {
            AppDelegate *app_delegate = (((AppDelegate *)[UIApplication sharedApplication].delegate));
            [app_delegate openHome:home_menu_controller];
        }
    }];
}
+ (void)closeModal {
    [Modal_Controller close];
}
#pragma Controller
+ (void)openCredential:(UIViewController *)view_controller {
    credential_controller = [[Credential_Controller alloc] initWithNibName:@"Credential+Controller" bundle:nil];
    [view_controller presentViewController:credential_controller animated:true completion:nil];
}
+ (void)closeCredential:(void (^)())completeHandler {
    if(credential_controller != nil) {
        [credential_controller dismissViewControllerAnimated:true completion:^{
            if(completeHandler != nil) {
                completeHandler();
            }
        }];
        credential_controller = nil;
    }
}
+ (void)openDownloadList:(UIViewController *)menu_controller {
    MMDrawerController *drawer_controller = (MMDrawerController *)menu_controller.parentViewController;
    download_list_controller = [[Download_List_Controller alloc] initWithNibName:@"Download+List+Controller" bundle:nil];
    Nav_Controller *nav_controller = (Nav_Controller *)drawer_controller.centerViewController;
    [drawer_controller closeDrawerAnimated:true completion:^(BOOL finished) {
        if(finished) {
            [nav_controller pushViewController:download_list_controller animated:true];
        }
    }];
}
+ (void)openVideoPlayer:(UIViewController *)view_controller
                  Video:(Video_Player_Model *)video_player_model {
    video_player_controller = [[Video_Player_Controller alloc] initWithNibName:@"Video+Player+Controller" bundle:nil Video:video_player_model];
    [view_controller presentViewController:video_player_controller animated:true completion:nil];
}
+ (void)closeVideoPlayer:(void (^)())completeHandler {
    if(video_player_controller != nil) {
        [video_player_controller dismissViewControllerAnimated:true completion:^{
            if(completeHandler != nil) {
                completeHandler();
            }
        }];
        video_player_controller = nil;
    }
}
+ (void)openPoint:(UIViewController *)menu_controller {
    MMDrawerController *drawer_controller = (MMDrawerController *)menu_controller.parentViewController;
    point_controller = [[Point_Controller alloc] initWithNibName:@"Point+Controller" bundle:nil FromDetail:false];
    Nav_Controller *nav_controller = (Nav_Controller *)drawer_controller.centerViewController;
    [drawer_controller closeDrawerAnimated:true completion:^(BOOL finished) {
        if(finished) {
            [nav_controller pushViewController:point_controller animated:true];
        }
    }];
}
+ (void)openPointNavigation:(UIViewController *)view_controller {
    point_controller = [[Point_Controller alloc] initWithNibName:@"Point+Controller" bundle:nil FromDetail:true];
    [view_controller.navigationController pushViewController:point_controller animated:true];
}
#pragma Session
+ (bool)isSessionHome:(NSString *)url {
    if([url.lowercaseString hasPrefix:@"http://"] || [url.lowercaseString hasPrefix:@"https://"]) {
    }else {
        url = [NSString stringWithFormat:@"%@%@", url_server, url];
    }
    Global_Variables *gb_variables = [Global_Variables instance];
    return [gb_variables->home_session isCached:url];
}
+ (void)setSessionHome:(NSString *)url
                  List:(NSMutableArray *)list {
    if([url.lowercaseString hasPrefix:@"http://"] || [url.lowercaseString hasPrefix:@"https://"]) {
    }else {
        url = [NSString stringWithFormat:@"%@%@", url_server, url];
    }
    Global_Variables *gb_variables = [Global_Variables instance];
    [gb_variables->home_session set:url
                               List:list];
}
+ (NSMutableArray *)getSessionHome:(NSString *)url {
    if([url.lowercaseString hasPrefix:@"http://"] || [url.lowercaseString hasPrefix:@"https://"]) {
    }else {
        url = [NSString stringWithFormat:@"%@%@", url_server, url];
    }
    Global_Variables *gb_variables = [Global_Variables instance];
    return [gb_variables->home_session get:url];
}
#pragma App.plist
+ (NSString *)getTitle:(NSString *)key {
    Global_Variables *gb_variables = [Global_Variables instance];
    return [[gb_variables->app_plist objectForKey:@"Title"] objectForKey:key];
}
+ (NSString *)getMessage:(NSString *)key {
    Global_Variables *gb_variables = [Global_Variables instance];
    return [[gb_variables->app_plist objectForKey:@"Message"] objectForKey:key];
}
+ (NSString *)getLabel:(NSString *)key {
    Global_Variables *gb_variables = [Global_Variables instance];
    return [[gb_variables->app_plist objectForKey:@"Label"] objectForKey:key];
}
+ (NSString *)getError:(NSString *)key {
    Global_Variables *gb_variables = [Global_Variables instance];
    return [[gb_variables->app_plist objectForKey:@"Error"] objectForKey:key];
}
#pragma Menu.plist
+ (NSMutableArray *)getHomeList {
    Global_Variables *gb_variables = [Global_Variables instance];
    return [gb_variables->menu_plist valueForKey:@"Home"];
}
+ (NSMutableArray *)getHomeMenuList:(VideoType)video_type {
    Global_Variables *gb_variables = [Global_Variables instance];
    if(video_type == MovieVideoType) {
        return [gb_variables->menu_plist valueForKey:@"Home-Menu-Movie"];
    }else if(video_type == SerialVideoType) {
        return [gb_variables->menu_plist valueForKey:@"Home-Menu-Serial"];
    }
    return nil;
}
+ (NSMutableArray *)getDetailMovieList {
    Global_Variables *gb_variables = [Global_Variables instance];
    return [gb_variables->menu_plist valueForKey:@"Detail-Movie"];
}
+ (NSMutableArray *)getDetailSerialList {
    Global_Variables *gb_variables = [Global_Variables instance];
    return [gb_variables->menu_plist valueForKey:@"Detail-Serial"];
}
+ (NSMutableArray *)getSearchList {
    Global_Variables *gb_variables = [Global_Variables instance];
    return [gb_variables->menu_plist valueForKey:@"Search"];
}
@end