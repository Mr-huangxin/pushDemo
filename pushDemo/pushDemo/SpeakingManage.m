//
//  SpeakingManage.m
//  pushDemo
//
//  Created by 黄新 on 2017/10/13.
//  Copyright © 2017年 黄新. All rights reserved.
//

#import "SpeakingManage.h"
#import <AVFoundation/AVSpeechSynthesis.h>
#import <MediaPlayer/MediaPlayer.h>

@interface SpeakingManage()<AVSpeechSynthesizerDelegate>

@end

@implementation SpeakingManage

- (void)startSpeaking:(NSString *)words{
    AVSpeechSynthesizer * synthsizer = [[AVSpeechSynthesizer alloc] init];
    synthsizer.delegate = self;
    AVSpeechUtterance * utterance = [[AVSpeechUtterance alloc] initWithString:words];//需要转换的文本
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//国家语言
    utterance.rate = 0.5f;//声速
    utterance.volume = 1;
    //修改播放时的音量
    MPMusicPlayerController* musicController = [MPMusicPlayerController applicationMusicPlayer];
    musicController.volume = 0.7;
    [synthsizer speakUtterance:utterance];
}
#pragma mark ----AVSpeechSynthesizerDelegate

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"----开始播放");
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance*)utterance{
    NSLog(@"---完成播放");
}

@end
