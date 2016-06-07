// RecordSound.h
// add AVFoundation Framework in Xcode

#import "RCTBridgeModule.h"
#import <AVFoundation/AVFoundation.h>

@interface ReactNativeRecordSound : NSObject <RCTBridgeModule ,AVAudioRecorderDelegate>


@end
