@interface Member_Purchase_Model : NSObject
@property (nonatomic) bool is_purchased;
@property (nonatomic) long expired_at;
+ (Member_Purchase_Model *)init:(NSDictionary *)data;
@end
@interface Member_Comment_Model : NSObject
@property (nonatomic) long id;
@property (nonatomic) long movie_id;
@property (nonatomic) long serial_id;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic) long rate;
@property (nonatomic) long created_at;
@property (nonatomic) long updated_at;
@property (nonatomic, strong) NSString *member_username;
@property (nonatomic, strong) NSMutableArray *member_comment_list;
+ (Member_Comment_Model *)init:(NSDictionary *)data;
+ (Member_Comment_Model *)initObject:(NSDictionary *)data;
@end
@interface Member_Model : NSObject
@property (nonatomic, strong) Member_Purchase_Model *purchase;
@property (nonatomic, strong) Member_Comment_Model *comment;
@property (nonatomic) bool is_liked;
@property (nonatomic) bool is_watched;
@property (nonatomic) bool is_watchlisted;
+ (Member_Model *)init:(NSDictionary *)data;
@end