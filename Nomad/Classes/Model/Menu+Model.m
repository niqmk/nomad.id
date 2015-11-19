#import "Menu+Model.h"
@implementation Menu_Model
+ (Menu_Model *)init:(NSDictionary *)data {
    Menu_Model *menu_model = [[Menu_Model alloc] init];
    if(data == nil) {
        return menu_model;
    }
    menu_model.menu_list = [[NSMutableArray alloc] init];
    for(NSDictionary *each in data) {
        Menu_Model *menu = [Menu_Model initObject:each];
        [menu_model.menu_list addObject:menu];
    }
    return menu_model;
}
+ (Menu_Model *)initObject:(NSDictionary *)data {
    Menu_Model *menu_model = [[Menu_Model alloc] init];
    if(data == nil) {
        return menu_model;
    }
    menu_model.id = [[data objectForKey:@"id"] intValue];
    menu_model.name = [data objectForKey:@"name"];
    menu_model.video_type_id = [[data objectForKey:@"video_type_id"] intValue];
    menu_model.images = [data objectForKey:@"images"];
    Menu_Category_Model *menu_category_model = [Menu_Category_Model init:[data objectForKey:@"categories"]];
    menu_model.categories = menu_category_model.menu_category_list;
    return menu_model;
}
- (id)initWithCoder:(NSCoder *)decoder {
    if(self = [super init]) {
        self.id = [decoder decodeIntegerForKey:@"id"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.video_type_id = [decoder decodeInt32ForKey:@"video_type_id"];
        self.images = [decoder decodeObjectForKey:@"images"];
        self.categories = [decoder decodeObjectForKey:@"categories"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInteger:self.id forKey:@"id"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeInt32:self.video_type_id forKey:@"video_type_id"];
    [encoder encodeObject:self.images forKey:@"images"];
    [encoder encodeObject:self.categories forKey:@"categories"];
}
@end