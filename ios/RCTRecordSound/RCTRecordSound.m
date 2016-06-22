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

    AVAudioSessionRecordPermission permissionStatus = [[AVAudioSession sharedInstance] recordPermission];
    switch (permissionStatus) {
        case AVAudioSessionRecordPermissionUndetermined:
            NSLog(@("undetermined"));
            break;
        case AVAudioSessionRecordPermissionDenied:
            NSLog(@("denied"));
            break;
        case AVAudioSessionRecordPermissionGranted:
            NSLog(@("granted"));
            break;
        default:
            NSLog(@("Error checking device authorization status."));
            break;
    }

    NSNumber *_audioEncoding = [NSNumber numberWithInt:kAudioFormatMPEG4AAC];
    NSNumber *_audioChannels = [NSNumber numberWithInt:1];
    NSNumber *_audioSampleRate = [NSNumber numberWithFloat:16000.0];
    NSNumber *_audioQuality = [NSNumber numberWithInt:AVAudioQualityMax];

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

    NSURL *soundFileURL = [NSURL fileURLWithPath:filename];

    _audioRecord = [[AVAudioRecorder alloc]
                    initWithURL: soundFileURL
                    settings:recordSettings
                    error: &error];

    if (error) {
      NSLog(@"Error: %@ %d %@", [error domain], [error code], [[error userInfo] description]);
      return;
    } else {
        [_audioRecord prepareToRecord];
    }

    if (_audioRecord.recording == false) {
        [_audioRecord record];
        NSLog(@"AudioRecord: Begin record");
    }
}

RCT_EXPORT_METHOD(stopRecord) {
    if (_audioRecord.recording == true) {
      NSLog(@"AudioRecord: Stop record");
      [_audioRecord stop];
    }
}

@end
