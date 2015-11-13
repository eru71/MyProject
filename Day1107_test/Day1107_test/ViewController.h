//
//  ViewController.h
//  Day1107_test
//
//  Created by tarena on 15/11/7.
//  Copyright © 2015年 qinxi. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController

@property (nonatomic) double userLatitute;
@property (nonatomic) double userLongitute;
@property (nonatomic,strong) NSString *cityName;
@property (nonatomic,strong) BMKReverseGeoCodeOption *reverseGeoCodeOption;

//初始化单例
+ (ViewController *)sharedInstance;

//初始化百度地图用户位置管理类
- (void)initBMKUserLocation;

//开始定位
-(void)startLocation;

//停止定位
-(void)stopLocation;

@end

