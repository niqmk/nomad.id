#import "Price+View.h"
#import "Modal+Controller.h"
@implementation Price_View {
@private
    UIViewController *controller;
    NSMutableArray *price_list;
    long index;
}
- (id)init {
    Price_View *price_view = [[[NSBundle mainBundle] loadNibNamed:@"Price+View" owner:nil options:nil] objectAtIndex:0];
    if([price_view isKindOfClass:[Price_View class]]) {
        return price_view;
    }else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [price_list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    static NSString *price_list_id = @"PriceListID";
    Price_Cell *cell = (Price_Cell *)[tableView dequeueReusableCellWithIdentifier:price_list_id];
    if(cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"Price+Cell" owner:self options:nil];
        cell = self.price_cell;
    }
    Price_Model *price_model = [price_list objectAtIndex:row];
    [cell set:price_model];
    [Global_Controller setSelectedCell:cell Color:[UIColor colorWithRed:66.0f/255.0f green:189.0f/255.0f blue:222.0f/255.0 alpha:1.0f]];
    if(index == row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if(index != row) {
        index = row;
        [self.lst_prices reloadData];
    }
}
- (void)show:(UIViewController *)view_controller
        List:(NSMutableArray *)list
    Delegate:(id<Price_View_Delegate>)delegate {
    controller = view_controller;
    price_list = list;
    self.delegate = delegate;
    [self.vw_main rounded];
    index = 0;
}
- (IBAction)doCancel:(id)sender {
    [Modal_Controller close];
    if(self.delegate != nil) {
        [self.delegate didPriceViewCancelled];
    }
}
- (IBAction)doSelect:(id)sender {
    [Modal_Controller close];
    if(self.delegate != nil) {
        [self.delegate didPriceViewSelected:index];
    }
}
@end