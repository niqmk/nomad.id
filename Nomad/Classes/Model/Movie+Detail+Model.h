#import "Price+Model.h"
#import "Movie+Cast+Model.h"
#import "Movie+Director+Model.h"
#import "Movie+Genre+Model.h"
#import "Movie+Related+Model.h"
#import "Member+Model.h"
@interface Movie_Detail_Model : NSObject
@property (nonatomic) long id;
@property (nonatomic) long video_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *release_date;
@property (nonatomic, strong) NSString *languages;
@property (nonatomic, strong) NSString *subtitles;
@property (nonatomic) long play_count;
@property (nonatomic) long view_count;
@property (nonatomic) long run_time_in_minute;
@property (nonatomic, strong) NSString *video_url;
@property (nonatomic, strong) NSMutableArray *prices;
@property (nonatomic, strong) NSDictionary *images;
@property (nonatomic) long total_likes;
@property (nonatomic) double overall_rating;
@property (nonatomic, strong) NSMutableArray *casts;
@property (nonatomic, strong) NSMutableArray *directors;
@property (nonatomic, strong) NSMutableArray *genres;
@property (nonatomic, strong) NSMutableArray *reviews;
@property (nonatomic, strong) NSMutableArray *relateds;
@property (nonatomic, strong) NSDictionary *videos;
@property (nonatomic, strong) Member_Model *log_on_member;
+ (Movie_Detail_Model *)init:(NSDictionary *)data;
@end