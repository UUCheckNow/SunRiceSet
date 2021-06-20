//
//  ViewController.m
//  SunRiceSet
//
//  Created by 魏优优 on 2021/5/10.
//

#import "ViewController.h"
#import "EDSunriseSet.h"

static NSString * const kCityName  = @"name";
static NSString * const kCityLongitude  = @"longitude";
static NSString * const kCityLatitude  = @"latitude";
static NSString * const kCityTimeZone = @"timezone";


@interface ViewController ()
@property (nonatomic, strong) NSArray *cities;
@property (nonatomic,strong) EDSunriseSet *sunriset;
@property (nonatomic,strong)NSDateFormatter *dateFormatter;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showInfoForSelectedCity];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)showInfoForSelectedCity
{
    int index = 3;
    self.dateFormatter = [[NSDateFormatter alloc]init];
    [self.dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    
    // 获取所有已知的时区名称
    NSArray *zoneNames = [NSTimeZone knownTimeZoneNames];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    // 获取指定时区的名称
    NSString *strZoneName = [zone name];



    NSTimeZone *tz = [NSTimeZone timeZoneWithName:self.cities[index][kCityTimeZone]];
    NSDate *date = [NSDate new];
    double longitude = [self.cities[index][kCityLongitude] doubleValue];
    double latitude = [self.cities[index][kCityLatitude] doubleValue];
    
    self.sunriset = [EDSunriseSet sunrisesetWithDate:date timezone:tz latitude:latitude longitude:longitude];
    self.dateFormatter.timeZone = tz;
//
//    NSString *dateString =  [self.dateFormatter stringFromDate:date] ?: @"?"; //这个好像不生效
////    这个时差正好差了八小时  不知道怎么转换
    NSLog(@"获取本地时区：%@\n\n\n获取指定时区的名称：%@\n\n\n\n\n",zone,strZoneName);
//
    
//    这个时间看起来是对的
    NSString *localSunrice = [NSString stringWithFormat:@"%02ld:%02ld",self.sunriset.localSunrise.hour,self.sunriset.localSunrise.minute];
    NSString *localSunset = [NSString stringWithFormat:@"%02ld:%02ld",self.sunriset.localSunset.hour,self.sunriset.localSunset.minute];
    NSLog(@"\n城市：%@\n时区：%@\n当地日出：%@\n当地日落：%@",self.cities[index][kCityName],tz,localSunrice,localSunset);
}




-(NSArray *)cities
{
    // 【Madrid      ： 马德里】
    // 【Cupertino   ： 美国和加拿大】
    // 【Tokyo       ： 东京】
    if( !_cities ) {
        _cities = @[
            @{ kCityName:@"Chongqing", kCityLatitude:@(29.35), kCityLongitude:@(106.33723), kCityTimeZone:@"Asia/Shanghai"},
            @{ kCityName:@"Beijing", kCityLatitude:@(39.9075), kCityLongitude:@(116.39723), kCityTimeZone:@"Asia/Shanghai"},
            @{ kCityName:@"New York", kCityLatitude:@(40.7127837) , kCityLongitude:@(-74.0059413), kCityTimeZone:@"America/New_York"},
            @{ kCityName:@"Madrid" , kCityLatitude:@(40.4165), kCityLongitude:@(-3.70256), kCityTimeZone:@"Europe/Paris"},
            @{ kCityName:@"Cupertino", kCityLatitude:@(37.3229978) , kCityLongitude:@(-122.0321823), kCityTimeZone:@"America/Los_Angeles"},
            @{ kCityName:@"Tokyo" , kCityLatitude:@(35.6894875) , kCityLongitude:@(139.6917064), kCityTimeZone:@"Asia/Tokyo"},
//            @{ kCityName:@"Sydney" , kCityLatitude:@(-33.8674869) , kCityLongitude:@(151.2069902), kCityTimeZone:@"Australia/Sydney"}
        ];
    }
    return _cities;
}

@end
