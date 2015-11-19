#import "SQL+Controller.h"
#import "Download+Model.h"
#import "Purchased+Model.h"
@interface Query_Controller : NSObject
#pragma - Download
+ (NSMutableArray *)getDownloadList;
+ (Download_Model *)getDownload:(long)video_id
                      VideoType:(VideoType)video_type;
+ (void)addDownload:(Download_Model *)download_model;
+ (void)updateDownloadExpiry:(long)video_id
                   VideoType:(VideoType)video_type
                      Expiry:(long)expiry;
+ (void)updateDownloadByVideoID:(long)video_id
                      VideoType:(VideoType)video_type
                             ID:(NSString *)id
                         Expiry:(long)expiry;
+ (void)deleteDownload:(NSString *)id;
+ (void)truncateDownload;
#pragma - Purchased
+ (NSMutableArray *)getPurchasedList;
+ (Purchased_Model *)getPurchased:(long)video_id
                        VideoType:(VideoType)video_type;
+ (void)addPurchased:(Purchased_Model *)purchased_model;
+ (void)updatePurchasedExpiry:(long)video_id
                    VideoType:(VideoType)video_type
                       Expiry:(long)expiry;
+ (void)updatePurchasedByVideoID:(long)video_id
                       VideoType:(VideoType)video_type
                              ID:(long)id
                          Expiry:(long)expiry;
+ (void)deletePurchased:(long)id;
+ (void)truncatePurchased;
@end