#import "Download+List+Controller.h"
#import "Download+Controller.h"
#import "Secure+Controller.h"
#import "Query+Controller.h"
#import "File+Controller.h"
@interface Download_List_Controller()
<Download_List_Cell_Delegate,
Alert_Delegate>
@end
typedef NS_ENUM(NSInteger, Alert_Status) {
    OnOffDownloadAlertStatusCode
};
@implementation Download_List_Controller {
@private
    Download_List_Cell *selected_cell;
    Purchased_Model *purchased_data;
    NSMutableArray *download_list;
    Alert_Status alert_status;
}
- (void)didAlertActioned:(NSInteger)index {
    switch (alert_status) {
        case OnOffDownloadAlertStatusCode:
        {
            if(index == question_yes) {
                NSString *download_id = [Download_Controller start:[Secure_Controller decrypt:purchased_data.url]
                                                          Delegate:selected_cell];
                Download_Model *download_model =
                [Download_Model init:download_id
                             VideoID:purchased_data.video_id
                           VideoType:purchased_data.video_type
                               Title:purchased_data.title
                            Filename:purchased_data.filename
                                 URL:purchased_data.url
                                 Log:[Global_Controller getUTCTimestamp]
                              Expiry:purchased_data.expiry];
                [Query_Controller addDownload:download_model];
            }else if(index == question_no) {
                [self playVideo:purchased_data];
            }
            break;
        }
        default:
            break;
    }
}
- (void)didAlertCancelled {}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [download_list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    static NSString *download_list_id = @"DownloadListID";
    Download_List_Cell *cell = (Download_List_Cell *)[tableView dequeueReusableCellWithIdentifier:download_list_id];
    if(cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"Download+List+Cell" owner:self options:nil];
        cell = self.download_list_cell;
    }
    [cell set:[download_list objectAtIndex:row]
     Delegate:self];
    [Global_Controller setSelectedCell:cell Color:[UIColor colorWithRed:66.0f/255.0f green:189.0f/255.0f blue:222.0f/255.0 alpha:1.0f]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self setSelected:row];
}
- (void)didDownloadListCellPlay:(id)cell
                       Download:(Download_Model *)download_model {
    [self setDownload:cell
             Download:download_model];
}
- (void)didDownloadListCellPlay:(id)cell
                      Purchased:(Purchased_Model *)purchased_model {
    [App_Controller showLoading:self];
    [Global_Controller getContentLength:[Secure_Controller decrypt:purchased_model.url]
    Complete:^(long long size) {
        [App_Controller closeLoading];
        if(size == 0) {
            [App_Controller showAlert:[App_Controller getTitle:@"title_warning"]
                              Message:[App_Controller getError:@"error_video_not_found"]
                             Delegate:nil];
        }else {
            selected_cell = cell;
            purchased_data = purchased_model;
            alert_status = OnOffDownloadAlertStatusCode;
            NSString *total_file_size = [NSString stringWithFormat:@"%@ MBytes", [Global_Controller format:((float)size / 1048576)]];
            NSString *message = [NSString stringWithFormat:[App_Controller getMessage:@"message_onoff_video"], total_file_size];
            [App_Controller showQuestion:[App_Controller getTitle:@"title_app"]
                                 Message:message
                                Delegate:self];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Global_Controller setDefaultBacgroundWithLogo:self.navigationController];
    [Global_Controller setImageLeftButton:self ImageNamed:@"Icon-Menu-Back" Title:text_blank Action:@selector(doBack:)];
    download_list = [Query_Controller getDownloadList];
    NSMutableArray *purchased_list = [Query_Controller getPurchasedList];
    if(purchased_list != nil) {
        if([purchased_list count] > 0) {
            [download_list addObjectsFromArray:purchased_list];
        }
    }
}
- (IBAction)doBack:(id)sender {
    for(id model in download_list) {
        if([model isKindOfClass:[Download_Model class]]) {
            Download_Model *download_model = (Download_Model *)model;
            [Download_Controller setDelegate:download_model.id
                                    Delegate:nil];
        }
    }
    [self.navigationController popViewControllerAnimated:true];
}
- (void)setSelected:(NSInteger)index {
    NSIndexPath *index_path = [NSIndexPath indexPathForRow:index inSection:0];
    Download_List_Cell *cell = [self.lst_download cellForRowAtIndexPath:index_path];
    id model = [download_list objectAtIndex:index];
    if([model isKindOfClass:[Download_Model class]]) {
        [self setDownload:cell
                 Download:model];
    }else if([model isKindOfClass:[Purchased_Model class]]) {
    }
}
- (void)setDownload:(Download_List_Cell *)cell
           Download:(Download_Model *)download_model {
    if([Download_Controller isDownloading:download_model.id]) {
        [Download_Controller pause:download_model.id];
        [cell setDownload:false];
    }else {
        [App_Controller showLoading:self];
        [Global_Controller getContentLength:[Secure_Controller decrypt:download_model.url]
        Complete:^(long long size) {
            [App_Controller closeLoading];
            [self beginDownload:cell
                       Download:download_model
                           Size:size];
        }];
    }
}
- (void)beginDownload:(Download_List_Cell *)cell
             Download:(Download_Model *)download_model
                 Size:(long long)size {
    long long file_size = [File_Controller getFileSize:download_model.filename];
    if(file_size == size) {
        [self playVideo:download_model];
    }else {
        [cell setDownload:true];
        if([Download_Controller isExisted:download_model.id]) {
            [Download_Controller resume:download_model.id];
        }else {
            NSString *download_id = [Download_Controller resume:download_model.filename
                                                            URL:[Secure_Controller decrypt:download_model.url]
                                                       Delegate:cell];
            [Query_Controller updateDownloadByVideoID:download_model.video_id
                                            VideoType:download_model.video_type
                                                   ID:download_id
                                               Expiry:download_model.expiry];
            download_model.id = download_id;
        }
    }
}
- (void)playVideo:(id)model {
    Video_Player_Model *video_player_model;
    if([model isKindOfClass:[Download_Model class]]) {
        Download_Model *download_model = (Download_Model *)model;
        video_player_model = [App_Controller generateVideoPlayerData:download_model.filename
                                                           VideoType:download_model.video_type
                                                               Title:download_model.title
                                                                 URL:download_model.url];
    }else if([model isKindOfClass:[Purchased_Model class]]) {
        Purchased_Model *purchased_model = (Purchased_Model *)model;
        video_player_model = [App_Controller generateVideoPlayerData:purchased_model.filename
                                                           VideoType:purchased_model.video_type
                                                               Title:purchased_model.title
                                                                 URL:[Secure_Controller decrypt:purchased_model.url]];
    }
    [App_Controller openVideoPlayer:self
                              Video:video_player_model];
}
@end