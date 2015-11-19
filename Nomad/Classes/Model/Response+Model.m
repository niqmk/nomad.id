#import "Response+Model.h"
@implementation Response_Model
+ (Response_Model *)init:(NSDictionary *)data {
    Response_Model *response_model = [[Response_Model alloc] init];
    if(data == nil) {
        return response_model;
    }
    response_model.status = [[data objectForKey:@"status"] intValue];
    if([data objectForKey:@"result"] != nil) {
        response_model.result = [data objectForKey:@"result"];
    }else if([data objectForKey:@"results"] != nil) {
        response_model.result = [data objectForKey:@"results"];
    }
    if([data objectForKey:@"message"] != nil) {
        response_model.message = [data objectForKey:@"message"];
    }else {
        response_model.message = text_blank;
    }
    return response_model;
}
@end