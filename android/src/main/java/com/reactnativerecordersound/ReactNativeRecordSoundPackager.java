package com.reactnativerecordsound;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.JavaScriptModule;
import com.facebook.react.ReactPackage;
import com.facebook.react.uimanager.ViewManager;

import com.reactnativerecordsound.ReactNativeRecordSound;

import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;

import android.os.Environment;

public class ReactNativeRecordSoundPackager implements ReactPackage {
    @Override
    public List<NativeModule> createNativeModules(ReactApplicationContext reactContext) {
        List<NativeModule> modules = new ArrayList<>();
        modules.add(new ReactNativeRecordSound(reactContext));
        return modules;
    }

    @Override
    public List<Class<? extends JavaScriptModule>> createJSModules() {
        return Collections.emptyList();
    }

    @Override
    public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
        return Arrays.asList();
    }
}
