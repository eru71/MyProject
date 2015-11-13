//
//  BaseModel.m
//  Day1107_test
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 qinxi. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
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

+(id)parset:(id)responseObj{
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
        return [self parset:data];
    }
    return obj;
}
@end
