@interface Serial_Episode_Model : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *serial_episode_list;
+ (Serial_Episode_Model *)init:(NSDictionary *)data;
@end