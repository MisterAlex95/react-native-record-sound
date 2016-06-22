# react-native-record-sound

## Installation

* Install the module

```bash
npm i --save react-native-record-sound
```

* In `android/settings.gradle`

```gradle
...
include ':react-native-record-sound', ':app'
project(':react-native-record-sound').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-record-sound/android')
```

* In `android/app/build.gradle`

```gradle
...
dependencies {
    ...
    compile project(':react-native-record-sound')
}
```

* Register module (in MainActivity.java)

```java
import com.reactnativerecordsound.ReactNativeRecordSoundPackager;  // <--- import

public class MainActivity extends ReactActivity {
  ......
  @Override
  protected List<ReactPackage> getPackages() {
    return Arrays.<ReactPackage>asList(
      new MainReactPackage(),
      new ReactNativeRecordSoundPackager()  // <------ add here     
    );
  }
  ......

}
```

## How to use

```javascript
import Record from 'react-native-record-sound';
let isRecording = false;
...
recordSound() {
  if (isRecording === false)
    Record.startRecord(path + 'sound.mp4');
  else   
    Record.stopRecord();
  isRecording = !isRecording;
}
```
