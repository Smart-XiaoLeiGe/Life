//
//  TestPlayMusicVC.m
//  Life
//
//  Created by Devin on 3/21/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "TestPlayMusicVC.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>

@interface TestPlayMusicVC ()
{
    AVAudioPlayer* myPlayer;
}
@end

@implementation TestPlayMusicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testPlayMusic];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIDevice *device = [UIDevice currentDevice];
    BOOL backgroundSupported = NO;
    if ( [device respondsToSelector:@selector(isMultitaskingSupported)] )
    {
        backgroundSupported = device.multitaskingSupported;
    }
    
    if ( backgroundSupported == YES )
    {
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        //注意这里，告诉系统已经准备好了
        [self becomeFirstResponder];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

/**
 *  1.添加后台播放设置（info.plist）
 2.引入 <AVFoundation/AVFoundation.h>
 3.播放代码
 
 接受远程事件
 1.beginReceivingRemoteControlEvents
 2.viewDidAppear
 3.canBecomeResponder
 
 */
- (void)setLockScreenNowPlayingInfo
{
    //更新锁屏时的歌曲信息
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        [dict setObject:@"男儿当自强" forKey:MPMediaItemPropertyTitle];
        [dict setObject:@"林。。。" forKey:MPMediaItemPropertyArtist];
        [dict setObject:@"不知道" forKey:MPMediaItemPropertyAlbumTitle];
        [dict setObject:[NSNumber numberWithDouble:1.0] forKey:MPNowPlayingInfoPropertyPlaybackRate];
        [dict setObject:[NSNumber numberWithDouble:myPlayer.duration] forKey:MPMediaItemPropertyPlaybackDuration];

        UIImage *newImage = [UIImage imageNamed:@"FullSizeRender.jpg"];
        [dict setObject:[[MPMediaItemArtwork alloc] initWithImage:newImage]forKey:MPMediaItemPropertyArtwork];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    }
}

- (void)remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        switch (receivedEvent.subtype) {
            case UIEventSubtypeRemoteControlTogglePlayPause:
            case UIEventSubtypeRemoteControlPlay:
            {
                [self startMusic];
                break;
            }
            case UIEventSubtypeRemoteControlPause:
            case UIEventSubtypeRemoteControlStop:
            {
                [self stopMusic];
                break;
            }
                
            case UIEventSubtypeRemoteControlNextTrack:
            {
                [self stopMusic];
                [self startMusic];
                break;
            }
                
            case UIEventSubtypeRemoteControlPreviousTrack:
            {
                [self stopMusic];
                [self startMusic];
                break;
            }
            default:
                break;
        }
    }
}

-(void)testPlayMusic
{
    
    //后台播放音频设置
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //让app支持接受远程控制事件
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
    //播放背景音乐
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"testAudio" ofType:@"mp3"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:musicPath];
    //    url=[NSURL URLWithString:@"http://www.cocoanetics.com/files/Cocoanetics_031.mp3"];
    
    // 创建播放器
    myPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [myPlayer prepareToPlay];
    //    [myPlayer setVolume:0.3];
    //    myPlayer.numberOfLoops = -1;
    
    //UI
    
    float widthFactor = 0.12;
    float heightFactor = 0.1;
    UIButton *startBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    startBtn.frame = CGRectMake(FM_ScreenWidth*0.05, FM_ScreenHeight*0.8, FM_ScreenWidth*widthFactor, FM_ScreenHeight*heightFactor);
    [startBtn addTarget:self action:@selector(startMusic) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setTitle:@"Start" forState:UIControlStateNormal];
    [self.view addSubview:startBtn];
    
    startBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    startBtn.frame = CGRectMake(FM_ScreenWidth*(0.05+(widthFactor+0.01)), FM_ScreenHeight*0.8, FM_ScreenWidth*widthFactor, FM_ScreenHeight*heightFactor);
    [startBtn addTarget:self action:@selector(stopMusic) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setTitle:@"Stop" forState:UIControlStateNormal];
    [self.view addSubview:startBtn];
    
    startBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    startBtn.frame=CGRectMake(FM_ScreenWidth*(0.05+2*(widthFactor+0.01)), FM_ScreenHeight*0.8, FM_ScreenWidth*widthFactor, FM_ScreenHeight*heightFactor);
    [startBtn addTarget:self action:@selector(pauseMusic) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setTitle:@"Pause" forState:UIControlStateNormal];
    [self.view addSubview:startBtn];
    
    startBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    startBtn.frame=CGRectMake(FM_ScreenWidth*(0.05+3*(widthFactor+0.01)), FM_ScreenHeight*0.8, FM_ScreenWidth*widthFactor, FM_ScreenHeight*heightFactor);
    [startBtn addTarget:self action:@selector(playMusicAtTime) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setTitle:@"Time" forState:UIControlStateNormal];
    [self.view addSubview:startBtn];
    
    startBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    startBtn.frame=CGRectMake(FM_ScreenWidth*(0.05+4*(widthFactor+0.01)), FM_ScreenHeight*0.8, FM_ScreenWidth*widthFactor, FM_ScreenHeight*heightFactor);
    [startBtn addTarget:self action:@selector(playMode:) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setTitle:[NSString stringWithFormat:@"%ld",myPlayer.numberOfLoops] forState:UIControlStateNormal];
    [self.view addSubview:startBtn];
    
    startBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    startBtn.frame=CGRectMake(FM_ScreenWidth*(0.05+5*(widthFactor+0.01)), FM_ScreenHeight*0.8, FM_ScreenWidth*widthFactor, FM_ScreenHeight*heightFactor);
    [startBtn addTarget:self action:@selector(playVolume:) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setTitle:[NSString stringWithFormat:@"%2.1f",myPlayer.volume] forState:UIControlStateNormal];
    [self.view addSubview:startBtn];
    
}

-(void)startMusic
{
    [self setLockScreenNowPlayingInfo];
    [myPlayer play];
}

-(void)stopMusic
{
    [myPlayer stop];
}

-(void)pauseMusic
{
    [myPlayer pause];
}

-(void)playMusicAtTime
{
    [myPlayer playAtTime:5];
}

-(void)playMode:(UIButton *)sender
{
    [myPlayer setNumberOfLoops:(myPlayer.numberOfLoops+1>1)?-1:myPlayer.numberOfLoops+1];
    switch (myPlayer.numberOfLoops) {
        case -1:
            [sender setTitle:@"循环" forState:UIControlStateNormal];
            break;
        case 0:
            [sender setTitle:@"一遍" forState:UIControlStateNormal];
            break;
        case 1:
            [sender setTitle:@"两次->循环" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

-(void)playVolume:(UIButton *)sender
{
    [myPlayer setVolume:(myPlayer.volume+0.1>1.1)?0:myPlayer.volume+0.1];
    [sender setTitle:[NSString stringWithFormat:@"%.1f",myPlayer.volume] forState:UIControlStateNormal];
}

@end
