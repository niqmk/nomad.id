#import "RNCryptor/RNDecryptor.h"
#import "RNCryptor/RNEncryptor.h"
@interface Secure_Controller : NSObject
+ (NSString *)MD5:(NSString *)value;
+ (NSString *)encrypt:(NSString *)value;
+ (NSString *)decrypt:(NSString *)value;
+ (void)decryptVideo:(VideoType)video_type
              Source:(NSString *)source_path
         Destination:(NSString *)destination_path
            Complete:(void(^)(NSOutputStream *output_stream))completeHandler;
@end