//
//  RecommendModel.m
//  Day1107_test
//
//  Created by tarena on 15/11/9.
//  Copyright © 2015年 qinxi. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel


@end
@implementation RecommendDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"deals" : [RecommendDataDealsModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"qxerrno":@"errno"};//qxerrno;//errno
}

@end


@implementation RecommendDataDealsModel

+ (NSDictionary *)objectClassInArray{
    return @{@"shops" : [RecommendDataDealsShopsModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"qxdescription":@"description"};
}

@end


@implementation RecommendDataDealsShopsModel

@end


