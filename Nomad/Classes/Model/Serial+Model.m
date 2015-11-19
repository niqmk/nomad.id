#import "Serial+Model.h"
@implementation Serial_Model
+ (Serial_Model *)init:(NSDictionary *)data {
    Serial_Model *serial_model = [[Serial_Model alloc] init];
    if(data == nil) {
        return serial_model;
    }
    serial_model.serial_list = [[NSMutableArray alloc] init];
    for(NSDictionary *each in data) {
        Serial_Model *serial = [Serial_Model initObject:each];
        [serial_model.serial_list addObject:serial];
    }
    return serial_model;
}
+ (Serial_Model *)initRelated:(Serial_Related_Model *)serial_related_model {
    Serial_Model *serial_model = [[Serial_Model alloc] init];
    if(serial_related_model == nil) {
        return serial_model;
    }
    serial_model.id = serial_related_model.id;
    serial_model.video_id = serial_related_model.video_id;
    serial_model.title = serial_related_model.title;
    serial_model.images = serial_related_model.images;
    return serial_model;
}
+ (Serial_Model *)initSearched:(Search_Model *)search_model {
    Serial_Model *serial_model = [[Serial_Model alloc] init];
    if(search_model == nil) {
        return serial_model;
    }
    serial_model.id = search_model.id;
    serial_model.video_id = search_model.video_id;
    serial_model.first_episode_id = search_model.id;
    serial_model.title = search_model.title;
    serial_model.images = nil;
    return serial_model;
}
+ (Serial_Model *)initObject:(NSDictionary *)data {
    Serial_Model *serial_model = [[Serial_Model alloc] init];
    if(data == nil) {
        return serial_model;
    }
    serial_model.id = [[data objectForKey:@"id"] longValue];
    serial_model.serial_id = [[data objectForKey:@"serial_id"] longValue];
    serial_model.video_id = [[data objectForKey:@"video_id"] longValue];
    serial_model.url_type_id = [[data objectForKey:@"url_type_id"] intValue];
    if([data objectForKey:@"first_episode_id"] != nil) {
        serial_model.first_episode_id = [[data objectForKey:@"first_episode_id"] longValue];
    }
    serial_model.title = [data objectForKey:@"title"];
    serial_model.images = [data valueForKey:@"images"];
    serial_model.show_title = [data objectForKey:@"show_title"];
    return serial_model;
}
- (id)initWithCoder:(NSCoder *)decoder {
    if(self = [super init]) {
        self.id = [decoder decodeIntegerForKey:@"id"];
        self.serial_id = [decoder decodeIntegerForKey:@"serial_id"];
        self.video_id = [decoder decodeIntegerForKey:@"video_id"];
        self.url_type_id = [decoder decodeIntForKey:@"url_type_id"];
        self.first_episode_id = [decoder decodeIntegerForKey:@"first_episode_id"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.images = [decoder decodeObjectForKey:@"images"];
        self.show_title = [decoder decodeObjectForKey:@"show_title"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInteger:self.id forKey:@"id"];
    [encoder encodeInteger:self.serial_id forKey:@"serial_id"];
    [encoder encodeInteger:self.video_id forKey:@"video_id"];
    [encoder encodeInt:self.url_type_id forKey:@"url_type_id"];
    [encoder encodeInteger:self.first_episode_id forKey:@"first_episode_id"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.images forKey:@"images"];
    [encoder encodeObject:self.show_title forKey:@"show_title"];
}
@end