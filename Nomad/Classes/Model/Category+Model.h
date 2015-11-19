@interface Category_Model : NSObject
@property (nonatomic, strong) NSMutableArray *category_list;
+ (Category_Model *)init:(NSMutableArray *)list;
@end