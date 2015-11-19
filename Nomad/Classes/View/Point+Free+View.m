#import "Point+Free+View.h"
#import "URL+Manager.h"
@implementation Point_Free_View {
@private
    Free_Point_Model *free_point_data;
}
- (id)init {
    Point_Free_View *point_free_view = [[[NSBundle mainBundle] loadNibNamed:@"Point+Free+View" owner:nil options:nil] objectAtIndex:0];
    if([point_free_view isKindOfClass:[Point_Free_View class]]) {
        return point_free_view;
    }else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [free_point_data.free_point_list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    static NSString *point_free_list_id = @"PointFreeListID";
    Point_Free_Cell *cell = (Point_Free_Cell *)[tableView dequeueReusableCellWithIdentifier:point_free_list_id];
    if(cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"Point+Free+Cell" owner:self options:nil];
        cell = self.point_free_cell;
    }
    Free_Point_Model *free_point_model = [free_point_data.free_point_list objectAtIndex:row];
    [cell set:free_point_model];
    [Global_Controller setSelectedCell:cell Color:[UIColor redColor]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}
- (void)show {
    [self setRequest];
}
- (void)setRequest {
    [URL_Manager FreePoint:^(Free_Point_Model *free_point_model) {
        free_point_data = free_point_model;
        [self.lst_point reloadData];
        [self setLoading:false];
    } Failed:^(NSString *message) {
        [self setRequest];
    } Error:^(NSInteger status_code, NSDictionary *response) {
        [self setRequest];
    }];
}
- (void)setLoading:(bool)show {
    [self.vw_loading setHidden:!show];
}
@end