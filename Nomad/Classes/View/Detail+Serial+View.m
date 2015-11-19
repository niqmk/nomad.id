#import "Detail+Serial+View.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Layout+Controller.h"
#import "Serial+Episode+Model.h"
@implementation Detail_Serial_View {
@private
    Serial_Detail_Model *serial_detail_data;
    float super_width;
    bool init_play_from_downloading;
    NSMutableArray *section_opened;
}
- (id)init {
    Detail_Serial_View *detail_serial_view = [[[NSBundle mainBundle] loadNibNamed:@"Detail+Serial+View" owner:nil options:nil] objectAtIndex:0];
    if([detail_serial_view isKindOfClass:[Detail_Serial_View class]]) {
        return detail_serial_view;
    }else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    Serial_Episode_Model *serial_episode_list = [serial_detail_data.episodes objectAtIndex:section];
    [label setText:serial_episode_list.title];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    button.tag = section;
    [button addTarget:self action:@selector(doSectionSelected:) forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    [view addSubview:label];
    [view addSubview:button];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]];
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [serial_detail_data.episodes count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Serial_Episode_Model *serial_episode_list = [serial_detail_data.episodes objectAtIndex:section];
    if(section_opened != nil) {
        if([section_opened containsObject:[NSNumber numberWithInteger:section]]) {
            return [serial_episode_list.data count];
        }else {
            return 0;
        }
    }else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    static NSString *serial_episode_list_id = @"SerialEpisodeListID";
    Serial_Episode_Cell *cell = (Serial_Episode_Cell *)[tableView dequeueReusableCellWithIdentifier:serial_episode_list_id];
    if(cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"Serial+Episode+Cell" owner:self options:nil];
        cell = self.serial_episode_cell;
    }
    Serial_Episode_Model *serial_episode_list = [serial_detail_data.episodes objectAtIndex:indexPath.section];
    Serial_Detail_Model *serial_detail_model = [serial_episode_list.data objectAtIndex:row];
    [cell set:serial_detail_model];
    [Global_Controller setSelectedCell:cell Color:[UIColor colorWithRed:66.0f/255.0f green:189.0f/255.0f blue:222.0f/255.0 alpha:1.0f]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self setSelected:indexPath];
}
- (IBAction)doLike:(id)sender {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didDetailSerialViewLike:)]) {
            [self.delegate didDetailSerialViewLike:[self.btn_like isSelected]];
        }
    }
}
- (IBAction)doPlay:(id)sender {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didDetailSerialViewPlay)]) {
            [self.delegate didDetailSerialViewPlay];
        }
    }
}
- (IBAction)doPauseDownload:(id)sender {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didDetailSerialViewPauseDownload)]) {
            [self.delegate didDetailSerialViewPauseDownload];
        }
    }
    [self setDownload:false];
}
- (IBAction)doPause:(id)sender {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didDetailSerialViewPauseVideo)]) {
            [self.delegate didDetailSerialViewPauseVideo];
        }
    }
}
- (IBAction)doSectionSelected:(id)sender {
    UIButton *clicked = (UIButton *)sender;
    if(section_opened == nil) {
        section_opened = [[NSMutableArray alloc] init];
    }
    if([section_opened containsObject:[NSNumber numberWithInteger:clicked.tag]]) {
        [section_opened removeObject:[NSNumber numberWithInteger:clicked.tag]];
    }else {
        [section_opened addObject:[NSNumber numberWithInteger:clicked.tag]];
    }
    NSRange range = NSMakeRange(0, [self numberOfSectionsInTableView:self.lst_episodes]);
    NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.lst_episodes reloadSections:sections withRowAnimation:UITableViewRowAnimationNone];
    [self setLayout];
}
- (IBAction)changeSlider:(id)sender {
    [self doPause:self];
}
- (IBAction)changeTopSlider:(id)sender {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didDetailSerialViewSeekVideo:)]) {
            [self.delegate didDetailSerialViewSeekVideo:self.sld_player.value];
        }
    }
}
- (void)show:(Serial_Detail_Model *)serial_detail_model
       Width:(float)width {
    super_width = width;
    serial_detail_data = serial_detail_model;
    section_opened = [[NSMutableArray alloc] init];
    for(NSInteger counter = 0; counter < [serial_detail_data.episodes count]; counter++) {
        [section_opened addObject:[NSNumber numberWithInteger:counter]];
    }
    [self setLayout:serial_detail_model
             Layout:true];
}
- (void)setDownload:(bool)show {
    [self.cgv_download setHidden:!show];
    [self.btn_play setHidden:show];
    init_play_from_downloading = false;
}
- (void)setDownloadProgressing:(float)percentage {
    [self.cgv_download setProgress:percentage
                          animated:true];
    if(percentage > 0.1f && percentage < 1.0f) {
        [self.cgv_download.valueLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:10.0f]];
    }else if(percentage >= 1.0f) {
        [self.cgv_download.valueLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:8.0f]];
    }
    if(percentage == INFINITY) {
        return;
    }
    if(percentage >= default_min_percentage_play_video) {
        if(!init_play_from_downloading) {
            init_play_from_downloading = true;
            if(self.delegate != nil) {
                if([(NSObject *)self.delegate respondsToSelector:@selector(didDetailSerialViewPlayVideo)]) {
                    [self.delegate didDetailSerialViewPlayVideo];
                }
            }
        }
    }
}
- (void)setPlayerView:(bool)show {
    [self.vw_player setHidden:!show];
}
- (void)setPlayFulltime:(bool)show {
    [self.vw_player setHidden:!show];
    [self.btn_play setHidden:show];
}
- (void)setLoading:(bool)show {
    if(show) {
        [self.pgb_loading startAnimating];
    }else {
        [self.pgb_loading stopAnimating];
    }
}
- (void)setSliderValue:(float)time {
    self.sld_player.value = time;
}
- (void)setSliderDuration:(float)duration {
    if(isnan(duration)) {
        return;
    }
    self.sld_player.maximumValue = duration;
    self.sld_player.value = 0.0;
}
- (void)rollback {
    [self setLayout:serial_detail_data
             Layout:false];
}
- (void)setLayout:(Serial_Detail_Model *)serial_detail_model
           Layout:(bool)layout {
    [self setImageData:serial_detail_model];
    [self.lbl_title setText:serial_detail_model.title];
    self.sld_player.maximumValue = 0.0;
    self.sld_player.value = 0.0;
    if(serial_detail_model.log_on_member != nil) {
        [self.btn_like setSelected:serial_detail_model.log_on_member.is_liked];
    }
    if(layout) {
        [self setLayout];
    }
}
- (void)setLayout {
    NSInteger total = [serial_detail_data.episodes count] * 31;
    if(section_opened != nil) {
        NSInteger section = -1;
        for(Serial_Episode_Model *serial_episode_model in serial_detail_data.episodes) {
            section++;
            if([section_opened containsObject:[NSNumber numberWithInteger:section]]) {
                total += ([serial_episode_model.data count] * 60);
            }
        }
    }
    self.lst_episodes.frame = CGRectMake(0, self.vw_action.frame.origin.y + self.vw_action.frame.size.height, super_width, total);
    if(![self.scv_main.subviews containsObject:self.lst_episodes]) {
        [self.scv_main addSubview:self.lst_episodes];
    }
    self.scv_main.contentSize = CGSizeMake(super_width, self.lst_episodes.frame.origin.y + self.lst_episodes.frame.size.height);
}
- (void)setSelected:(NSIndexPath *)index_path {
    NSInteger row = [index_path row];
    Serial_Episode_Model *serial_episode_list = [serial_detail_data.episodes objectAtIndex:index_path.section];
    Serial_Detail_Model *serial_detail_model = [serial_episode_list.data objectAtIndex:row];
    [self setLayout:serial_detail_model
             Layout:false];
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didDetailSerialViewChangeEpisode:)]) {
            [self.delegate didDetailSerialViewChangeEpisode:serial_detail_model];
        }
    }
}
- (void)setImageData:(Serial_Detail_Model *)serial_detail_model {
    NSString *image_url = text_blank;
    if([Global_Controller isNotNull:[serial_detail_model.images objectForKey:@"by_width"]]) {
        image_url = [[serial_detail_model.images objectForKey:@"by_width"] stringByReplacingOccurrencesOfString:@"{width}" withString:[NSString stringWithFormat:@"%.f", super_width]];
    }else if([serial_detail_model.images objectForKey:@"youtube"] != nil) {
        image_url = [[serial_detail_model.images objectForKey:@"youtube"] objectForKey:@"hq"];
    }
    [self.image sd_setImageWithURL:[NSURL URLWithString:image_url] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageCacheMemoryOnly];
}
@end