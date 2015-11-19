#import "Detail+Controller.h"
#import "Home+Controller.h"
#import "Web+Controller.h"
#import "Video+Player+View.h"
#import "Download+Controller.h"
#import "Video+Controller.h"
#import "Youtube+Controller.h"
#import "File+Controller.h"
#import "Secure+Controller.h"
#import "Query+Controller.h"
#import "URL+Manager.h"
#import "Movie+URL+Manager.h"
#import "Serial+URL+Manager.h"
#import "Movie+Model.h"
#import "Serial+Model.h"
#import "Layout+Config.h"
@interface Detail_Controller()
<Price_View_Delegate,
Video_Profile_View_Delegate,
Member_Review_View_Delegate,
Member_Comment_View_Delegate,
Video_Delegate,
Download_Delegate,
Alert_Delegate>
@end
typedef NS_ENUM(NSInteger, Alert_Status) {
    ExpiredAlertStatusCode,
    PurchasedAlertStatusCode,
    InsufficientAlertStatusCode,
    OnOffDownloadAlertStatusCode
};
typedef NS_ENUM(NSInteger, Detail_Type) {
    NoneDetailType,
    WebDetailType
};
@implementation Detail_Controller {
@private
    Web_Controller *web_controller;
    Video_Controller *video_controller;
    Video_Player_View *video_player_view;
    Youtube_Controller *youtube_controller;
    Slider_Model *slider_data;
    Movie_Model *movie_data;
    Serial_Model *serial_data;
    id detail_data;
    Video_Player_Model *video_player_data;
    Global_Variables *gb_variables;
    NSMutableDictionary *menu_view_list;
    NSMutableArray *menu_list;
    NSMutableDictionary *view_list;
    NSDictionary *videos;
    Alert_Status alert_status;
    Detail_Type detail_type;
    PlayerStatusCode player_status_code;
    DownloadStatusCode download_status_code;
    long long file_size;
    long long init_file_size;
    long video_expiry;
    NSString *menu_key_selected;
    NSString *download_id;
    bool init;
    bool menu_selected;
    float time_paused;
}
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
                 Data:(id)data {
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        if([data isKindOfClass:[Slider_Model class]]) {
            slider_data = data;
        }else if([data isKindOfClass:[Movie_Model class]]) {
            movie_data = data;
        }else if([data isKindOfClass:[Serial_Model class]]) {
            serial_data = data;
        }else if([data isKindOfClass:[Movie_Related_Model class]]) {
            movie_data = [Movie_Model initRelated:data];
        }else if([data isKindOfClass:[Serial_Related_Model class]]) {
            serial_data = [Serial_Model initRelated:data];
        }else if([data isKindOfClass:[Search_Model class]]) {
            Search_Model *search_model = (Search_Model *)data;
            if(search_model.video_type_id == MovieVideoType) {
                movie_data = [Movie_Model initSearched:search_model];
            }else if(search_model.video_type_id == SerialVideoType) {
                serial_data = [Serial_Model initSearched:search_model];
            }
        }
        video_controller = [[Video_Controller alloc] init];
        video_controller.delegate = self;
        gb_variables = [Global_Variables instance];
        player_status_code = StopStatusCode;
        download_status_code = StoppedDownloadStatusCode;
    }
    return self;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat page_width = self.scv_main.frame.size.width;
    int page = floor((self.scv_main.contentOffset.x - page_width / 2 ) / page_width) + 1;
    NSString *key = [menu_list objectAtIndex:page];
    if(!menu_selected) {
        [self setMenuSelected:key];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    menu_selected = false;
}
- (void)didMenuViewSelected:(NSString *)key {
    [self setMenuSelected:key];
    menu_selected = true;
    [self scrollTo:key];
}
- (void)didRelatedMovieViewSelected:(id)model {
    [self stopVideo];
    UIViewController *view_controller = (UIViewController *)[self.navigationController.viewControllers objectAtIndex:0];
    if([view_controller isKindOfClass:[Home_Controller class]]) {
        [((Home_Controller *)view_controller) pushDetail:model];
    }
}
- (void)didDetailMovieViewLike:(bool)selected {
    if(![gb_variables->user_session isSession]) {
        [App_Controller openCredential:self];
        return;
    }
    if(selected) {
        [App_Controller showLoading:self];
        Movie_Detail_Model *movie_detail_model = (Movie_Detail_Model *)detail_data;
        [Movie_URL_Manager MovieUnlike:movie_detail_model.id
                               Headers:[App_Controller getHeaders]
        Complete:^{
            [App_Controller closeLoading];
            Detail_Movie_View *detail_movie_view = [view_list objectForKey:detail_details];
            [detail_movie_view.btn_like setSelected:false];
        } Failed:^{
            [App_Controller closeLoading];
        } Error:^(NSInteger status_code, NSDictionary *response) {
            [App_Controller closeLoading];
            [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                              Message:[App_Controller getError:@"error_request_failed"]
                             Delegate:nil];
        }];
    }else {
        [App_Controller showLoading:self];
        Movie_Detail_Model *movie_detail_model = (Movie_Detail_Model *)detail_data;
        [Movie_URL_Manager MovieLike:movie_detail_model.id
                             Headers:[App_Controller getHeaders]
        Complete:^{
            [App_Controller closeLoading];
            Detail_Movie_View *detail_movie_view = [view_list objectForKey:detail_details];
            [detail_movie_view.btn_like setSelected:true];
        } Failed:^{
            [App_Controller closeLoading];
        } Error:^(NSInteger status_code, NSDictionary *response) {
            [App_Controller closeLoading];
            [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                              Message:[App_Controller getError:@"error_request_failed"]
                             Delegate:nil];
        }];
    }
}
- (void)didDetailMovieViewRate {
    if(![gb_variables->user_session isSession]) {
        [App_Controller openCredential:self];
        return;
    }
}
- (void)didDetailMovieViewPlay {
    if(download_status_code == StoppedDownloadStatusCode) {
        if(![gb_variables->user_session isSession]) {
            [App_Controller openCredential:self];
            return;
        }
        Movie_Detail_Model *movie_detail_model = (Movie_Detail_Model *)detail_data;
        if(movie_detail_model.log_on_member.purchase.is_purchased) {
            if(movie_detail_model.videos != nil) {
                videos = movie_detail_model.videos;
                video_expiry = movie_detail_model.log_on_member.purchase.expired_at;
                [self openVideos];
            }
        }else {
            if([movie_detail_model.prices count] > 0) {
                Price_Model *price_model = [movie_detail_model.prices objectAtIndex:0];
                if(price_model.price > 0) {
                    [self requestBuyStatus:false];
                }else {
                    Price_Model *price_model = [movie_detail_model.prices objectAtIndex:0];
                    video_expiry = price_model.expiry_days * 86400;
                    [self requestBuy:price_model];
                }
            }
        }
    }else if(download_status_code == PausedDownloadStatusCode) {
        if([Global_Controller isNotNull:download_id]) {
            Detail_Movie_View *detail_movie_view = [view_list objectForKey:detail_details];
            [detail_movie_view setDownload:true];
            [Download_Controller resume:download_id];
        }
    }
}
- (void)didDetailMovieViewPauseDownload {
    if(![Global_Controller isNotNull:download_id]) {
        return;
    }
    download_status_code = PausedDownloadStatusCode;
    [Download_Controller pause:download_id];
}
- (void)didDetailMovieViewPlayVideo {
    [self playVideo];
}
- (void)didDetailMovieViewPauseVideo {
    [video_controller pause];
}
- (void)didDetailMovieViewSeekVideo:(float)time {
    [video_controller seek:time];
    [video_controller play];
}
- (void)didReviewMovieViewWriteReview {
    if(![gb_variables->user_session isSession]) {
        [App_Controller openCredential:self];
        return;
    }
    Movie_Detail_Model *movie_detail_model = (Movie_Detail_Model *)detail_data;
    [App_Controller showMemberReview:self
                                  ID:movie_detail_model.video_id
                              Review:nil
                            Delegate:self];
}
- (void)didReviewMovieViewEditReview:(Member_Comment_Model *)member_comment_model {
    if(![gb_variables->user_session isSession]) {
        [App_Controller openCredential:self];
        return;
    }
    Movie_Detail_Model *movie_detail_model = (Movie_Detail_Model *)detail_data;
    [App_Controller showMemberReview:self
                                  ID:movie_detail_model.video_id
                              Review:member_comment_model
                            Delegate:self];
}
- (void)didRelatedSerialViewSelected:(Serial_Detail_Model *)serial_detail_model {
}
- (void)didDetailSerialViewLike:(bool)selected {
    if(![gb_variables->user_session isSession]) {
        [App_Controller openCredential:self];
        return;
    }
    if(selected) {
        [App_Controller showLoading:self];
        Serial_Detail_Model *serial_detail_model = (Serial_Detail_Model *)detail_data;
        [Serial_URL_Manager SerialUnlike:serial_detail_model.id
                                 Headers:[App_Controller getHeaders]
        Complete:^{
            [App_Controller closeLoading];
            Detail_Serial_View *detail_serial_view = [view_list objectForKey:detail_details];
            [detail_serial_view.btn_like setSelected:false];
        } Failed:^{
            [App_Controller closeLoading];
        } Error:^(NSInteger status_code, NSDictionary *response) {
            [App_Controller closeLoading];
            [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                              Message:[App_Controller getError:@"error_request_failed"]
                             Delegate:nil];
        }];
    }else {
        [App_Controller showLoading:self];
        Serial_Detail_Model *serial_detail_model = (Serial_Detail_Model *)detail_data;
        [Serial_URL_Manager SerialLike:serial_detail_model.id
                               Headers:[App_Controller getHeaders]
        Complete:^{
            [App_Controller closeLoading];
            Detail_Serial_View *detail_serial_view = [view_list objectForKey:detail_details];
            [detail_serial_view.btn_like setSelected:true];
        } Failed:^{
            [App_Controller closeLoading];
        } Error:^(NSInteger status_code, NSDictionary *response) {
            [App_Controller closeLoading];
            [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                              Message:[App_Controller getError:@"error_request_failed"]
                             Delegate:nil];
        }];
    }
}
- (void)didCommentSerialViewWriteComment {
    if(![gb_variables->user_session isSession]) {
        [App_Controller openCredential:self];
        return;
    }
    Serial_Detail_Model *serial_detail_model = (Serial_Detail_Model *)detail_data;
    [App_Controller showMemberComment:self
                                   ID:serial_detail_model.serial_id
                             Delegate:self];
}
- (void)didDetailSerialViewPlay {
    if(![gb_variables->user_session isSession]) {
        [App_Controller openCredential:self];
        return;
    }
    Serial_Detail_Model *serial_detail_model = (Serial_Detail_Model *)detail_data;
    if(serial_detail_model.url_type_id == LocalURLType) {
        if(download_status_code == StoppedDownloadStatusCode) {
            if(serial_detail_model != nil) {
                if(serial_detail_model.log_on_member.purchase.is_purchased) {
                    if(serial_detail_model.videos != nil) {
                        videos = serial_detail_model.videos;
                        video_expiry = serial_detail_model.log_on_member.purchase.expired_at;
                        [self openVideos];
                    }
                }else {
                    if([serial_detail_model.prices count] > 0) {
                        Price_Model *price_model = [serial_detail_model.prices objectAtIndex:0];
                        if(price_model.price > 0) {
                            [self requestBuyStatus:false];
                        }else {
                            Price_Model *price_model = [serial_detail_model.prices objectAtIndex:0];
                            video_expiry = price_model.expiry_days * 86400;
                            [self requestBuy:price_model];
                        }
                    }
                }
            }
        }else if(download_status_code == PausedDownloadStatusCode) {
            if([Global_Controller isNotNull:download_id]) {
                Detail_Serial_View *detail_serial_view = [view_list objectForKey:detail_details];
                [detail_serial_view setDownload:true];
                [Download_Controller resume:download_id];
            }
        }
    }else if(serial_detail_model.url_type_id == YoutubeURLType) {
        [self playYoutube];
    }else if(serial_detail_model.url_type_id == DirectURLType) {
        [self playVideo:serial_detail_model.video_url];
    }
}
- (void)didDetailSerialViewChangeEpisode:(Serial_Detail_Model *)serial_detail_model {
    [App_Controller showLoading:self];
    [Serial_URL_Manager ChangeSerialDetail:serial_detail_model.id
                                   Headers:[App_Controller getHeaders]
    Complete:^(Serial_Detail_Model *sdm) {
        [App_Controller closeLoading];
        detail_data = [Serial_Detail_Model combine:serial_detail_model
                                              With:sdm];
    } Failed:^(NSString *message) {
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:message
                         Delegate:nil];
        Detail_Serial_View *detail_serial_view = [view_list objectForKey:detail_details];
        [detail_serial_view rollback];
    } Error:^(NSInteger status_code, NSDictionary *response) {
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_request_failed"]
                         Delegate:nil];
        Detail_Serial_View *detail_serial_view = [view_list objectForKey:detail_details];
        [detail_serial_view rollback];
    }];
}
- (void)didPriceViewSelected:(long)index {
    if(detail_data == nil) {
        return;
    }
    Price_Model *price_model;
    if([App_Controller getVideoType:detail_data] == MovieVideoType) {
        Movie_Detail_Model *movie_detail_model = (Movie_Detail_Model *)detail_data;
        price_model = [movie_detail_model.prices objectAtIndex:index];
    }else if([App_Controller getVideoType:detail_data] == SerialVideoType) {
        Serial_Detail_Model *serial_detail_model = (Serial_Detail_Model *)detail_data;
        price_model = [serial_detail_model.prices objectAtIndex:index];
    }
    User_Model *user_model = [gb_variables->user_session getUser];
    if(user_model.total_points < price_model.price) {
        alert_status = InsufficientAlertStatusCode;
        [App_Controller showQuestion:[App_Controller getTitle:@"title_warning"]
                             Message:[App_Controller getError:@"error_insufficient_point"]
                            Delegate:self];
        return;
    }
    video_expiry = price_model.expiry_days * 86400;
    [self requestBuy:price_model];
}
- (void)didPriceViewCancelled {}
- (void)didVideoProfileViewSelected:(long)index {
    if([App_Controller getVideoType:detail_data] == MovieVideoType) {
        Movie_Detail_Model *movie_detail_model = (Movie_Detail_Model *)detail_data;
        if(movie_detail_model.videos != nil) {
            videos = movie_detail_model.videos;
        }
        [self setDownload:index];
    }else if([App_Controller getVideoType:detail_data] == SerialVideoType) {
        Serial_Detail_Model *serial_detail_model = (Serial_Detail_Model *)detail_data;
        if(serial_detail_model.videos != nil) {
            videos = serial_detail_model.videos;
        }
        [self setDownload:index];
    }
}
- (void)didVideoProfileViewCancelled {}
- (void)didMemberReviewViewSucceeded:(NSDictionary *)result {
    [App_Controller closeModal];
    [App_Controller showAlert:[App_Controller getTitle:@"title_success"]
                      Message:[App_Controller getMessage:@"message_reviewed"]
                     Delegate:nil];
}
- (void)didMemberReviewViewCancelled {}
- (void)didMemberCommentViewSucceeded:(NSDictionary *)result {
    [App_Controller closeModal];
    [App_Controller showAlert:[App_Controller getTitle:@"title_success"]
                      Message:[App_Controller getMessage:@"message_commented"]
                     Delegate:nil];
}
- (void)didMemberCommentViewCancelled {}
- (void)didVideoPlayed {
    player_status_code = PlayStatusCode;
    if([App_Controller getVideoType:detail_data] == MovieVideoType) {
        Detail_Movie_View *detail_movie_view = [view_list objectForKey:detail_details];
        [detail_movie_view setLoading:false];
    }else if([App_Controller getVideoType:detail_data] == SerialVideoType) {
        Detail_Serial_View *detail_serial_view = [view_list objectForKey:detail_details];
        [detail_serial_view setLoading:false];
    }
    if([Global_Controller isNotNull:download_id]) {
        [Global_Controller getContentLength:video_player_data.path
        Complete:^(long long size) {
            long long _size = [File_Controller getFileSize:video_player_data.filename];
            if(_size < size) {
                [Download_Controller resume:download_id];
            }
        }];
    }
}
- (void)didVideoError {
    player_status_code = ErrorStatusCode;
}
- (void)didVideoStopped {
    player_status_code = StopStatusCode;
}
- (void)didVideoPlayedTime:(float)time {
    Detail_Movie_View *detail_movie_view = [view_list objectForKey:detail_details];
    [detail_movie_view setSliderValue:time];
}
- (void)didVideoReceivedDuration:(float)duration {
    Detail_Movie_View *detail_movie_view = [view_list objectForKey:detail_details];
    [detail_movie_view setSliderDuration:duration];
}
- (void)didDownloadCompleted:(NSString *)filename {
    if(player_status_code != PlayStatusCode) {
        [self playVideo];
    }
}
- (void)didDownloadFailed:(NSError *)error {
    [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                      Message:[error localizedDescription]
                     Delegate:nil];
}
- (void)didDownloadProgressing:(NSUInteger)bytes_read
                TotalBytesRead:(long long)total_bytes_read
        TotalBytesExpectedRead:(long long)total_bytes_expected_read {
    Detail_Movie_View *detail_movie_view = [view_list objectForKey:detail_details];
    float progress = (float)(init_file_size + total_bytes_read)/file_size;
    [detail_movie_view setDownloadProgressing:progress];
}
- (void)didAlertActioned:(NSInteger)index {
    switch (alert_status) {
        case ExpiredAlertStatusCode:
            [App_Controller clearSession];
            break;
        case PurchasedAlertStatusCode:
            if(videos != nil) {
                [self openVideos];
            }
            break;
        case InsufficientAlertStatusCode:
        {
            if(index == question_yes) {
                [App_Controller openPointNavigation:self];
            }
            break;
        }
        case OnOffDownloadAlertStatusCode:
        {
            if(index == question_yes) {
                Detail_Movie_View *detail_movie_view = [view_list objectForKey:detail_details];
                [detail_movie_view setDownload:true];
                init_file_size = 0;
                download_id = [Download_Controller start:[Secure_Controller decrypt:video_player_data.url]
                                                Delegate:self];
                Download_Model *download_model =
                [Download_Model init:download_id
                             VideoID:video_player_data.id
                           VideoType:video_player_data.video_type
                               Title:video_player_data.title
                            Filename:video_player_data.filename
                                 URL:video_player_data.url
                                 Log:[Global_Controller getUTCTimestamp]
                              Expiry:video_expiry];
                [Query_Controller addDownload:download_model];
            }else if(index == question_no) {
                VideoType video_type = [App_Controller getVideoType:detail_data];
                Purchased_Model *purchased_model = [Query_Controller getPurchased:video_player_data.id
                                                                        VideoType:video_type];
                if(purchased_model == nil) {
                    purchased_model = [Purchased_Model init:video_player_data.id
                                                  VideoType:video_player_data.video_type
                                                      Title:video_player_data.title
                                                   Filename:video_player_data.filename
                                                        URL:video_player_data.url
                                                        Log:[Global_Controller getUTCTimestamp]
                                                     Expiry:video_expiry];
                    [Query_Controller addPurchased:purchased_model];
                }
                [self playVideo:[Secure_Controller decrypt:video_player_data.url]];
            }
            break;
        }
        default:
            break;
    }
}
- (void)didAlertCancelled {}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if(player_status_code == PlayStatusCode) {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft && toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self switchToLandscape];
    }else if(toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self switchToPotrait];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    init = true;
    [Global_Controller setDefaultBacgroundWithLogo:self.navigationController];
    [Global_Controller setImageLeftButton:self ImageNamed:@"Icon-Menu-Back" Title:text_blank Action:@selector(doBack:)];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(init) {
        init = false;
        [self setInitial];
    }
    if(detail_type == WebDetailType) {
        detail_type = NoneDetailType;
        [self requestBuyStatus:true];
    }
}
- (IBAction)doBack:(id)sender {
    if([Global_Controller isNotNull:download_id]) {
        [Download_Controller setDelegate:download_id
                                Delegate:nil];
    }
    [self stopVideo];
    [self stopYoutube];
    [self.navigationController popViewControllerAnimated:true];
}
- (void)reload {
    [self setLoading:true];
    for(UIView *view in self.scv_main.subviews) {
        [view removeFromSuperview];
    }
    [self populateData];
}
- (BOOL)isAutorotate {
    if(player_status_code == PlayStatusCode) {
        return YES;
    }
    return NO;
}
- (void)setInitial {
    [self setMenuLayout];
    [self populateData];
}
- (void)populateData {
    if(slider_data != nil) {
        if(slider_data.video_type_id == MovieVideoType) {
            [self requestMovieDetail:slider_data.video_id];
        }else if(slider_data.video_type_id == SerialVideoType) {
            [self requestSerialDetail:slider_data.first_episode_id];
        }
    }else if(movie_data != nil) {
        [self requestMovieDetail:movie_data.id];
    }else if(serial_data != nil) {
        [self requestSerialDetail:serial_data.first_episode_id];
    }
}
- (void)requestMovieDetail:(long)video_id {
    [Movie_URL_Manager MovieDetail:video_id
                           Headers:[App_Controller getHeaders]
    Complete:^(Movie_Detail_Model *movie_detail_model) {
        detail_data = movie_detail_model;
        [self setLayout];
        [self setLoading:false];
    } Failed:^(NSString *message) {
        [self requestMovieDetail:video_id];
    } Expired:^{
        alert_status = ExpiredAlertStatusCode;
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_user_expired"]
                         Delegate:self];
    } Error:^(NSInteger status_code, NSDictionary *response) {
        [self requestMovieDetail:video_id];
    }];
}
- (void)requestSerialDetail:(long)id {
    [Serial_URL_Manager SerialDetail:id
                             Headers:[App_Controller getHeaders]
    Complete:^(Serial_Detail_Model *serial_detail_model) {
        detail_data = serial_detail_model;
        [self setLayout];
        [self setLoading:false];
    } Failed:^(NSString *message) {
    } Expired:^{
        alert_status = ExpiredAlertStatusCode;
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_user_expired"]
                         Delegate:self];
    } Error:^(NSInteger status_code, NSDictionary *response) {
        [self requestSerialDetail:id];
    }];
}
- (void)requestBuy:(Price_Model *)price_model {
    long id = 0;
    VideoType video_type = [App_Controller getVideoType:detail_data];
    if(video_type == MovieVideoType) {
        id = ((Movie_Detail_Model *)detail_data).video_id;
    }else if(video_type == SerialVideoType) {
        id = ((Serial_Detail_Model *)detail_data).video_id;
    }
    [App_Controller showLoading:self];
    [URL_Manager Buy:id
           VideoType:video_type
             PriceID:price_model.id
    Complete:^(NSDictionary *response) {
        [App_Controller closeLoading];
        if([response objectForKey:@"videos"] != nil) {
            videos = [response objectForKey:@"videos"];
            [self openVideos];
        }
    } Failed:^(NSString *message) {
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:message
                         Delegate:nil];
    } Error:^(NSInteger status_code, NSDictionary *response) {
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_request_failed"]
                         Delegate:nil];
    }];
}
- (void)requestBuyStatus:(bool)from_web {
    long id = 0;
    VideoType video_type = [App_Controller getVideoType:detail_data];
    if(video_type == MovieVideoType) {
        id = ((Movie_Detail_Model *)detail_data).video_id;
    }else if(video_type == SerialVideoType) {
        id = ((Serial_Detail_Model *)detail_data).video_id;
    }
    [App_Controller showLoading:self];
    [URL_Manager BuyStatus:id
                 VideoType:video_type
    Complete:^(NSDictionary *response) {
        [App_Controller closeLoading];
        bool is_purchased = [[response objectForKey:@"is_purchased"] boolValue];
        if(is_purchased) {
            alert_status = PurchasedAlertStatusCode;
            [App_Controller showAlert:[App_Controller getTitle:@"title_success"]
                              Message:[App_Controller getMessage:@"message_purchased"]
                             Delegate:self];
            videos = [response objectForKey:@"videos"];
        }else {
            if(from_web) {
            }else {
                if(video_type == MovieVideoType) {
                    Movie_Detail_Model *movie_detail_model = (Movie_Detail_Model *)detail_data;
                    [App_Controller showPrice:self
                                         List:movie_detail_model.prices
                                     Delegate:self];
                }else if(video_type == SerialVideoType) {
                    Serial_Detail_Model *serial_detail_model = (Serial_Detail_Model *)detail_data;
                    [App_Controller showPrice:self
                                         List:serial_detail_model.prices
                                     Delegate:self];
                }
            }
        }
    } Failed:^(NSString *message) {
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:message
                         Delegate:nil];
    } Error:^(NSInteger status_code, NSDictionary *response) {
        [App_Controller closeLoading];
        [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                          Message:[App_Controller getError:@"error_request_failed"]
                         Delegate:nil];
    }];
}
- (void)openVideos {
    if([videos count] > 1) {
        [App_Controller showVideoProfile:self
                                    Data:videos
                                Delegate:self];
    }else if([videos count] > 0) {
        [self setDownload:0];
    }
}
- (void)setMenuLayout {
    menu_view_list = [[NSMutableDictionary alloc] init];
    if(slider_data != nil) {
        menu_list = [App_Controller getDetailMovieList];
    }else if(movie_data != nil) {
        menu_list = [App_Controller getDetailMovieList];
    }else if(serial_data != nil) {
        menu_list = [App_Controller getDetailSerialList];
    }
    float max_width = 0;
    NSString *first_key;
    for(NSString *each in menu_list) {
        if(![Global_Controller isNotNull:first_key]) {
            first_key = each;
        }
        Menu_View *menu_view = [[Menu_View alloc] init];
        menu_view.delegate = self;
        [menu_view set:each];
        max_width += menu_view.frame.size.width;
        [menu_view_list setObject:menu_view forKey:each];
    }
    float width = 0;
    if(max_width < self.scv_menu.frame.size.width) {
        width = self.scv_menu.frame.size.width / [menu_list count];
    }
    float x = 0;
    float height = 0;
    for(NSString *each in menu_list) {
        Menu_View *menu_view = [menu_view_list objectForKey:each];
        height = menu_view.frame.size.height;
        if(width == 0) {
            menu_view.frame = CGRectMake(x, 0, menu_view.frame.size.width, menu_view.frame.size.height);
        }else {
            menu_view.frame = CGRectMake(x, 0, width, menu_view.frame.size.height);
        }
        [self.scv_menu addSubview:menu_view];
        x += menu_view.frame.size.width;
    }
    self.scv_menu.contentSize = CGSizeMake(x, height);
    [self setMenuSelected:first_key];
}
- (void)setLayout {
    CGSize size = self.scv_main.frame.size;
    float x = 0;
    view_list = [[NSMutableDictionary alloc] init];
    for(NSString *each in menu_list) {
        UIView *layout;
        if([App_Controller getVideoType:detail_data] == MovieVideoType) {
            Movie_Detail_Model *movie_detail_model = (Movie_Detail_Model *)detail_data;
            layout = [Layout_Controller getDetailMovieLayout:each
                                                      Detail:movie_detail_model
                                                       Width:size.width
                                              DetailDelegate:self
                                              ReviewDelegate:self
                                             RelatedDelegate:self];
        }else if([App_Controller getVideoType:detail_data] == SerialVideoType) {
            Serial_Detail_Model *serial_detail_model = (Serial_Detail_Model *)detail_data;
            layout = [Layout_Controller getDetailSerialLayout:each
                                                       Detail:serial_detail_model
                                                        Width:size.width
                                               DetailDelegate:self
                                               ReviewDelegate:self
                                              RelatedDelegate:self];
        }
        layout.frame = CGRectMake(x, 0, size.width, size.height);
        [self.scv_main addSubview:layout];
        if(layout != nil) {
            [view_list setObject:layout forKey:each];
        }
        x += size.width;
    }
    self.scv_main.contentSize = CGSizeMake(x, self.scv_main.frame.size.height);
    [self scrollTo:menu_key_selected];
    [self checkDownload];
}
- (void)setMenuSelected:(NSString *)key {
    for(NSString *each in menu_view_list) {
        Menu_View *menu_view = [menu_view_list objectForKey:each];
        if([each isEqualToString:key]) {
            [menu_view setSelected:true];
        }else {
            [menu_view setSelected:false];
        }
    }
}
- (void)checkDownload {
    VideoType video_type = [App_Controller getVideoType:detail_data];
    Download_Model *download_model = nil;
    if(video_type == MovieVideoType) {
        Movie_Detail_Model *movie_detail_model = (Movie_Detail_Model *)detail_data;
        download_model = [Query_Controller getDownload:movie_detail_model.video_id
                                             VideoType:video_type];
    }else if(video_type == SerialVideoType) {
        Serial_Detail_Model *serial_detail_model = (Serial_Detail_Model *)detail_data;
        download_model = [Query_Controller getDownload:serial_detail_model.video_id
                                             VideoType:video_type];
    }
    if(download_model != nil) {
        if(download_model.id == 0) {
        }else {
            if([Download_Controller isDownloading:download_model.id]) {
                [App_Controller showLoading:self];
                [Global_Controller getContentLength:[Secure_Controller decrypt:download_model.url]
                Complete:^(long long size) {
                    [App_Controller closeLoading];
                    Detail_Movie_View *detail_movie_view = [view_list objectForKey:detail_details];
                    [detail_movie_view setDownload:true];
                    file_size = size;
                    init_file_size = [File_Controller getFileSize:download_model.filename];
                    [Download_Controller setDelegate:download_model.id
                                            Delegate:self];
                }];
            }
        }
    }
}
- (void)scrollTo:(NSString *)key {
    if(![Global_Controller isNotNull:key]) {
        return;
    }
    menu_key_selected = key;
    NSInteger index = [menu_list indexOfObject:key];
    CGRect frame = self.scv_main.frame;
    frame.origin.x = frame.size.width * index;
    frame.origin.y = 0;
    [self.scv_main scrollRectToVisible:frame animated:YES];
}
- (void)setLoading:(bool)show {
    [self.vw_loading setHidden:!show];
}
- (void)setDownload:(long)index {
    [App_Controller showLoading:self];
    NSArray *keys = [videos allKeys];
    NSString *key = [keys objectAtIndex:index];
    NSString *value = [videos objectForKey:key];
    [Global_Controller getContentLength:value
    Complete:^(long long size) {
        [App_Controller closeLoading];
        if(size == 0) {
            [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                              Message:[App_Controller getError:@"error_video_not_found"]
                             Delegate:nil];
        }else {
            file_size = size;
            Detail_Movie_View *detail_movie_view = [view_list objectForKey:detail_details];
            NSString *filename = [File_Controller getFilenameFromURL:value];
            long video_id = 0;
            VideoType video_type = [App_Controller getVideoType:detail_data];
            NSString *title = text_blank;
            if(video_type == MovieVideoType) {
                Movie_Detail_Model *movie_detail_model = (Movie_Detail_Model *)detail_data;
                video_id = movie_detail_model.video_id;
                title = movie_detail_model.title;
            }else if(video_type == SerialVideoType) {
                Serial_Detail_Model *serial_detail_model = (Serial_Detail_Model *)detail_data;
                video_id = serial_detail_model.video_id;
                title = serial_detail_model.title;
            }
            video_player_data = [App_Controller generateVideoPlayerData:filename
                                                              VideoType:video_type
                                                                  Title:title
                                                                    URL:value];
            if([File_Controller isFileExistFromURL:value]) {
                init_file_size = [File_Controller getFileSize:filename];
                if(init_file_size == size) {
                    [self playVideo];
                }else {
                    [detail_movie_view setDownload:true];
                    download_id = [Download_Controller resume:filename
                                                          URL:value
                                                     Delegate:self];
                    [Query_Controller updateDownloadByVideoID:video_id
                                                    VideoType:video_type
                                                           ID:download_id
                                                       Expiry:video_expiry];
                }
            }else {
                alert_status = OnOffDownloadAlertStatusCode;
                NSString *total_file_size = [NSString stringWithFormat:@"%@ MBytes", [Global_Controller format:((float)file_size / 1048576)]];
                NSString *message = [NSString stringWithFormat:[App_Controller getMessage:@"message_onoff_video"], total_file_size];
                [App_Controller showQuestion:[App_Controller getTitle:@"title_app"]
                                     Message:message
                                    Delegate:self];
            }
        }
    }];
}
- (void)playVideo {
    if([Global_Controller isNotNull:download_id]) {
        [Download_Controller pause:download_id];
    }
    Detail_Movie_View *detail_movie_view = [view_list objectForKey:detail_details];
    [detail_movie_view setPlayFulltime:true];
    [video_controller startServer:video_player_data
                             View:detail_movie_view.vw_player];
}
- (void)playVideo:(NSString *)url {
    Detail_Movie_View *detail_movie_view = [view_list objectForKey:detail_details];
    [detail_movie_view setPlayFulltime:true];
    [video_controller open:url
                    ToView:detail_movie_view.vw_player];
}
- (void)stopVideo {
    if(player_status_code == PlayStatusCode) {
        if(video_controller != nil) {
            [video_controller stopServer];
        }
        player_status_code = StopStatusCode;
    }
}
- (void)playYoutube {
    NSString *video_url = text_blank;
    if([App_Controller getVideoType:detail_data] == MovieVideoType) {
        video_url = ((Movie_Detail_Model *)detail_data).video_url;
    }else if([App_Controller getVideoType:detail_data] == SerialVideoType) {
        video_url = ((Serial_Detail_Model *)detail_data).video_url;
    }
    Detail_Serial_View *detail_serial_view = [view_list objectForKey:detail_details];
    [detail_serial_view setPlayerView:true];
    youtube_controller = [[Youtube_Controller alloc] init];
    [youtube_controller open:video_url
                        View:detail_serial_view.vw_player];
}
- (void)stopYoutube {
    if(youtube_controller != nil) {
        [youtube_controller close];
    }
}
- (void)showURL:(NSString *)url {
    detail_type = WebDetailType;
    web_controller = [[Web_Controller alloc] initWithNibName:@"Web+Controller"
                                                      bundle:nil
                                                         URL:url];
    [self pushDetail:web_controller];
}
- (void)switchToPotrait {
    if([App_Controller getVideoType:detail_data] == MovieVideoType) {
        Detail_Movie_View *detail_movie_view = [view_list objectForKey:detail_details];
        [video_controller changeView:detail_movie_view.vw_player];
    }else if([App_Controller getVideoType:detail_data] == SerialVideoType) {
        Detail_Serial_View *detail_serial_view = [view_list objectForKey:detail_details];
        [video_controller changeView:detail_serial_view.vw_player];
    }
}
- (void)switchToLandscape {
    video_player_view = [[Video_Player_View alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:video_player_view];
    [video_controller changeView:video_player_view.vw_player];
}
- (void)pushDetail:(UIViewController *)view_controller {
    [self.navigationController pushViewController:view_controller animated:true];
}
@end