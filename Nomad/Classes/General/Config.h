typedef NS_ENUM(NSInteger, MenuState) {
    MenuMaster,
    MenuDetail
};
typedef NS_ENUM(NSInteger, StatusCode) {
    FailedStatusCode,
    SuccessStatusCode,
    ExpiredStatusCode
};
typedef NS_ENUM(NSInteger, PlayerStatusCode) {
    PlayStatusCode,
    StopStatusCode,
    PauseStatusCode,
    ErrorStatusCode
};
typedef NS_ENUM(NSInteger, DownloadStatusCode) {
    StoppedDownloadStatusCode,
    StartedDownloadStatusCode,
    PausedDownloadStatusCode
};
extern NSString *const secure_key;
extern NSString *const video_secure_key;
extern NSString *const text_blank;
extern NSString *const sql_file;
extern NSString *const session_user;
extern NSString *const parse_app_id;
extern NSString *const parse_client_key;
extern NSString *const date_format;
extern NSString *const long_date_format;
extern NSString *const socket_server;
extern long const limit_list;
extern long const text_length_valid;
extern NSString *const default_date_birth;
extern int const question_yes;
extern int const question_no;
extern int const status_blank;
extern int const status_success;
extern int const status_invalid_credential;
extern int const status_validation_errors;
extern int const status_api_errors;
extern int const status_unconfirmed_email;
extern int const status_unknown_errors;
//Video
extern float const default_min_percentage_play_video;
#define BACK_BUTTON_WIDTH CGRectMake(0.0f, 12.0f, 60, 40)
#define COLOR_BUTTON_OK [UIColor colorWithRed:242/255 green:103/255 blue:33/255 alpha:1]
#define COLOR_BUTTON_YES [UIColor colorWithRed:38/255 green:109/255 blue:0 alpha:1]
#define COLOR_BUTTON_NO [UIColor colorWithRed:109/255 green:0 blue:0 alpha:1]