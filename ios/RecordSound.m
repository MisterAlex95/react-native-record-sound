#import "RecordSound.h"
#import "RCTConvert.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import <AVFoundation/AVFoundation.h>

@implementation ReactNativeRecordSound {
  NSDictionary * recordSettings;
  AVAudioSession *audioSession;
}

RCT_EXPORT_MODULE()
 RCT_EXPORT_METHOD(squareMe:(int)number : (RCTResponseSenderBlock)callback) {
    callback(@[[NSNull null], [NSNumber numberWithInt: (number*number)]]);
  }


RCT_EXPORT_METHOD(startRecord:(NSURL*)filename : (RCTResponseSenderBlock)callback) {
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

  AVAudioRecorder* _audioRecord = [[AVAudioRecorder alloc]
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
  //if (_audioRecord.recording) {
  //  [_audioRecord stop];
  //}
}

@end
