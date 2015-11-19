#import "Slider+Model.h"
@implementation Slider_Model
+ (Slider_Model *)init:(NSDictionary *)data {
    Slider_Model *slider_model = [[Slider_Model alloc] init];
    if(data == nil) {
        return slider_model;
    }
    slider_model.slider_list = [[NSMutableArray alloc] init];
    for(NSDictionary *each in data) {
        Slider_Model *slider = [Slider_Model initObject:each];
        [slider_model.slider_list addObject:slider];
    }
    return slider_model;
}
+ (Slider_Model *)initObject:(NSDictionary *)data {
    Slider_Model *slider_model = [[Slider_Model alloc] init];
    if(data == nil) {
        return slider_model;
    }
    slider_model.id = [[data objectForKey:@"id"] longValue];
    slider_model.video_id = [[data objectForKey:@"video_id"] longValue];
    if([data objectForKey:@"serial_id"] != nil) {
        slider_model.serial_id = [[data objectForKey:@"serial_id"] longValue];
    }else {
        slider_model.serial_id = 0;
    }
    if([data objectForKey:@"first_episode_id"] != nil) {
        slider_model.first_episode_id = [[data objectForKey:@"first_episode_id"] longValue];
    }else {
        slider_model.first_episode_id = 0;
    }
    slider_model.title = [data objectForKey:@"title"];
    slider_model.desc = [data objectForKey:@"description"];
    slider_model.link_url = [data objectForKey:@"link_url"];
    slider_model.images = [data valueForKey:@"images"];
    slider_model.video_type_id = [[data objectForKey:@"video_type_id"] intValue];
    return slider_model;
}
- (id)initWithCoder:(NSCoder *)decoder {
    if(self = [super init]) {
        self.id = [decoder decodeIntegerForKey:@"id"];
        self.video_id = [decoder decodeIntegerForKey:@"video_id"];
        self.serial_id = [decoder decodeIntegerForKey:@"serial_id"];
        self.first_episode_id = [decoder decodeIntegerForKey:@"first_episode_id"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.desc = [decoder decodeObjectForKey:@"desc"];
        self.link_url = [decoder decodeObjectForKey:@"link_url"];
        self.images = [decoder decodeObjectForKey:@"images"];
        self.video_type_id = [decoder decodeIntForKey:@"video_type_id"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInteger:self.id forKey:@"id"];
    [encoder encodeInteger:self.video_id forKey:@"video_id"];
    [encoder encodeInteger:self.serial_id forKey:@"serial_id"];
    [encoder encodeInteger:self.first_episode_id forKey:@"first_episode_id"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.desc forKey:@"desc"];
    [encoder encodeObject:self.link_url forKey:@"link_url"];
    [encoder encodeObject:self.images forKey:@"images"];
    [encoder encodeInt:self.video_type_id forKey:@"video_type_id"];
}
@end