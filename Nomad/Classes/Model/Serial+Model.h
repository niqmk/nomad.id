#import "Serial+Related+Model.h"
#import "Search+Model.h"
#import "URLType.h"
@interface Serial_Model : NSObject
@property (nonatomic) long id;
@property (nonatomic) long serial_id;
@property (nonatomic) long video_id;
@property (nonatomic) URLType url_type_id;
@property (nonatomic) long first_episode_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDictionary *images;
@property (nonatomic, strong) NSString *show_title;
@property (nonatomic, strong) NSMutableArray *serial_list;
+ (Serial_Model *)init:(NSDictionary *)data;
+ (Serial_Model *)initRelated:(Serial_Related_Model *)serial_related_model;
+ (Serial_Model *)initSearched:(Search_Model *)search_model;
@end