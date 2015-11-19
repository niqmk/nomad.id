@interface Menu_Category_Model : NSObject
@property (nonatomic) int id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDictionary *images;
@property (nonatomic, strong) NSMutableArray *menu_category_list;
+ (Menu_Category_Model *)init:(NSDictionary *)data;
@end