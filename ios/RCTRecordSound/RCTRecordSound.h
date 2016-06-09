//
//  RCTRecordSound.h
//  RCTRecordSound
//
//  Created by Alex Dana on 08/06/16.
//  Copyright © 2016 Alex Dana. All rights reserved.
//

// RecordSound.h
// add AVFoundation Framework in Xcode

#import "RCTBridge.h"
#import <AVFoundation/AVFoundation.h>

@interface ReactNativeRecordSound : NSObject <RCTBridgeModule ,AVAudioRecorderDelegate>
@end
