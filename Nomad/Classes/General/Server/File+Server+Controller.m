#import "File+Server+Controller.h"
#import <GCDWebServer/GCDWebServer.h>
#import <GCDWebServer/GCDWebServerFileResponse.h>
#import <GCDWebServer/GCDWebServerStreamedResponse.h>
#import <GCDWebServer/GCDWebServerDataResponse.h>
#import "Secure+Controller.h"
#import "File+Controller.h"
#import "Server+Config.h"
@implementation File_Server_Controller {
@private
    GCDWebServer *web_server;
}
- (id)initListen:(Video_Player_Model *)video_player_model {
    if(self = [super init]) {
        self.video_player_data = video_player_model;
        web_server = [[GCDWebServer alloc] init];
    }
    return self;
}
- (void)start:(void(^)(NSURL *))completeHandler {
    __weak __typeof(self)weakSelf = self;
    [Secure_Controller decryptVideo:self.video_player_data.video_type
                             Source:[File_Controller getPath:self.video_player_data.filename]
                        Destination:self.video_player_data.path
    Complete:^(NSOutputStream *output_stream) {
        [web_server addHandlerForMethod:@"GET"
                                   path:@"/"
                           requestClass:[GCDWebServerRequest class]
        processBlock:^GCDWebServerResponse *(GCDWebServerRequest *request) {
            [output_stream open];
            NSData *contents = [output_stream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
            [output_stream close];
            NSString *path = [File_Controller getTempPath:weakSelf.video_player_data.filename];
            [contents writeToFile:path atomically:YES];
            GCDWebServerResponse *response = [GCDWebServerFileResponse responseWithFile:path byteRange:request.byteRange];
            [response setValue:@"bytes" forAdditionalHeader:@"Accept-Ranges"];
            return response;
        }];
        [web_server startWithOptions:@{
                                       GCDWebServerOption_Port: [NSNumber numberWithInt:file_server_port],
                                       GCDWebServerOption_BindToLocalhost: [NSNumber numberWithBool:true]
                                       } error:nil];
        completeHandler(web_server.serverURL);
    }];
}
- (void)stop {
    [web_server stop];
    [File_Controller cleanTempPath];
}
@end