#import <MRProgress/MRCircularProgressView.h>
#import <MarqueeLabel/MarqueeLabel.h>
#import "Download+Controller.h"
#import "Download+Model.h"
#import "Purchased+Model.h"
@protocol Download_List_Cell_Delegate
@required
- (void)didDownloadListCellPlay:(id)cell
                       Download:(Download_Model *)download_model;
- (void)didDownloadListCellPlay:(id)cell
                      Purchased:(Purchased_Model *)purchased_model;
@end
@interface Download_List_Cell : UITableViewCell <Download_Delegate>
@property (nonatomic, assign) id<Download_List_Cell_Delegate> delegate;
@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) IBOutlet MarqueeLabel *lbl_title;
@property (nonatomic, strong) IBOutlet UILabel *lbl_description;
@property (nonatomic, strong) IBOutlet UILabel *lbl_size;
@property (nonatomic, strong) IBOutlet UIButton *btn_play;
@property (nonatomic, strong) IBOutlet MRCircularProgressView *cgv_download;
- (void)set:(id)model
   Delegate:(id<Download_List_Cell_Delegate>)delegate;
- (void)setDownload:(bool)show;
@end