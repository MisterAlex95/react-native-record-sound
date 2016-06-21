package com.reactnativerecordsound;

import android.media.MediaRecorder;
import java.io.IOException;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

import java.util.Map;

public class ReactNativeRecordSound extends ReactContextBaseJavaModule {

  private static final String LOG_TAG = "RecordModule";
  private MediaRecorder mRecorder = null;

  public ReactNativeRecordSound(ReactApplicationContext reactContext) {
    super(reactContext);
  }

  @Override
  public String getName() {
    return "ReactNativeRecordSound";
  }

  @ReactMethod
  public void startRecord(String filename, Callback res) {
    if (mRecorder == null) {
      mRecorder = new MediaRecorder();
      mRecorder.setAudioSource(MediaRecorder.AudioSource.MIC);
      mRecorder.setOutputFormat(MediaRecorder.OutputFormat.MPEG_4);
      mRecorder.setAudioChannels(1); // Mono 1 Stereo 2
      mRecorder.setOutputFile(filename);
      mRecorder.setAudioEncodingBitRate(8000);
      mRecorder.setAudioEncoder(MediaRecorder.AudioEncoder.AAC);

      try {
        mRecorder.prepare();
      } catch (IOException e) {
        res.invoke(LOG_TAG + e.toString());
      }
      mRecorder.start();
    }
  }

  @ReactMethod
  public void stopRecord() {
    if (mRecorder != null) {
      mRecorder.stop();
      mRecorder.release();
      mRecorder = null;
    }
  }
}
