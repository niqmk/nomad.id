#import "Price+View.h"
#import "Video+Profile+View.h"
#import "Member+Review+View.h"
#import "Member+Comment+View.h"
#import "Alert+Controller.h"
#import "Me+Model.h"
#import "Video+Player+Model.h"
#import "VideoType.h"
@interface App_Controller : NSObject
+ (void)clearSession;
+ (NSDictionary *)getHeaders;
+ (void)getMe:(void (^)(Me_Model *me_model))completeHandler
       Failed:(void (^)(NSString *message))failedHandler
        Error:(void (^)())errorHandler;
+ (void)refreshMe;
+ (VideoType)getVideoType:(id)model;
+ (Video_Player_Model *)generateVideoPlayerData:(NSString *)filename
                                      VideoType:(VideoType)video_type
                                          Title:(NSString *)title
                                            URL:(NSString *)url;
+ (void)showNotification:(NSString *)message;
+ (void)showAlert:(NSString *)title
          Message:(NSString *)message
         Delegate:(id<Alert_Delegate>)delegate;
+ (void)showQuestion:(NSString *)title
             Message:(NSString *)message
            Delegate:(id<Alert_Delegate>)delegate;
+ (void)showLoading:(UIViewController *)view_controller;
+ (void)showLoading:(UIViewController *)view_controller
            Message:(NSString *)message
         Cancelable:(bool)cancelable;
+ (void)closeLoading;
+ (void)addKeyboardListen:(id)observer
           onKeyboardShow:(SEL)keyboard_show_selector
           onKeyboardHide:(SEL)keyboard_hide_selector;
+ (void)removeKeyboardListen:(id)observer;
+ (void)showPrice:(UIViewController *)view_controller
             List:(NSMutableArray *)list
         Delegate:(id<Price_View_Delegate>)delegate;
+ (void)showVideoProfile:(UIViewController *)view_controller
                    Data:(NSDictionary *)data
                Delegate:(id<Video_Profile_View_Delegate>)delegate;
+ (void)showMemberReview:(UIViewController *)view_controller
                      ID:(long)id
                  Review:(Member_Comment_Model *)member_comment_model
                Delegate:(id<Member_Review_View_Delegate>)delegate;
+ (void)showMemberComment:(UIViewController *)view_controller
                       ID:(long)id
                Delegate:(id<Member_Comment_View_Delegate>)delegate;
+ (void)openLandController;
+ (void)openHomeController;
+ (void)openHome:(UIViewController *)view_controller;
+ (void)openHome:(UIViewController *)view_controller
       VideoType:(VideoType)type
              ID:(long)id;
+ (void)closeModal;
#pragma Controller
+ (void)openCredential:(UIViewController *)view_controller;
+ (void)closeCredential:(void (^)())completeHandler;
+ (void)openDownloadList:(UIViewController *)menu_controller;
+ (void)openVideoPlayer:(UIViewController *)view_controller
                  Video:(Video_Player_Model *)video_player_model;
+ (void)closeVideoPlayer:(void (^)())completeHandler;
+ (void)openPoint:(UIViewController *)menu_controller;
+ (void)openPointNavigation:(UIViewController *)view_controller;
#pragma Session
+ (bool)isSessionHome:(NSString *)url;
+ (void)setSessionHome:(NSString *)url
                  List:(NSMutableArray *)list;
+ (NSMutableArray *)getSessionHome:(NSString *)url;
#pragma App.plist
+ (NSString *)getTitle:(NSString *)key;
+ (NSString *)getMessage:(NSString *)key;
+ (NSString *)getLabel:(NSString *)key;
+ (NSString *)getError:(NSString *)key;
#pragma Menu.plist
+ (NSMutableArray *)getHomeList;
+ (NSMutableArray *)getHomeMenuList:(VideoType)video_type;
+ (NSMutableArray *)getDetailMovieList;
+ (NSMutableArray *)getDetailSerialList;
+ (NSMutableArray *)getSearchList;
@end