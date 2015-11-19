#import "Home+Landscape+3+View.h"
#import "URL+Manager.h"
#import "Serial+Model.h"
#import "Movie+Model.h"
@implementation Home_Landscape_3_View {
@private
    NSMutableArray *list;
    VideoType _video_type;
    NSString *_url;
    float super_width;
}
- (id)init {
    Home_Landscape_3_View *home_landscape_3_view = [[[NSBundle mainBundle] loadNibNamed:@"Home+Landscape+3+View" owner:nil options:nil] objectAtIndex:0];
    if([home_landscape_3_view isKindOfClass:[Home_Landscape_3_View class]]) {
        return home_landscape_3_view;
    }else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 167;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    static NSString *home_landscape_3_list_id = @"HomeLandscape3ListID";
    Home_Landscape_3_Cell *cell = (Home_Landscape_3_Cell *)[tableView dequeueReusableCellWithIdentifier:home_landscape_3_list_id];
    if(cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"Home+Landscape+3+Cell" owner:self options:nil];
        cell = self.home_landscape_3_cell;
    }
    id model = [list objectAtIndex:row];
    [cell set:model];
    [Global_Controller setSelectedCell:cell Color:[UIColor redColor]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self setSelected:row];
}
- (IBAction)doRefresh:(id)sender {
    [self setRefresh:false];
    [self request:_url
        VideoType:_video_type
         UpdateUI:true];
}
- (void)show:(NSString *)key
  CategoryID:(long)category_id
         URL:(NSString *)url
   VideoType:(VideoType)video_type
       Width:(float)width {
    super_width = width;
    url = [NSString stringWithFormat:url, category_id];
    if([App_Controller isSessionHome:url]) {
        _video_type = video_type;
        _url = url;
        list = [App_Controller getSessionHome:url];
        [self setLoading:false];
        [self setRefresh:false];
        [self.lst_main reloadData];
        [self request:url
            VideoType:video_type
             UpdateUI:false];
    }else {
        [self request:url
            VideoType:video_type
             UpdateUI:true];
    }
}
- (void)request:(NSString *)url
      VideoType:(VideoType)video_type
       UpdateUI:(bool)update_ui {
    if(update_ui) {
        [self setLoading:true];
    }
    [URL_Manager Get:url
             Headers:nil
    Complete:^(NSDictionary *response) {
        if(video_type == MovieVideoType) {
            Movie_Model *movie_model = [Movie_Model init:[response objectForKey:@"data"]];
            list = movie_model.movie_list;
        }else if(video_type == SerialVideoType) {
            Serial_Model *serial_model = [Serial_Model init:[response objectForKey:@"data"]];
            list = serial_model.serial_list;
        }
        if(list != nil) {
            [App_Controller setSessionHome:url
                                      List:list];
            if(update_ui) {
                [self setLoading:false];
                [self setRefresh:false];
                [self.lst_main reloadData];
            }
        }
    } Failed:^(NSString *message) {
        if(update_ui) {
            [self setLoading:false];
            _video_type = video_type;
            _url = url;
            [self setRefresh:true];
        }
    } Error:^(NSInteger status_code, NSDictionary *response) {
        if(update_ui) {
            [self setLoading:false];
            _video_type = video_type;
            _url = url;
            [self setRefresh:true];
        }
    }];
}
- (void)setSelected:(NSInteger)index {
    if(self.layout_menu_controller_delegate != nil) {
        if([(NSObject *)self.layout_menu_controller_delegate respondsToSelector:@selector(didLayoutMenuLandscapeSelected:)]) {
            id model = [list objectAtIndex:index];
            [self.layout_menu_controller_delegate didLayoutMenuLandscapeSelected:model];
        }
    }
}
- (void)setLoading:(bool)show {
    [self.vw_loading setHidden:!show];
}
- (void)setRefresh:(bool)show {
    [self.vw_refresh setHidden:!show];
}
@end