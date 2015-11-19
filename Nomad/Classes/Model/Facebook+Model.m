#import "Facebook+Model.h"
@implementation Facebook_Model
+ (Facebook_Model *)init:(NSDictionary *)data {
    Facebook_Model *facebook_model = [[Facebook_Model alloc] init];
    if(data == nil) {
        return facebook_model;
    }
    facebook_model.fb_id = [data objectForKey:@"id"];
    if([data objectForKey:@"email"] != nil) {
        facebook_model.email = [data objectForKey:@"email"];
    }else {
        facebook_model.email = text_blank;
    }
    if([data objectForKey:@"first_name"] != nil) {
        facebook_model.firstname = [data objectForKey:@"first_name"];
    }else {
        facebook_model.firstname = text_blank;
    }
    if([data objectForKey:@"last_name"] != nil) {
        facebook_model.lastname = [data objectForKey:@"last_name"];
    }else {
        facebook_model.lastname = text_blank;
    }
    if([data objectForKey:@"name"] != nil) {
        facebook_model.fullname = [data objectForKey:@"name"];
    }else {
        facebook_model.fullname = text_blank;
    }
    return facebook_model;
}
@end