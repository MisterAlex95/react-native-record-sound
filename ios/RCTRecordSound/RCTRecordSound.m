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
    NSDictionary* recordSettings;
    AVAudioSession* audioSession;
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

    NSNumber *_audioQuality = [NSNumber numberWithInt:AVAudioQualityHigh];
    NSNumber *_audioEncoding = [NSNumber numberWithInt:kAudioFormatMPEG4AAC];
    NSNumber *_audioChannels = [NSNumber numberWithInt:1];
    NSNumber *_audioSampleRate = [NSNumber numberWithFloat:16000.0];

    recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                      _audioQuality, AVEncoderAudioQualityKey,
                      _audioEncoding, AVFormatIDKey,
                      _audioChannels, AVNumberOfChannelsKey,
                      _audioSampleRate, AVSampleRateKey,
                      nil];

    NSError* err = nil;

    AVAudioSession* audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord
                        error:nil];

    NSURL *soundFileURL = [NSURL fileURLWithPath:filename];

    _audioRecord = [[AVAudioRecorder alloc]
                    initWithURL: soundFileURL
                    settings:recordSettings
                    error: &err];
    _audioRecord.delegate = self;

    if (err) {
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
    } else {
        [_audioRecord prepareToRecord];
        NSLog(@"audioSession: launch record");
    }

    if (!_audioRecord.recording) {
        [_audioRecord record];
        [audioSession setActive:YES error:nil];
    }
}

RCT_EXPORT_METHOD(stopRecord) {
    if (_audioRecord.recording) {
        NSLog(@"audioSession: stop record");
        [_audioRecord stop];
        [audioSession setActive:NO error:nil];
    }
}

@end
