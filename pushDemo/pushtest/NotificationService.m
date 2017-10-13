//
//  NotificationService.m
//  pushtest
//
//  Created by 黄新 on 2017/10/13.
//  Copyright © 2017年 黄新. All rights reserved.
//

#import "NotificationService.h"
#import <AVFoundation/AVSpeechSynthesis.h>
#import <MediaPlayer/MediaPlayer.h>

@interface NotificationService ()<AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    // copy发来的通知，开始做一些处理
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    //    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    NSLog(@"userInfo----->%@",self.bestAttemptContent.userInfo[@"payload"]);
    NSData *jsonData = [self.bestAttemptContent.userInfo[@"payload"] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *pushdic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
    if ([pushdic[@"Type"] isEqualToString:@"1"]) {
        [self startSpeaking:pushdic[@"Content"]];
    }
    self.contentHandler(self.bestAttemptContent);
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

- (void)startSpeaking:(NSString *)words{
    AVSpeechSynthesizer * synthsizer = [[AVSpeechSynthesizer alloc] init];
    synthsizer.delegate = self;
    AVSpeechUtterance * utterance = [[AVSpeechUtterance alloc] initWithString:words];//需要转换的文本
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//国家语言
    utterance.rate = 0.5f;//声速
    utterance.volume = 1;
    //修改播放时的音量 根据自己的需要来定
    MPMusicPlayerController* musicController = [MPMusicPlayerController applicationMusicPlayer];
    ////0.0~1.0
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
