//
//  TestSystemEventVC.m
//  Life
//
//  Created by Devin on 3/21/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "TestSystemEventVC.h"

typedef NS_ENUM(NSInteger, HWButtonActionType) {
    HWMakeCallTypeTel=100001,
    HWMakeCallTypeUIWebView,
    HWMakeCallTypeTelprompt,
    HWMoveToSetting,
    HWMoveToWifi,
    HWMoveToSiri
    
};


@interface TestSystemEventVC ()
{
    NSArray *urlsArray;
}

@end

@implementation TestSystemEventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testMoveToSystemSetting];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 About — prefs:root=General&path=About
 Accessibility — prefs:root=General&path=ACCESSIBILITY
 Airplane Mode On — prefs:root=AIRPLANE_MODE
 Auto-Lock — prefs:root=General&path=AUTOLOCK
 Brightness — prefs:root=Brightness
 Bluetooth — prefs:root=General&path=Bluetooth
 Date & Time — prefs:root=General&path=DATE_AND_TIME
 FaceTime — prefs:root=FACETIME
 General — prefs:root=General
 Keyboard — prefs:root=General&path=Keyboard
 iCloud — prefs:root=CASTLE
 iCloud Storage & Backup — prefs:root=CASTLE&path=STORAGE_AND_BACKUP
 International — prefs:root=General&path=INTERNATIONAL
 Location Services — prefs:root=LOCATION_SERVICES
 Music — prefs:root=MUSIC
 Music Equalizer — prefs:root=MUSIC&path=EQ
 Music Volume Limit — prefs:root=MUSIC&path=VolumeLimit
 Network — prefs:root=General&path=Network
 Nike + iPod — prefs:root=NIKE_PLUS_IPOD
 Notes — prefs:root=NOTES
 Notification — prefs:root=NOTIFICATIONS_ID
 Phone — prefs:root=Phone
 Photos — prefs:root=Photos
 Profile — prefs:root=General&path=ManagedConfigurationList
 Reset — prefs:root=General&path=Reset
 Safari — prefs:root=Safari
 Siri — prefs:root=General&path=Assistant
 Sounds — prefs:root=Sounds
 Software Update — prefs:root=General&path=SOFTWARE_UPDATE_LINK
 Store — prefs:root=STORE
 Twitter — prefs:root=TWITTER
 Usage — prefs:root=General&path=USAGE
 VPN — prefs:root=General&path=Network/VPN
 Wallpaper — prefs:root=Wallpaper
 Wi-Fi — prefs:root=WIFI
 Setting —prefs:root=INTERNET_TETHERING
 */

-(void)testMoveToSystemSetting
{
    urlsArray = @[@[@"About",@"prefs:root=General&path=About"],
                  @[@"Setting",@"prefs:root=INTERNET_TETHERING"],
                  @[@"Wi-Fi",@"prefs:root=WIFI"],
                  @[@"Wallpaper",@"prefs:root=Wallpaper"],
                  @[@"VPN",@"prefs:root=General&path=Network/VPN"],
                  @[@"Usage",@"prefs:root=General&path=Network/VPN"],
                  @[@"Twitter",@"prefs:root=TWITTER"],
                  @[@"Store",@"prefs:root=STORE"],
                  @[@"Software Update",@"prefs:root=General&path=SOFTWARE_UPDATE_LINK"],
                  @[@"Sounds",@"prefs:root=Sounds"],
                  @[@"Siri",@"prefs:root=General&path=Assistant"],
                  @[@"Safari",@"prefs:root=Safari"],
                  @[@"Reset",@"prefs:root=General&path=Reset"],
                  @[@"Profile",@"prefs:root=General&path=ManagedConfigurationList"],
                  @[@"Photos",@"prefs:root=Photos"],
                  @[@"Phone",@"prefs:root=Phone"],
                  @[@"Notification",@"prefs:root=NOTIFICATIONS_ID"],
                  @[@"Notes",@"prefs:root=NOTES"],
                  @[@"Nike+iPod",@"prefs:root=NIKE_PLUS_IPOD"],
                  @[@"Network",@"prefs:root=General&path=Network"],
                  @[@"Music Volume Limit",@"prefs:root=MUSIC&path=VolumeLimit"],
                  @[@"Music Equalizer",@"prefs:root=MUSIC&path=EQ"],
                  @[@"Music",@"prefs:root=MUSIC"],
                  @[@"Location Services",@"prefs:root=LOCATION_SERVICES"],
                  @[@"International",@"prefs:root=General&path=INTERNATIONAL"],
                  @[@"iCloud Storage & Backup",@"prefs:root=CASTLE&path=STORAGE_AND_BACKUP"],
                  @[@"iCloud",@"prefs:root=CASTLE"],
                  @[@"Keyboard",@"prefs:root=General&path=Keyboard"],
                  @[@"General",@"prefs:root=General"],
                  @[@"FaceTime",@"prefs:root=FACETIME"],
                  @[@"Date&Time",@"prefs:root=General&path=DATE_AND_TIME"],
                  @[@"Bluetooth",@"prefs:root=General&path=Bluetooth"],
                  @[@"Brightness",@"prefs:root=Brightness"],
                  @[@"Auto-Lock",@"prefs:root=General&path=AUTOLOCK"],
                  @[@"Airplane Mode On",@"prefs:root=AIRPLANE_MODE"],
                  @[@"Accessibility",@"prefs:root=General&path=ACCESSIBILITY"]];
    
    NSInteger countOfRow=3;
    NSInteger urlsCount = [urlsArray count];
    for (NSInteger index=0; index<urlsCount; index++) {
        NSArray *valueArray = [urlsArray objectAtIndex:index];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
        NSInteger row = index/countOfRow;
        NSInteger col = index % countOfRow;
        button.frame=CGRectMake(90*col+10, 40*row+60, 80, 30);
        button.tag=index;
        button.backgroundColor=[UIColor lightGrayColor];
        NSString *buttonTitle = valueArray[0];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button.titleLabel setTextColor:[UIColor whiteColor]];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        [button addTarget:self action:@selector(doSystemEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

-(void)doSystemEvent:(UIButton*)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsArray[sender.tag][1]]];
}

-(void)makeCall:(UIButton*)sender
{
    switch (sender.tag) {
        case HWMakeCallTypeTel:
        {
            NSString *str=@"tel:1xxxxxxxxx9";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
        case HWMakeCallTypeUIWebView:
        {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"1xxxxxxxxx9"];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
        }
            break;
        case HWMakeCallTypeTelprompt:
        {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"1xxxxxxxxx9"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
        case HWMoveToSetting:
        {
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];if([[UIApplication sharedApplication] canOpenURL:url]) {    [[UIApplication sharedApplication] openURL:url];  }
        }
            break;
        case HWMoveToWifi:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
        }
            break;
        case HWMoveToSiri:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General&path=Assistant"]];
        }
            break;
        default:
            break;
    }
}

@end
