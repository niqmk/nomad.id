#import "Video+Profile+View.h"
#import "Modal+Controller.h"
@implementation Video_Profile_View {
@private
    UIViewController *controller;
    NSDictionary *video_profile_data;
}
- (id)init {
    Video_Profile_View *video_profile_view = [[[NSBundle mainBundle] loadNibNamed:@"Video+Profile+View" owner:nil options:nil] objectAtIndex:0];
    if([video_profile_view isKindOfClass:[Video_Profile_View class]]) {
        return video_profile_view;
    }else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [video_profile_data count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *video_profile_list_id = @"VideoProfileListID";
    Video_Profile_Cell *cell = (Video_Profile_Cell *)[tableView dequeueReusableCellWithIdentifier:video_profile_list_id];
    if(cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"Video+Profile+Cell" owner:self options:nil];
        cell = self.video_profile_cell;
    }
    NSArray *keys = [video_profile_data allKeys];
    NSString *value = [keys objectAtIndex:0];
    [cell set:value];
    [Global_Controller setSelectedCell:cell Color:[UIColor colorWithRed:66.0f/255.0f green:189.0f/255.0f blue:222.0f/255.0 alpha:1.0f]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self setSelected:row];
}
- (void)show:(UIViewController *)view_controller
        Data:(NSDictionary *)data
    Delegate:(id<Video_Profile_View_Delegate>)delegate {
    controller = view_controller;
    video_profile_data = data;
    self.delegate = delegate;
    [self.vw_main rounded];
}
- (IBAction)doCancel:(id)sender {
    [Modal_Controller close];
    if(self.delegate != nil) {
        [self.delegate didVideoProfileViewCancelled];
    }
}
- (void)setSelected:(NSInteger)index {
    if(self.delegate != nil) {
        [self.delegate didVideoProfileViewSelected:index];
    }
}
@end