#import "File+Controller.h"
#import "Secure+Controller.h"
@implementation File_Controller
+ (long long)getFileSize:(NSString *)filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:filename];
    return [File_Controller getFileSizeFromPath:path];
}
+ (long long)getFileSizeFromPath:(NSString *)path {
    NSError *error;
    NSDictionary *file_attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
    if(error) {
        return 0;
    }else {
        NSNumber *file_size_number = [file_attributes objectForKey:NSFileSize];
        long long file_size = [file_size_number longLongValue];
        return file_size;
    }
}
+ (NSString *)getURLFilename:(NSString *)url {
    NSString *filename = [url lastPathComponent];
    return filename;
}
+ (NSString *)getDownloadPath:(NSString *)url {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *url_filename = [File_Controller getURLFilename:url];
    NSArray *separate = [url_filename componentsSeparatedByString:@"."];
    NSString *filename = [NSString stringWithFormat:@"%@.%@", [Secure_Controller MD5:[separate objectAtIndex:0]], [separate objectAtIndex:1]];
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:filename];
    return path;
}
+ (NSString *)getFilenameFromURL:(NSString *)url {
    NSString *url_filename = [File_Controller getURLFilename:url];
    NSArray *separate = [url_filename componentsSeparatedByString:@"."];
    return [NSString stringWithFormat:@"%@.%@", [Secure_Controller MD5:[separate objectAtIndex:0]], [separate objectAtIndex:1]];
}
+ (NSString *)getPath:(NSString *)filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:filename];
    return path;
}
+ (bool)isFileExist:(NSString *)filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSFileManager *file_manager = [NSFileManager defaultManager];
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:filename];
    return [file_manager fileExistsAtPath:path];
}
+ (bool)isFileExistFromURL:(NSString *)url {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *url_filename = [File_Controller getURLFilename:url];
    NSArray *separate = [url_filename componentsSeparatedByString:@"."];
    NSString *filename = [NSString stringWithFormat:@"%@.%@", [Secure_Controller MD5:[separate objectAtIndex:0]], [separate objectAtIndex:1]];
    NSFileManager *file_manager = [NSFileManager defaultManager];
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:filename];
    return [file_manager fileExistsAtPath:path];
}
+ (NSString *)getTempPath:(NSString *)filename {
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
    return path;
}
+ (void)cleanTempPath {
    NSArray *directories = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
    for (NSString *file in directories) {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), file] error:NULL];
    }
}
@end