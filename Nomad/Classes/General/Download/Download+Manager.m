#import "Download+Manager.h"
#import <AFNetworking/AFNetworking.h>
#import "File+Controller.h"
@implementation Download_Manager {
@private
    AFHTTPRequestOperation *operation;
}
- (NSString *)start:(NSString *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    NSString *path = [File_Controller getDownloadPath:url];
    __weak __typeof(self)weakSelf = self;
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:path append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        if(weakSelf.delegate != nil) {
            [weakSelf.delegate didDownloadProgressing:bytesRead
                                       TotalBytesRead:totalBytesRead
                               TotalBytesExpectedRead:totalBytesExpectedToRead];
        }
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(weakSelf.delegate != nil) {
            [weakSelf.delegate didDownloadCompleted:path];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(weakSelf.delegate != nil) {
            [weakSelf.delegate didDownloadFailed:error];
        }
    }];
    operation.queuePriority = NSOperationQueuePriorityLow;
    [operation start];
    return path;
}
- (void)stop {
    if(operation != nil) {
        if([operation isExecuting]) {
            [operation cancel];
        }
    }
    operation = nil;
}
- (void)pause {
    if(operation != nil) {
        if([operation isExecuting]) {
            [operation pause];
        }
    }
}
- (void)resume {
    if(operation != nil) {
        if([operation isPaused]) {
            [operation resume];
        }
    }
}
- (void)resume:(NSString *)filename
           URL:(NSString *)url {
    NSString *path = [File_Controller getPath:filename];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    NSString *request_range = [NSString stringWithFormat:@"bytes=%llu-", [File_Controller getFileSize:filename]];
    [request setValue:request_range forHTTPHeaderField:@"Range"];
    operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    __weak __typeof(self)weakSelf = self;
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:path append:YES]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        if(weakSelf.delegate != nil) {
            [weakSelf.delegate didDownloadProgressing:bytesRead
                                       TotalBytesRead:totalBytesRead
                               TotalBytesExpectedRead:totalBytesExpectedToRead];
        }
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(weakSelf.delegate != nil) {
            [weakSelf.delegate didDownloadCompleted:path];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(weakSelf.delegate != nil) {
            [weakSelf.delegate didDownloadFailed:error];
        }
    }];
    operation.queuePriority = NSOperationQueuePriorityLow;
    [operation start];
}
- (bool)isDownloading {
    if(operation == nil) {
        return false;
    }
    return [operation isExecuting];
}
@end