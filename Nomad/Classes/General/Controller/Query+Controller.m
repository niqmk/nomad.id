#import "Query+Controller.h"
@implementation Query_Controller
#pragma - Download
+ (NSMutableArray *)getDownloadList {
    Global_Variables *gb_variables = [Global_Variables instance];
    NSMutableArray *download_list = [[NSMutableArray alloc] init];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(gb_variables->sql_controller->connection, [@"SELECT id, video_id, video_type, title, filename, url, log, expiry FROM download" UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        while(sqlite3_step(statement) == SQLITE_ROW) {
            Download_Model *download_model = [[Download_Model alloc] init];
            download_model.id = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            download_model.video_id = sqlite3_column_int(statement, 1);
            download_model.video_type = sqlite3_column_int(statement, 2);
            download_model.title = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
            download_model.filename = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
            download_model.url = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
            download_model.log = sqlite3_column_int(statement, 6);
            download_model.expiry = sqlite3_column_int(statement, 7);
            [download_list addObject:download_model];
        }
    }
    sqlite3_finalize(statement);
    return download_list;
}
+ (Download_Model *)getDownload:(long)video_id
                      VideoType:(VideoType)video_type {
    Download_Model *download_model = nil;
    Global_Variables *gb_variables = [Global_Variables instance];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(gb_variables->sql_controller->connection, [@"SELECT id, video_id, video_type, title, filename, url, log, expiry FROM download WHERE video_id = ? AND video_type = ?" UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int64(statement, 1, video_id);
        sqlite3_bind_int64(statement, 2, video_type);
        if(sqlite3_step(statement) == SQLITE_ROW) {
            download_model = [[Download_Model alloc] init];
            download_model.id = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            download_model.video_id = sqlite3_column_int(statement, 1);
            download_model.video_type = sqlite3_column_int(statement, 2);
            download_model.title = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
            download_model.filename = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
            download_model.url = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
            download_model.log = sqlite3_column_int(statement, 6);
            download_model.expiry = sqlite3_column_int(statement, 7);
        }
    }
    sqlite3_finalize(statement);
    return download_model;
}
+ (void)addDownload:(Download_Model *)download_model {
    Global_Variables *gb_variables = [Global_Variables instance];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(gb_variables->sql_controller->connection, [@"INSERT INTO download VALUES (?, ?, ?, ?, ?, ?, ?, ?)" UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [download_model.id UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int64(statement, 2, download_model.video_id);
        sqlite3_bind_int(statement, 3, download_model.video_type);
        sqlite3_bind_text(statement, 4, [download_model.title UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [download_model.filename UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 6, [download_model.url UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int64(statement, 7, download_model.log);
        sqlite3_bind_int64(statement, 8, download_model.expiry);
        if(sqlite3_step(statement) != SQLITE_DONE) {}
        sqlite3_reset(statement);
    }
    sqlite3_finalize(statement);
}
+ (void)updateDownloadExpiry:(long)video_id
                   VideoType:(VideoType)video_type
                      Expiry:(long)expiry {
    Global_Variables *gb_variables = [Global_Variables instance];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(gb_variables->sql_controller->connection, [@"UPDATE download SET expiry = ? WHERE video_id = ? AND video_type = ?" UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int64(statement, 1, expiry);
        sqlite3_bind_int64(statement, 2, video_id);
        sqlite3_bind_int64(statement, 3, video_type);
        if(sqlite3_step(statement) != SQLITE_DONE) {}
        sqlite3_reset(statement);
    }
    sqlite3_finalize(statement);
}
+ (void)updateDownloadByVideoID:(long)video_id
                      VideoType:(VideoType)video_type
                             ID:(NSString *)id
                         Expiry:(long)expiry {
    Global_Variables *gb_variables = [Global_Variables instance];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(gb_variables->sql_controller->connection, [@"UPDATE download SET id = ?, expiry = ? WHERE video_id = ? AND video_type = ?" UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [id UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int64(statement, 2, expiry);
        sqlite3_bind_int64(statement, 3, video_id);
        sqlite3_bind_int64(statement, 4, video_type);
        if(sqlite3_step(statement) != SQLITE_DONE) {}
        sqlite3_reset(statement);
    }
    sqlite3_finalize(statement);
}
+ (void)deleteDownload:(NSString *)id {
    Global_Variables *gb_variables = [Global_Variables instance];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(gb_variables->sql_controller->connection, [@"DELETE FROM download WHERE id = ?" UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [id UTF8String], -1, SQLITE_TRANSIENT);
        if(sqlite3_step(statement) != SQLITE_DONE) {}
        sqlite3_reset(statement);
    }
    sqlite3_finalize(statement);
}
+ (void)truncateDownload {
    Global_Variables *gb_variables = [Global_Variables instance];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(gb_variables->sql_controller->connection, [@"DELETE FROM download" UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if(sqlite3_step(statement) != SQLITE_DONE) {}
        sqlite3_reset(statement);
    }
    sqlite3_finalize(statement);
}
#pragma - Purchased
+ (NSMutableArray *)getPurchasedList {
    Global_Variables *gb_variables = [Global_Variables instance];
    NSMutableArray *purchased_list = [[NSMutableArray alloc] init];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(gb_variables->sql_controller->connection, [@"SELECT id, video_id, video_type, title, filename, url, log, expiry FROM purchased" UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        while(sqlite3_step(statement) == SQLITE_ROW) {
            Purchased_Model *purchased_model = [[Purchased_Model alloc] init];
            purchased_model.id = sqlite3_column_int(statement, 0);
            purchased_model.video_id = sqlite3_column_int(statement, 1);
            purchased_model.video_type = sqlite3_column_int(statement, 2);
            purchased_model.title = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
            purchased_model.filename = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
            purchased_model.url = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
            purchased_model.log = sqlite3_column_int(statement, 6);
            purchased_model.expiry = sqlite3_column_int(statement, 7);
            [purchased_list addObject:purchased_model];
        }
    }
    sqlite3_finalize(statement);
    return purchased_list;
}
+ (Purchased_Model *)getPurchased:(long)video_id
                        VideoType:(VideoType)video_type {
    Purchased_Model *purchased_model = nil;
    Global_Variables *gb_variables = [Global_Variables instance];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(gb_variables->sql_controller->connection, [@"SELECT id, video_id, video_type, title, filename, url, log, expiry FROM purchased WHERE video_id = ? AND video_type = ?" UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int64(statement, 1, video_id);
        sqlite3_bind_int64(statement, 2, video_type);
        if(sqlite3_step(statement) == SQLITE_ROW) {
            purchased_model = [[Purchased_Model alloc] init];
            purchased_model.id = sqlite3_column_int(statement, 0);
            purchased_model.video_id = sqlite3_column_int(statement, 1);
            purchased_model.video_type = sqlite3_column_int(statement, 2);
            purchased_model.title = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
            purchased_model.filename = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
            purchased_model.url = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
            purchased_model.log = sqlite3_column_int(statement, 6);
            purchased_model.expiry = sqlite3_column_int(statement, 7);
        }
    }
    sqlite3_finalize(statement);
    return purchased_model;
}
+ (void)addPurchased:(Purchased_Model *)purchased_model {
    Global_Variables *gb_variables = [Global_Variables instance];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(gb_variables->sql_controller->connection, [@"INSERT INTO purchased (video_id, video_type, title, filename, url, log, expiry) VALUES (?, ?, ?, ?, ?, ?, ?)" UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int64(statement, 1, purchased_model.video_id);
        sqlite3_bind_int(statement, 2, purchased_model.video_type);
        sqlite3_bind_text(statement, 3, [purchased_model.title UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [purchased_model.filename UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [purchased_model.url UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int64(statement, 6, purchased_model.log);
        sqlite3_bind_int64(statement, 7, purchased_model.expiry);
        if(sqlite3_step(statement) != SQLITE_DONE) {}
        sqlite3_reset(statement);
    }
    sqlite3_finalize(statement);
}
+ (void)updatePurchasedExpiry:(long)video_id
                    VideoType:(VideoType)video_type
                       Expiry:(long)expiry {
    Global_Variables *gb_variables = [Global_Variables instance];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(gb_variables->sql_controller->connection, [@"UPDATE purchased SET expiry = ? WHERE video_id = ? AND video_type = ?" UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int64(statement, 1, expiry);
        sqlite3_bind_int64(statement, 2, video_id);
        sqlite3_bind_int64(statement, 3, video_type);
        if(sqlite3_step(statement) != SQLITE_DONE) {}
        sqlite3_reset(statement);
    }
    sqlite3_finalize(statement);
}
+ (void)updatePurchasedByVideoID:(long)video_id
                       VideoType:(VideoType)video_type
                              ID:(long)id
                          Expiry:(long)expiry {
    Global_Variables *gb_variables = [Global_Variables instance];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(gb_variables->sql_controller->connection, [@"UPDATE purchased SET id = ?, expiry = ? WHERE video_id = ? AND video_type = ?" UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int64(statement, 1, id);
        sqlite3_bind_int64(statement, 2, expiry);
        sqlite3_bind_int64(statement, 3, video_id);
        sqlite3_bind_int64(statement, 4, video_type);
        if(sqlite3_step(statement) != SQLITE_DONE) {}
        sqlite3_reset(statement);
    }
    sqlite3_finalize(statement);
}
+ (void)deletePurchased:(long)id {
    Global_Variables *gb_variables = [Global_Variables instance];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(gb_variables->sql_controller->connection, [@"DELETE FROM purchased WHERE id = ?" UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int64(statement, 1, id);
        if(sqlite3_step(statement) != SQLITE_DONE) {}
        sqlite3_reset(statement);
    }
    sqlite3_finalize(statement);
}
+ (void)truncatePurchased {
    Global_Variables *gb_variables = [Global_Variables instance];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(gb_variables->sql_controller->connection, [@"DELETE FROM purchased" UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if(sqlite3_step(statement) != SQLITE_DONE) {}
        sqlite3_reset(statement);
    }
    sqlite3_finalize(statement);
}
@end