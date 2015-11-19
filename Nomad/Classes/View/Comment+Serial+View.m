#import "Comment+Serial+View.h"
@implementation Comment_Serial_View {
@private
    NSMutableArray *comment_list;
    Serial_Detail_Model *serial_detail_data;
    float super_width;
    NSMutableArray *height_list;
}
- (id)init {
    Comment_Serial_View *comment_serial_view = [[[NSBundle mainBundle] loadNibNamed:@"Comment+Serial+View" owner:nil options:nil] objectAtIndex:0];
    if([comment_serial_view isKindOfClass:[Comment_Serial_View class]]) {
        return comment_serial_view;
    }else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    return [[height_list objectAtIndex:row] floatValue];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [comment_list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    static NSString *comment_list_id = @"CommentSerialListID";
    Comment_Serial_Cell *cell = (Comment_Serial_Cell *)[tableView dequeueReusableCellWithIdentifier:comment_list_id];
    if(cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"Comment+Serial+Cell" owner:self options:nil];
        cell = self.comment_serial_cell;
    }
    Member_Comment_Model *member_comment_model = [comment_list objectAtIndex:row];
    [cell set:member_comment_model];
    UIColor *color;
    if(row % 2 == 0) {
        color = [UIColor whiteColor];
    }else {
        color = [Global_Controller hexColor:@"#cfcfcf"];
    }
    [cell setColor:color];
    [Global_Controller setSelectedCell:cell Color:color];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    [self setSelected:row];
}
- (IBAction)doWriteComment:(id)sender {
    if(self.delegate != nil) {
        if([(NSObject *)self.delegate respondsToSelector:@selector(didCommentSerialViewWriteComment)]) {
            [self.delegate didCommentSerialViewWriteComment];
        }
    }
}
- (void)show:(Serial_Detail_Model *)serial_detail_model
       Width:(float)width {
    [self.btn_write_comment rounded];
    [self.btn_write_comment stroke];
    serial_detail_data = serial_detail_model;
    comment_list = [[NSMutableArray alloc] initWithArray:serial_detail_data.comments];
    super_width = width;
    [self setLayout];
}
- (void)setLayout {
    [self.lst_comment setBackgroundColor:[UIColor whiteColor]];
    if([comment_list count] > 0) {
        [self setNoResult:false];
    }
    height_list = [[NSMutableArray alloc] init];
    for(Member_Comment_Model *member_comment_model in comment_list) {
        [self.lbl_sample setText:member_comment_model.desc];
        [self.lbl_sample sizeToFit];
        [height_list addObject:[NSNumber numberWithFloat:self.lbl_sample.frame.size.height + 60]];
    }
}
- (void)setSelected:(NSInteger)index {
}
- (void)setNoResult:(bool)show {
    [self.vw_no_result setHidden:!show];
}
@end