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


RCT_EXPORT_METHOD(startRecord:(NSString *)filename : (RCTResponseSenderBlock)callback) {
    NSNumber *audioQuality = [NSNumber numberWithInt:AVAudioQualityHigh];
    recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                      audioQuality, AVEncoderAudioQualityKey,
                      kAudioFormatMPEGLayer3, AVFormatIDKey,
                      1, AVNumberOfChannelsKey,
                      16000.0, AVSampleRateKey,
                      nil];
    NSError* error = nil;

    AVAudioSession* _recordSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord
                        error:nil];

    _audioRecord = [[AVAudioRecorder alloc]
                    initWithString: filename
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
