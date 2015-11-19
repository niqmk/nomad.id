#import "Category+Model.h"
@implementation Category_Model
+ (Category_Model *)init:(NSMutableArray *)list {
    Category_Model *category_model = [[Category_Model alloc] init];
    if(category_model == nil) {
        return category_model;
    }
    category_model.category_list = list;
    return category_model;
}
- (id)initWithCoder:(NSCoder *)decoder {
    if(self = [super init]) {
        self.category_list = [decoder decodeObjectForKey:@"category_list"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.category_list forKey:@"category_list"];
}
@end