//
//  RCTRecordSound.m
//  RCTRecordSound
//
//  Created by Alex Dana on 08/06/16.
//  Copyright © 2016 Alex Dana. All rights reserved.
//

#import "RCTRecordSound.h"
#import "RCTConvert.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import <AVFoundation/AVFoundation.h>

@implementation ReactNativeRecordSound {
    NSDictionary * recordSettings;
    AVAudioSession *audioSession;
    AVAudioRecorder* _audioRecord;
}

RCT_EXPORT_MODULE();


RCT_EXPORT_METHOD(startRecord:(NSURL *)filename : (RCTResponseSenderBlock)callback) {
    NSNumber *_audioEncoding = [NSNumber numberWithInt:kAudioFormatMPEGLayer3];
    NSNumber *_audioChannels = [NSNumber numberWithInt:1];
    NSNumber *_audioSampleRate = [NSNumber numberWithFloat:16000.0];
    NSNumber *_audioQuality = [NSNumber numberWithInt:AVAudioQualityHigh];
    
    recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                      _audioQuality, AVEncoderAudioQualityKey,
                      _audioEncoding, AVFormatIDKey,
                      _audioChannels, AVNumberOfChannelsKey,
                      _audioSampleRate, AVSampleRateKey,
                      nil];
    
    NSError* error = nil;

    AVAudioSession* _recordSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord
                        error:nil];

    _audioRecord = [[AVAudioRecorder alloc]
                    initWithURL: filename
                    settings:recordSettings
                    error: &error];

    if (error) {
        ;
    } else {
        [_audioRecord prepareToRecord];
    }

    if (!_audioRecord.recording) {
        [_audioRecord record];
    }
}

RCT_EXPORT_METHOD(stopRecord) {
    if (_audioRecord.recording) {
      [_audioRecord stop];
    }
}

@end
