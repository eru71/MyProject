//
//  RecommendNetModel.h
//  Day1107_test
//
//  Created by tarena on 15/11/11.
//  Copyright © 2015年 qinxi. All rights reserved.
//

#import "BaseNetManager.h"
#import "RecommendModel.h"
@interface RecommendNetModel : BaseNetManager
@property (nonatomic,strong) RecommendModel *model;
@property (nonatomic,strong) NSMutableArray *array;

-(RecommendModel *)request;

@end
