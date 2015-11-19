#import "Point+Buy+View.h"
#import "URL+Manager.h"
@implementation Point_Buy_View {
@private
    Paid_Point_Model *paid_point_data;
}
- (id)init {
    Point_Buy_View *point_buy_view = [[[NSBundle mainBundle] loadNibNamed:@"Point+Buy+View" owner:nil options:nil] objectAtIndex:0];
    if([point_buy_view isKindOfClass:[Point_Buy_View class]]) {
        return point_buy_view;
    }else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [paid_point_data.paid_point_list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    static NSString *point_list_id = @"PointListID";
    Point_Cell *cell = (Point_Cell *)[tableView dequeueReusableCellWithIdentifier:point_list_id];
    if(cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"Point+Cell" owner:self options:nil];
        cell = self.point_cell;
    }
    Paid_Point_Model *paid_point_model = [paid_point_data.paid_point_list objectAtIndex:row];
    [cell set:paid_point_model];
    [Global_Controller setSelectedCell:cell Color:[UIColor redColor]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self setSelected:row];
}
- (void)show {
    [self setRequest];
}
- (void)setRequest {
    [URL_Manager PaidPoint:^(Paid_Point_Model *paid_point_model) {
        paid_point_data = paid_point_model;
        [self.lst_point reloadData];
        [self setLoading:false];
    } Failed:^(NSString *message) {
        [self setRequest];
    } Error:^(NSInteger status_code, NSDictionary *response) {
        [self setRequest];
    }];
}
- (void)setSelected:(NSInteger)index {
    Paid_Point_Model *paid_point_model = [paid_point_data.paid_point_list objectAtIndex:index];
    [self.delegate didPointBuyViewSelected:paid_point_model];
}
- (void)setLoading:(bool)show {
    [self.vw_loading setHidden:!show];
}
@end