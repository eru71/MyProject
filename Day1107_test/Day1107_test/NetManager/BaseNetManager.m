//
//  BaseNetManager.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"

static AFHTTPSessionManager *manager = nil;

@implementation BaseNetManager

+ (AFHTTPSessionManager *)sharedAFManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    });
    return manager;
}


//方法：把path和参数拼接起来，把字符串中的中文转换为 百分号 形势，因为有的服务器不接收中文编码
+ (NSString *)percentPathWithPath:(NSString *)path params:(NSDictionary *)params{
    NSMutableString *percentPath =[NSMutableString stringWithString:path];
    NSArray *keys = params.allKeys;
    NSInteger count = keys.count;
    for (int i = 0; i < count; i++) {
        if (i == 0) {
            [percentPath appendFormat:@"?%@=%@", keys[i], params[keys[i]]];
        }else{
            [percentPath appendFormat:@"&%@=%@", keys[i], params[keys[i]]];
        }
    }
//把字符串中的中文转为%号形势
    return [percentPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{
    //打印网络请求， DDLog  与  NSLog 功能一样
//    DDLogVerbose(@"Request Path: %@, params %@", path, params);
    return [[self sharedAFManager] GET:path parameters:params success:^void(NSURLSessionDataTask * task, id responseObject) {
        complete(responseObject, nil);
    } failure:^void(NSURLSessionDataTask * task, NSError * error) {
        complete(nil, error);
    }];
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{
    return [[self sharedAFManager] POST:path parameters:params success:^void(NSURLSessionDataTask * task, id responseObject) {
        complete(responseObject, nil);
    } failure:^void(NSURLSessionDataTask * task, NSError * error) {
//        [self handleError:error];
        complete(nil, error);
    }];
}

+ (void)handleError:(NSError *)error{
//    [[self new] showErrorMsg:error]; //弹出错误信息
}

+ (NSArray *)parseArr:(NSArray *)responseObj{
    NSMutableArray *arr=[NSMutableArray new];
    [responseObj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id obj1 = [self parseDic:obj];
        [arr addObject:obj1];
    }];
    return [arr copy];
}

+ (id)parseDic:(id)responseObj{
    id obj = [self new];
    [obj setValuesForKeysWithDictionary:responseObj];
    return obj;
}

+(id)parse:(id)responseObj{
    id obj=responseObj;
    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        obj = [self parseDic:responseObj];
        return obj;
    }
    if ([responseObj isKindOfClass:[NSArray class]]) {
        obj = [self parseArr:responseObj];
        return obj;
    }
    //如果使用的人不会Json序列化
    if ([responseObj isKindOfClass:[NSData class]]) {
        NSError *error = nil;
        id data=[NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
        //正常情况下，解析出来的一定是字典或数组或字符串类型
        BOOL success=[data isKindOfClass:[NSArray class]]||[data isKindOfClass:[NSString class]]||[data isKindOfClass:[NSDictionary class]];
        //如果序列化出问题了 或者 序列化的结果类型不正确
        //__FUNCTION__会打印出当前是哪个类的哪个方法
        NSAssert1(!error||success, @"JSON数据有问题 %s", __FUNCTION__);
        return [self parse:data];
    }
    return obj;
}

@end
