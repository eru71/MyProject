//
//  RecommendModel.h
//  Day1107_test
//
//  Created by tarena on 15/11/9.
//  Copyright © 2015年 qinxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RecommendDataModel,RecommendDataDealsModel,RecommendDataDealsShopsModel;

#pragma mark - RecommendModel
@interface RecommendModel : NSObject

@property (nonatomic, assign) NSInteger qxerrno;//errno

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) RecommendDataModel *data;

@end

#pragma mark - RecommendDataModel
@interface RecommendDataModel : NSObject

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSArray<RecommendDataDealsModel *> *deals;

@end

#pragma mark - RecommendDataDealsModel

@interface RecommendDataDealsModel : NSObject

@property (nonatomic, copy) NSString *qxdescription;//description

@property (nonatomic, copy) NSString *deal_url;

@property (nonatomic, assign) BOOL is_reservation_required;

@property (nonatomic, assign) NSInteger promotion_price;

@property (nonatomic, copy) NSString *tiny_image;

@property (nonatomic, assign) NSInteger shop_num;

@property (nonatomic, assign) NSInteger deal_id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger market_price;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) NSInteger sale_num;

@property (nonatomic, assign) NSInteger comment_num;

@property (nonatomic, assign) NSInteger purchase_deadline;

@property (nonatomic, assign) NSInteger current_price;

@property (nonatomic, assign) NSInteger publish_time;

@property (nonatomic, assign) NSInteger distance;

@property (nonatomic, assign) CGFloat score;

@property (nonatomic, strong) NSArray<RecommendDataDealsShopsModel *> *shops;

@property (nonatomic, copy) NSString *deal_murl;

@end

@interface RecommendDataDealsShopsModel : NSObject

@property (nonatomic, copy) NSString *shop_murl;

@property (nonatomic, copy) NSString *shop_url;

@property (nonatomic, assign) CGFloat latitude;

@property (nonatomic, assign) CGFloat longitude;

@property (nonatomic, assign) CGFloat distance;

@property (nonatomic, assign) NSInteger shop_id;

@end

