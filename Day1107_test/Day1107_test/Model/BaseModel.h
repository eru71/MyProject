//
//  BaseModel.h
//  Day1107_test
//
//  Created by tarena on 15/11/12.
//  Copyright © 2015年 qinxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseModelDelegate <NSObject>

+(id)parset:(id)responseObj;

@end

@interface BaseModel : NSObject<BaseModelDelegate>


@end
