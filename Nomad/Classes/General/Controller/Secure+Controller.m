#import "Secure+Controller.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "NSData+Base64.h"
@implementation Secure_Controller
static const int buffer_size = 10240;
+ (NSString *)MD5:(NSString *)value {
    const char* str = [value UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (int)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}
+ (NSString *)encrypt:(NSString *)value {
    NSError *error;
    NSData *cipher_text = [RNEncryptor encryptData:[value dataUsingEncoding:NSUTF8StringEncoding] withSettings:kRNCryptorAES256Settings password:secure_key error:&error];
    if(error) {
        return text_blank;
    }else {
        NSString *text = [cipher_text base64EncodedStringWithOptions:0];
        return text;
    }
}
+ (NSString *)decrypt:(NSString *)value {
    NSError *error;
    NSData *decrypt_text = [RNDecryptor decryptData:[[NSData alloc] initWithBase64EncodedString:value options:0] withSettings:kRNCryptorAES256Settings password:secure_key error:&error];
    if(error) {
        return text_blank;
    }else {
        NSString *text = [[NSString alloc] initWithData:decrypt_text encoding:NSUTF8StringEncoding];
        return text;
    }
}
+ (void)decryptVideo:(VideoType)video_type
              Source:(NSString *)source_path
         Destination:(NSString *)destination_path
            Complete:(void(^)(NSOutputStream *))completeHandler {
    NSInputStream *input_stream = [NSInputStream inputStreamWithFileAtPath:source_path];
    NSOutputStream *output_stream = [NSOutputStream outputStreamToMemory];
    [output_stream open];
    [input_stream open];
    while([input_stream hasBytesAvailable] && [output_stream hasSpaceAvailable]) {
        @autoreleasepool
        {
            uint8_t buf[buffer_size];
            NSUInteger bytes_read = [input_stream read:buf maxLength:buffer_size];
            if(bytes_read > 0) {
                NSData *data = [NSData dataWithBytes:buf length:bytes_read];
                [output_stream write:data.bytes maxLength:buffer_size];
            }
        }
    }
    [input_stream close];
    [output_stream close];
    completeHandler(output_stream);
}
@end