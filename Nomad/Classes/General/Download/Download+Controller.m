#import "Download+Controller.h"
#import "Secure+Controller.h"
@implementation Download_Controller
static NSMutableDictionary *download_data;
+ (NSString *)start:(NSString *)url
           Delegate:(id<Download_Delegate>)delegate {
    Download_Manager *download_manager = [[Download_Manager alloc] init];
    download_manager.delegate = delegate;
    [download_manager start:url];
    NSString *id = [Secure_Controller MD5:[NSString stringWithFormat:@"%.f", [Global_Controller getUTCTimestamp]]];
    if(download_data == nil) {
        download_data = [[NSMutableDictionary alloc] init];
    }
    [download_data setObject:download_manager forKey:id];
    return id;
}
+ (void)stop:(NSString *)id {
    if(download_data == nil) {
        return;
    }
    Download_Manager *download_manager = [download_data objectForKey:id];
    if(download_manager == nil) {
        return;
    }
    [download_manager stop];
    [download_data removeObjectForKey:id];
}
+ (void)pause:(NSString *)id {
    if(download_data == nil) {
        return;
    }
    Download_Manager *download_manager = [download_data objectForKey:id];
    if(download_manager == nil) {
        return;
    }
    [download_manager pause];
}
+ (void)resume:(NSString *)id {
    if(download_data == nil) {
        return;
    }
    Download_Manager *download_manager = [download_data objectForKey:id];
    if(download_manager == nil) {
        return;
    }
    [download_manager resume];
}
+ (NSString *)resume:(NSString *)filename
                 URL:(NSString *)url
            Delegate:(id<Download_Delegate>)delegate {
    Download_Manager *download_manager = [[Download_Manager alloc] init];
    download_manager.delegate = delegate;
    [download_manager resume:filename
                         URL:url];
    NSString *id = [Secure_Controller MD5:[NSString stringWithFormat:@"%.f", [Global_Controller getUTCTimestamp]]];
    if(download_data == nil) {
        download_data = [[NSMutableDictionary alloc] init];
    }
    [download_data setObject:download_manager forKey:id];
    return id;
}
+ (bool)isExisted:(NSString *)id {
    if(download_data == nil) {
        return false;
    }
    Download_Manager *download_manager = [download_data objectForKey:id];
    if(download_manager == nil) {
        return false;
    }else {
        return true;
    }
}
+ (bool)isDownloading:(NSString *)id {
    if(download_data == nil) {
        return false;
    }
    Download_Manager *download_manager = [download_data objectForKey:id];
    if(download_manager == nil) {
        return false;
    }else {
        return [download_manager isDownloading];
    }
}
+ (void)setDelegate:(NSString *)id
           Delegate:(id<Download_Delegate>)delegate {
    if(download_data == nil) {
        return;
    }
    Download_Manager *download_manager = [download_data objectForKey:id];
    if(download_manager == nil) {
        return;
    }
    download_manager.delegate = delegate;
}
@end