#import "URL+Config.h"
NSString *const url_server = @"http://nomadv3.allega.co.id/api/web/index.php/api/";
//NSString *const url_server = @"http://dev.nomad.id/api/web/index.php/api/";
//NSString *const url_server = @"http://10.0.0.232:8090/index.php/api/";
NSString *const url_login = @"%@member/log-in";
NSString *const url_register = @"%@member";
NSString *const url_fb_login = @"%@member/fb-log-in";
NSString *const url_forgot_password = @"%@member/forgot-password";
NSString *const url_me = @"%@me";
NSString *const url_menus = @"%@system/menus";
NSString *const url_slider = @"%@v2/slider";
NSString *const url_search = @"%@video/search";
NSString *const url_buy = @"%@v2/buy";
NSString *const url_buy_status = @"%@v2/buy/status";
NSString *const url_paid_point = @"%@v2/paid-point";
NSString *const url_paid_point_buy = @"%@v2/paid-point/buy";
NSString *const url_free_point = @"%@v2/free-point";
//MOVIE
NSString *const url_movie = @"%@v2/movie/%@?prefix=ios";
NSString *const url_movie_like = @"%@movie/%ld/like";
NSString *const url_movie_unlike = @"%@movie/%ld/unlike";
NSString *const url_movie_review = @"%@movie/%ld/comment";
//SERIAL
NSString *const url_serial = @"%@v2/serial/episode/%@";
NSString *const url_serial_detail = @"%@v2/serial/episode/%@/detail";
NSString *const url_serial_like = @"%@serial/episode/%ld/like";
NSString *const url_serial_unlike = @"%@serial/episode/%ld/unlike";
NSString *const url_serial_comment = @"%@serial/episode/%ld/comment";