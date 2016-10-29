//
//  UMengsManager.m
//  Life
//
//  Created by Devin on 1/26/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "UMengsManager.h"
#import "UMCheckUpdate.h"
#import "LifeManager.h"
#import "MobClick.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

#define ForceUpdateTag 10001
#define UpdateTag      10002

#define UMengAppkey      @"56a71b14e0f55a07430004e6"
#define WEIXIN_APPKEY    @"wxb8f392d55819b3c5"
#define WEIXIN_APPSECRET @"066b1ccc5b90aecccb533ec1ed10e528"
#define WEIBO_Appkey     @"222756443"
#define WEIBO_APPSECRET  @"5a65a966370f7b17447dea56d2aaa8c0"

@interface UMengsManager ()

@end

static UpdateBlock updateBlock;
@implementation UMengsManager

+(void)checkUpdate:(UpdateBlock)update
{
    updateBlock = update;
    [UMCheckUpdate checkUpdateWithDelegate:self selector:@selector(autoUpdate:) appkey:UMengAppkey channel:nil];
}

+(void)autoUpdate:(NSDictionary *)dic
{
    NSLog(@"asdf：%@",dic);
    BOOL forceUpdate     = NO;
    BOOL update          = NO;
    NSString *appPath              = @"";
    NSString *update_log = @"";
    
    if ([[dic allKeys] containsObject:@"path"]) {
        NSString *tempPath = [dic objectForKey:@"path"];
        forceUpdate=[[tempPath substringToIndex:1] boolValue];
        appPath=[tempPath substringFromIndex:1];
    }
    if ([[dic allKeys] containsObject:@"update"]) {
        update = [[dic objectForKey:@"update"] boolValue];
    }
    if ([[dic allKeys] containsObject:@"update_log"]) {
        update_log = [dic objectForKey:@"update_log"];
        NSError *error=nil;
        NSDictionary *updateStringDict = [NSJSONSerialization JSONObjectWithData:[update_log dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            update_log=@"请移步到AppStore查看最新状态！";
        }else
        {
            update_log = [updateStringDict objectForKey:([[LifeManager shareManager] isChinese]?@"cn":@"en")];
        }
    }
    if (update && forceUpdate) {
        updateBlock(forceUpdate,update_log,appPath);
    }else if (update)
    {
        updateBlock(forceUpdate,update_log,appPath);
    }
}

+ (void)setUMengAnalytics
{
    [MobClick startWithAppkey:UMengAppkey reportPolicy:REALTIME channelId:nil];
    [MobClick setAppVersion:XcodeAppVersion];
    [MobClick setCrashReportEnabled:YES];
#ifdef DEBUG
    [MobClick setLogEnabled:NO];
#endif
}

+ (void)setUMengSocial
{
    [UMSocialData setAppKey:UMengAppkey];
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToSina,UMShareToWechatTimeline]];
    [UMSocialWechatHandler setWXAppId:WEIXIN_APPKEY appSecret:WEIXIN_APPSECRET url:@"http://www.umeng.com/social"];
}


@end
