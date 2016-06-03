package com.reactnativerecorder;

import android.media.MediaRecorder;
import java.io.IOException;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import java.util.Map;

public class ReactNativeRecorder extends ReactContextBaseJavaModule {

  private static final String LOG_TAG = "RecordModule";
  private MediaRecorder mRecorder = null;

  public ReactNativeRecorder(ReactApplicationContext reactContext) {
    super(reactContext);
  }

  @Override
  public String getName() {
    return "ReactNativeRecorder";
  }

  @ReactMethod
  public void startRecord(String filename) {
        mRecorder = new MediaRecorder();
        mRecorder.setAudioSource(MediaRecorder.AudioSource.MIC);
        mRecorder.setOutputFormat(MediaRecorder.OutputFormat.THREE_GPP);
        mRecorder.setOutputFile(filename);
        mRecorder.setAudioEncoder(MediaRecorder.AudioEncoder.AMR_NB);

        try {
            mRecorder.prepare();
        } catch (IOException e) {
              //oups
        }

        mRecorder.start();
    }

  @ReactMethod
  private void stopRecording() {
    mRecorder.stop();
    mRecorder.release();
    mRecorder = null;
  }
}
