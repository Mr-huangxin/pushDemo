//
//  VoicePlayerManager.m
//  pushDemo
//
//  Created by 黄新 on 2017/11/6.
//  Copyright © 2017年 黄新. All rights reserved.
//

#import "VoicePlayerManager.h"
#import <AVFoundation/AVFoundation.h>


@interface VoicePlayerManager()

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;///< 音频播放器

@end

@implementation VoicePlayerManager

+ (instancetype)sharePlayer {
    static id _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

#pragma mark - /*** 播放 ***/
- (void)play {
    if (self.closeVoice) {
        return;
    }
    [self.audioPlayer play];
}

#pragma mark - setter
- (AVAudioPlayer *)audioPlayer {
    if (!_audioPlayer) {
        NSString *voicePath = [[NSBundle mainBundle]pathForResource:@"send.caf" ofType:nil];
        NSError *error = [[NSError alloc]init];
        if (voicePath) {
            _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:voicePath] error:&error];
            _audioPlayer.volume = 1;//音量
        }
        if (error) {
            NSLog(@"%@",error);
        }
    }
    return _audioPlayer;
}

@end
