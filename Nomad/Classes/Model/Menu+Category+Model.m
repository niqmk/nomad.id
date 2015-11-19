#import "Menu+Category+Model.h"
@implementation Menu_Category_Model
+ (Menu_Category_Model *)init:(NSDictionary *)data {
    Menu_Category_Model *menu_category_model = [[Menu_Category_Model alloc] init];
    if(data == nil) {
        return menu_category_model;
    }
    menu_category_model.menu_category_list = [[NSMutableArray alloc] init];
    for(NSDictionary *each in data) {
        Menu_Category_Model *menu_category = [Menu_Category_Model initObject:each];
        [menu_category_model.menu_category_list addObject:menu_category];
    }
    return menu_category_model;
}
+ (Menu_Category_Model *)initObject:(NSDictionary *)data {
    Menu_Category_Model *menu_category_model = [[Menu_Category_Model alloc] init];
    if(data == nil) {
        return menu_category_model;
    }
    menu_category_model.id = [[data objectForKey:@"id"] intValue];
    menu_category_model.name = [data objectForKey:@"name"];
    menu_category_model.images = [data valueForKey:@"images"];
    return menu_category_model;
}
- (id)initWithCoder:(NSCoder *)decoder {
    if(self = [super init]) {
        self.id = [decoder decodeIntForKey:@"id"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.images = [decoder decodeObjectForKey:@"images"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:self.id forKey:@"id"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.images forKey:@"images"];
}
@end