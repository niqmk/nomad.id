@interface Serial_Related_Model : NSObject
@property (nonatomic) long id;
@property (nonatomic) long video_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDictionary *images;
@property (nonatomic, strong) NSMutableArray *serial_related_list;
+ (Serial_Related_Model *)init:(NSDictionary *)data;
@end