//
//  ViewController.m
//  Day1107_test
//
//  Created by tarena on 15/11/7.
//  Copyright © 2015年 qinxi. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
@property (nonatomic,strong) BMKMapView *mapView;
@property (nonatomic,strong) CLLocationManager *manager;
@property (nonatomic,strong) BMKLocationService *locService;
@end

@implementation ViewController

+(ViewController *)sharedInstance{
    static ViewController *_instance = nil;
    @synchronized(self) {
        if (_instance == nil) {
            _instance = [[self alloc]init];
        }
    }return _instance;
}

- (id)init{
    if (self == [super init]) {
        [self initBMKUserLocation];
    }
    return self;
}

-(void)initBMKUserLocation{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [self startLocation];
}

-(void)startLocation{
    [_locService startUserLocationService];
}

-(void)stopLocation{
    [_locService stopUserLocationService];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.view = _mapView;
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    NSString *httpUrl = @"http://apis.baidu.com/baidunuomi/openapi/searchdeals";
    NSString *httpArg = @"city_id=100010000&cat_ids=326&location=116.4374%2C39.8719&keyword=%E9%87%91%E9%BC%8E%E8%BD%A9&radius=3000&sort=0&page=1&page_size=10&is_reservation_required=0";
    [self request: httpUrl withHttpArg: httpArg];
}



-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"f7b5381c4abf264012ae123cfa3ff40f" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"HttpResponseCode:%ld", responseCode);
                                   NSLog(@"HttpResponseBody %@",responseString);
                               }
                           }];
}


//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //普通态
    //以下_mapView为BMKMapView对象
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:userLocation];
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.01, 0.01);
    BMKCoordinateRegion region = BMKCoordinateRegionMake(userLocation.location.coordinate, span);
    [self.mapView setRegion:region animated:YES];
    [self stopLocation];
}

- (void)didStopLocatingUser{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CLLocationManager *)manager{
    if (!_manager) {
        _manager = [[CLLocationManager alloc]init];
        if ([UIDevice currentDevice].systemVersion.floatValue>=8.0) {
            [_manager requestAlwaysAuthorization];
        }
    }
    return _manager;
}

@end
