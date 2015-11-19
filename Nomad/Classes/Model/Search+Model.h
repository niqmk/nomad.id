@interface Search_Model : NSObject
@property (nonatomic) long id;
@property (nonatomic, strong) NSString *type;
@property (nonatomic) long video_type_id;
@property (nonatomic) long video_id;
@property (nonatomic) long serial_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableArray *search_list;
+ (Search_Model *)init:(NSDictionary *)data;
@end