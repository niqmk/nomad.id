#import "Download+List+Cell.h"
#import "File+Controller.h"
#import "Query+Controller.h"
#import "Secure+Controller.h"
#import "Video+Controller.h"
@implementation Download_List_Cell {
@private
    id data;
    long long file_size;
    long long init_file_size;
}
- (void)didDownloadCompleted:(NSString *)filename {
    [self setDownload:false];
}
- (void)didDownloadFailed:(NSError *)error {
    [self setDownload:false];
}
- (void)didDownloadProgressing:(NSUInteger)bytes_read
                TotalBytesRead:(long long)total_bytes_read
        TotalBytesExpectedRead:(long long)total_bytes_expected_read {
    float percentage = (float)(init_file_size + total_bytes_read)/file_size;
    [self.cgv_download setProgress:percentage
                          animated:true];
    if(percentage > 0.1f && percentage < 1.0f) {
        [self.cgv_download.valueLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:10.0f]];
    }else if(percentage >= 1.0f) {
        [self.cgv_download.valueLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:8.0f]];
    }
    [self setSize:(init_file_size + total_bytes_read)];
}
- (IBAction)doPlay:(id)sender {
    if(self.delegate != nil) {
        if([data isKindOfClass:[Download_Model class]]) {
            Download_Model *download_model = (Download_Model *)data;
            [self.delegate didDownloadListCellPlay:self
                                          Download:download_model];
        }else if([data isKindOfClass:[Purchased_Model class]]) {
            Purchased_Model *purchased_model = (Purchased_Model *)data;
            [self.delegate didDownloadListCellPlay:self
                                         Purchased:purchased_model];
        }
    }
}
- (void)set:(id)model
   Delegate:(id<Download_List_Cell_Delegate>)delegate {
    data = model;
    self.delegate = delegate;
    if([model isKindOfClass:[Download_Model class]]) {
        Download_Model *download_model = (Download_Model *)model;
        [self.lbl_title setText:download_model.title];
        if(download_model.expiry > 0) {
            if(download_model.expiry >= [Global_Controller getUTCTimestamp]) {
                [self.lbl_description setText:[NSString stringWithFormat:[App_Controller getLabel:@"label_expiry"], [Global_Controller getDate:[Global_Controller getDate:download_model.expiry] Format:long_date_format]]];
            }else {
                [self.lbl_description setText:[App_Controller getLabel:@"label_expired"]];
                [self.lbl_description setTextColor:[UIColor redColor]];
            }
        }else {
            [self.lbl_description setText:[App_Controller getLabel:@"label_no_expiry"]];
        }
        init_file_size = [File_Controller getFileSize:download_model.filename];
        [self setSize:init_file_size];
        [self checkDownload];
    }else if([model isKindOfClass:[Purchased_Model class]]) {
        Purchased_Model *purchased_model = (Purchased_Model *)model;
        [self.lbl_title setText:purchased_model.title];
        if(purchased_model.expiry > 0) {
            if(purchased_model.expiry >= [Global_Controller getUTCTimestamp]) {
                [self.lbl_description setText:[NSString stringWithFormat:[App_Controller getLabel:@"label_expiry"], [Global_Controller getDate:[Global_Controller getDate:purchased_model.expiry] Format:long_date_format]]];
            }else {
                [self.lbl_description setText:[App_Controller getLabel:@"label_expired"]];
                [self.lbl_description setTextColor:[UIColor redColor]];
            }
        }else {
            [self.lbl_description setText:[App_Controller getLabel:@"label_no_expiry"]];
        }
        [self.lbl_size setText:[App_Controller getLabel:@"label_get_play_length"]];
        dispatch_queue_t queue = dispatch_queue_create("PlayLength", NULL);
        dispatch_async(queue, ^{
            float play_length = [Video_Controller getDuration:[Secure_Controller decrypt:purchased_model.url]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.lbl_size setText:[NSString stringWithFormat:[App_Controller getLabel:@"label_play_length"], play_length / 60]];
            });
        });
    }
}
- (void)setDownload:(bool)show {
    [self.cgv_download setHidden:!show];
    [self.btn_play setHidden:show];
}
- (void)checkDownload {
    if(data != nil) {
        if([data isKindOfClass:[Download_Model class]]) {
            Download_Model *download_model = (Download_Model *)data;
            [Global_Controller getContentLength:[Secure_Controller decrypt:download_model.url]
            Complete:^(long long size) {
                file_size = size;
                [self setSize:init_file_size];
            }];
            if([Download_Controller isDownloading:download_model.id]) {
                [self setDownload:true];
                [Download_Controller setDelegate:download_model.id
                                        Delegate:self];
            }
        }
    }
}
- (void)setSize:(long long)size {
    NSString *current_file_size = [NSString stringWithFormat:@"%@ MBytes", [Global_Controller format:((float)size / 1048576)]];
    if(file_size > 0) {
        NSString *total_file_size = [NSString stringWithFormat:@"%@ MBytes", [Global_Controller format:((float)file_size / 1048576)]];
        [self.lbl_size setText:[NSString stringWithFormat:@"(%@ of %@)", current_file_size, total_file_size]];
    }else {
        [self.lbl_size setText:current_file_size];
    }
}
@end