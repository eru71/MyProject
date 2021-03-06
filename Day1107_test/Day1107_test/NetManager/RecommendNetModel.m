//
//  RecommendNetModel.m
//  Day1107_test
//
//  Created by tarena on 15/11/11.
//  Copyright © 2015年 qinxi. All rights reserved.
//

#import "RecommendNetModel.h"

@interface RecommendNetModel()

@property (nonatomic,strong) NSDictionary *dict;

@end

@implementation RecommendNetModel

- (NSMutableArray *)array {
    if(_array == nil) {
        _array = [[NSMutableArray alloc] init];
    }
    return _array;
}

//- (NSArray<RecommendModel *>*)model {
//    if(_model == nil) {
//        _model = [[NSArray<RecommendModel *> alloc] init];
//    }
//    return _model;
//}

-(RecommendModel *)request{
//    NSMutableArray *array = [NSMutableArray new];
    NSString *httpUrl = @"http://apis.baidu.com/baidunuomi/openapi/searchdeals";
    NSString *httpArg = @"city_id=100010000&cat_ids=326&location=116.4374%2C39.8719&keyword=%E9%87%91%E9%BC%8E%E8%BD%A9&radius=3000&sort=0&page=1&page_size=10&is_reservation_required=0";
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"f7b5381c4abf264012ae123cfa3ff40f" forHTTPHeaderField: @"apikey"];

//    [NSURLConnection sendAsynchronousRequest: request
//                                       queue: [NSOperationQueue mainQueue]
//                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
//                               if (error) {
//                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
//                               } else {
//                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                   _dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];//转换数据格式
//                                   NSLog(@"HttpResponseCode:%ld", responseCode);
//                                   NSLog(@"HttpResponseBody %@",responseString);
//                               }
//                           }];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        
        NSArray *newModels = dict[@"data"];
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:newModels.count];
//        for (NSDictionary *dic in newModels) {
//            _model = [RecommendModel mj_objectWithKeyValues:dic];
////            [models addObject:model];
//        }
//        _model = models;
        
        
        _model = [RecommendDataModel mj_objectWithKeyValues:newModels];
        NSLog(@"获取到的数据为：%@",dict);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"发生错误！%@",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
    return _model;
}

- (NSDictionary *)dict {
	if(_dict == nil) {
		_dict = [[NSDictionary alloc] init];
	}
	return _dict;
}

@end
