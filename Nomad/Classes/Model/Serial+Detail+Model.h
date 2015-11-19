#import "Price+Model.h"
#import "Serial+Related+Model.h"
#import "Member+Model.h"
#import "URLType.h"
@interface Serial_Detail_Model : NSObject
@property (nonatomic) long id;
@property (nonatomic) long serial_id;
@property (nonatomic) long video_id;
@property (nonatomic) URLType url_type_id;
@property (nonatomic, strong) NSString *video_url;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic) int season;
@property (nonatomic) int episode;
@property (nonatomic) long play_count;
@property (nonatomic) long view_count;
@property (nonatomic, strong) NSDictionary *images;
@property (nonatomic, strong) NSMutableArray *prices;
@property (nonatomic, strong) NSString *show_title;
@property (nonatomic) long total_likes;
@property (nonatomic, strong) NSMutableArray *episodes;
@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) NSMutableArray *relateds;
@property (nonatomic, strong) NSDictionary *videos;
@property (nonatomic, strong) Member_Model *log_on_member;
+ (Serial_Detail_Model *)init:(NSDictionary *)data;
+ (Serial_Detail_Model *)initDetail:(NSDictionary *)data;
+ (Serial_Detail_Model *)combine:(Serial_Detail_Model *)source
                            With:(Serial_Detail_Model *)other;
@end