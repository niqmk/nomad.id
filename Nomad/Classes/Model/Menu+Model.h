#import "Menu+Category+Model.h"
@interface Menu_Model : NSObject
@property (nonatomic) long id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) VideoType video_type_id;
@property (nonatomic, strong) NSMutableDictionary *images;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSMutableArray *menu_list;
+ (Menu_Model *)init:(NSDictionary *)data;
@end