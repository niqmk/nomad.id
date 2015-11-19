@interface File_Controller : NSObject
+ (long long)getFileSize:(NSString *)filename;
+ (long long)getFileSizeFromPath:(NSString *)path;
+ (NSString *)getURLFilename:(NSString *)url;
+ (NSString *)getDownloadPath:(NSString *)url;
+ (NSString *)getFilenameFromURL:(NSString *)url;
+ (NSString *)getPath:(NSString *)filename;
+ (bool)isFileExist:(NSString *)path;
+ (bool)isFileExistFromURL:(NSString *)url;
+ (NSString *)getTempPath:(NSString *)filename;
+ (void)cleanTempPath;
@end