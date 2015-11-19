#import "Download+Manager.h"
@interface Download_Controller : NSObject
+ (NSString *)start:(NSString *)url
           Delegate:(id<Download_Delegate>)delegate;
+ (void)stop:(NSString *)id;
+ (void)pause:(NSString *)id;
+ (void)resume:(NSString *)id;
+ (NSString *)resume:(NSString *)filename
                 URL:(NSString *)url
            Delegate:(id<Download_Delegate>)delegate;
+ (bool)isExisted:(NSString *)id;
+ (bool)isDownloading:(NSString *)id;
+ (void)setDelegate:(NSString *)id
           Delegate:(id<Download_Delegate>)delegate;
@end