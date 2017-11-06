//
//  VoicePlayerManager.h
//  pushDemo
//
//  Created by 黄新 on 2017/11/6.
//  Copyright © 2017年 黄新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoicePlayerManager : NSObject

@property (nonatomic, assign) BOOL closeVoice;///< 关闭音效


/**
 *  单例方法
 */
+ (instancetype)sharePlayer;

/**
 *  播放
 */
- (void)play;

@end
