@protocol Download_Delegate <NSObject>
@required
- (void)didDownloadProgressing:(NSUInteger)bytes_read
                TotalBytesRead:(long long)total_bytes_read
        TotalBytesExpectedRead:(long long)total_bytes_expected_read;
- (void)didDownloadCompleted:(NSString *)filename;
- (void)didDownloadFailed:(NSError *)error;
@end
@interface Download_Manager : NSObject
@property (nonatomic, assign) id<Download_Delegate> delegate;
- (NSString *)start:(NSString *)url;
- (void)stop;
- (void)pause;
- (void)resume;
- (void)resume:(NSString *)filename
           URL:(NSString *)url;
- (bool)isDownloading;
@end