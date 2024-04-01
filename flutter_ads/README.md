### Các bước 1-4 đã có trong base, nếu dùng base thì có thể bỏ qua, các bước còn lại cũng có trong base nhưng cần chỉnh sửa tùy theo dự án

[Đến Appsflyer và Ad mediation](#appendix)

#### B1: Thêm module ads:


- Cách 1: thêm git submodule là module flutter ads bằng cách chạy lệnh: (dự án cũ)
```
git submodule add https://bitbucket.org/innofyapp/flutter_ads.git flutter_ads
```  
-> sau đó thêm vào dependencies
```yaml
  easy_ads_flutter:
    path: flutter_ads
```
--> chạy xong nó sẽ tự tạo folder tên flutter_ads và file .gitmodules tương ứng
--> nếu là pull về lúc pull về nó sẽ hỏi k thì chạy:` git submodule init/update`

Ưu điểm là có thể cố định commit cần dùng, quản lí submodule trực quan, nhược điểm là hơi lòng vòng

- Cách 2: thêm dependencies (đơn giản hơn)
```yaml
easy_ads_flutter:
    git:
      url: https://bitbucket.org/innofyapp/flutter_ads.git
```  
--> Có thể có username@ trước bitbucket hoặc thêm ref: branch_name
--> Update commit mới nhất bằng cách chạy lệnh: `flutter pub upgrade`

Ưu điểm là đơn giản hơn: mặc định sẽ dùng commit mới nhất trên master, nhược điểm là k thấy commit đang dùng 1 cách trực quan.


#### B2: Thêm cấu hình ads ở native:
android: thêm trong manifest
```xml
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="ca-app-pub-3940256099942544~3347511713"/>
```
ios: thêm trong info.plist
```xml
	<key>GADApplicationIdentifier</key>
	<string>ca-app-pub-4973559944609228~2433291331</string>
```


#### B3: Thêm adtheme cho android (optional)
Mục đích là để background color của ad open là màu trắng luôn chứ k trong suốt như mặc định

Trong `AndroidManifest.xml`:
```xml
        <activity
            android:name="com.google.android.gms.ads.AdActivity"
            android:theme="@style/AdTheme"
            android:screenOrientation="portrait"
            tools:replace="android:theme,android:screenOrientation">
        </activity>
```

Trong file `res/values/styles.xml`:
```xml
    <style name="AdTheme" >
        <item name="android:background">#FFFFFF</item>
        <item name="android:windowBackground">#FFFFFF</item>
    </style>
```

#### B4: Init package (tốt nhất nên đặt trong màn splash sau khi khởi tạo firebase và environment config)

```dart
await EasyAds.instance.initialize(
  AppConfig.adIdManager,
  Assets.icons.splashLogo.image(height: 293.h, width: 259.w), // icon sẽ được hiện với ad resume
  unityTestMode: true,
  adMobAdRequest: const AdRequest(httpTimeoutMillis: 30000),
  admobConfiguration: RequestConfiguration(), // có thể có hoặc k, có để thêm test device id
  navigatorKey: // navigator key chung của app,
);
```

#### B5: Thêm remote config để tùy chỉnh bật/tắt ads từ firebase (optional, bỏ qua nếu k cần bật/tắt ads remote hoặc đã có remote config từ trước)

key = android_ / ios_ + cột Name ID trong Ads Script, android_show, ios_show để chung cho tất cả
type = bool

Có thể sử dụng file mẫu (chọn import config file):
```json
{
  "parameters": {
    "forceUpdate": {
      "defaultValue": {
        "value": "true"
      },
      "valueType": "BOOLEAN"
    }
  },
  "parameterGroups": {
    "ios": {
      "parameters": {
        "ios_inter_splash": {
          "defaultValue": {
            "value": "true"
          },
          "valueType": "BOOLEAN"
        }
      }
    },
    "showAds": {
      "parameters": {
        "android_show": {
          "defaultValue": {
            "value": "true"
          },
          "valueType": "BOOLEAN"
        },
        "ios_show": {
          "defaultValue": {
            "value": "true"
          },
          "valueType": "BOOLEAN"
        }
      }
    },
    "android": {
      "parameters": {
        "android_inter_splash": {
          "defaultValue": {
            "value": "true"
          },
          "valueType": "BOOLEAN"
        }
      }
    },
    "adOffVersion": {
      "parameters": {
        "android_adOffVersion": {
          "defaultValue": {
            "value": "no"
          },
          "valueType": "STRING"
        },
        "ios_adOffVersion": {
          "defaultValue": {
            "value": "0"
          },
          "valueType": "STRING"
        }
      }
    }
  }
}
```

#### B6: Thêm ad unit id

- Thêm các file json chứa các adUnitId, tách riêng cho dev-prod-android-ios. *Note: thêm gitignore vào đầu file gitignore để sau thêm key prod không bị đưa lên git*
```
# custom
assets/adkey/adkey_prod_android.json
assets/adkey/adkey_prod_ios.json
```
- *Extra*: lấy unit test ad của [Android](https://developers.google.com/admob/android/test-ads), [iOS](https://developers.google.com/admob/ios/test-ads)

--> Load file tương ứng vào app để dùng.

#### Last Step: Dùng ads

- Chú ý: ad open app cần được khởi tạo
```dart
EasyAds.instance.initAdmob(
  appOpenAdUnitId: ad_open_unit_id,
);
```

EasyAds.instance.appLifecycleReactor.setOnSplashScreen(true/false) ở splash để k hiện resume trên splash
và gọi EasyAds.instance.appLifecycleReactor?.setIsExcludeScreen(true); khi thực hiện các chức năng ngoài app (ví dụ như rate app dù nó ra store là app khác nhưng thuộc luồng chức năng của app nên quay lại không được hiện resume ads nên mới cần cái này để đánh dấu nó là chức năng đi sang app khác)

- show ad inter gọi hàm `EasyAds.instance.showInterstitialAd()` có sẵn
- show ad banner dùng widget `EasyBannerAd()` có sẵn, collapsible banner thì thêm thuộc tính `isCollapsible: true`
- show ad native cần tạo các factory ở native (refer [codelab](https://codelabs.developers.google.com/codelabs/admob-inline-ads-in-flutter#0)) hoặc tham khảo các app có trước (chú ý cần custom giống với style của app nếu k có design)

```dart
EasyNativeAd(
  factoryId: factory_name,
  adId: adId,
  height: 272,
),
```
- Một số banner/native ads có 2 id là id ecpm high với low thì thêm chữ High vào tên widget
- Preload ads: Sử dụng controller và gọi controller.load() trước khi dùng ads, logic preload có thể tùy ý.
 
# Appendix

### Appsflyer
Sử dụng package appsflyer_sdk
```console
flutter pub add appsflyer_sdk
```
**Cần APP ID IOS trên store, Appsflyer Key**  
Để khởi tạo và sử dụng sdk, tham khảo [hướng dẫn](https://github.com/AppsFlyerSDK/appsflyer-flutter-plugin/blob/master/doc/BasicIntegration.md) hoặc code sau đây:

```dart
final AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
  afDevKey: EnvParams.appsflyerKey,
  appId: AppConstants.appIOSId,
  showDebug: kDebugMode,
  timeToWaitForATTUserAuthorization: 50,
);
final AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
await appsflyerSdk.initSdk();
```

### Mediation Meta Ads (previously Facebook)
 - Document: [Android](https://developers.google.com/admob/android/mediation/meta#step_3_import_the_meta_audience_network_sdk_and_adapter), [iOS](https://developers.google.com/admob/ios/mediation/meta#step_3_import_the_meta_audience_network_sdk_and_adapter)
  
**Cần APPID, TOKEN**
  
Cần setup Meta Ads SDK vì trong package mediation không có sẵn sdk, làm theo hướng dẫn bên dưới hoặc xem thêm tại [hướng dẫn của Meta ads](https://developers.facebook.com/docs/audience-network/setting-up/platform-setup/android/add-sdk/) và 2 document phía trên.
- IOS  
Podfile
```
target 'Runner' do
  # add these two lines
  pod 'GoogleMobileAdsMediationFacebook'
  pod 'FBAudienceNetwork'
end
```
Info.plist
```
<plist version="1.0">
  <dict>
    <!-- add these key-values, replace with your id & token -->
    <array>
      <dict>
        <key>CFBundleURLSchemes</key>
        <array>
          <string>fbAPP-ID</string>
        </array>
      </dict>
    </array>
    <key>FacebookAppID</key>
    <string>APP-ID</string>
    <key>FacebookClientToken</key>
    <string>CLIENT-TOKEN</string>
    <!-- optional, replace with your app name -->
    <key>FacebookDisplayName</key>
    <string>$(BUNDLE_NAME)</string>
  </dict>
</plist>
```
- Android:  
android/app/build.gradle
```
dependencies {
  // add these lines, replace with latest version
  implementation 'androidx.annotation:annotation:1.0.0'
  implementation 'com.facebook.android:audience-network-sdk:6.10.0'
  implementation 'com.google.ads.mediation:facebook:6.15.0.0'
}
```
AndroidManifest.xml
```
<manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.vtn.global.base.flutter">
  <application>
    <!-- add these two lines, replace with your id & token -->
    <meta-data android:name="com.facebook.sdk.ApplicationId" android:value="APP-ID"/>
    <meta-data android:name="com.facebook.sdk.ClientToken" android:value="CLIENT-TOKEN"/>
  </application>
</manifest>
```

### AppLovin
- Document: [Flutter](https://dash.applovin.com/documentation/mediation/flutter/getting-started/integration), [Android](https://developers.google.com/admob/android/mediation/applovin#step_3_import_the_applovin_sdk_and_adapter), [iOS](https://developers.google.com/admob/ios/mediation/applovin#step_3_import_the_applovin_sdk_and_adapter)

Setup mediation riêng cho Android và iOS, setup AppLovin SDK sử dụng package của AppLovin
```console
flutter pub add applovin_max
```
**Cần AppLovin Key**  
---> Thêm code theo 3 document bên trên hoặc tham khảo code sau đây:

- Flutter  
```dart
AppLovinMAX.initialize(appLovinKey);
```
- Android:  
android/app/build.gradle
```
dependencies {
  // add this line, replace with latest version
  implementation 'com.google.ads.mediation:applovin:11.11.3.0'
}
```
- IOS  
Podfile
```
target 'Runner' do
  # add this line
  pod 'GoogleMobileAdsMediationAppLovin'
end
```  

### Mintegral
- Document: [Android](https://developers.google.com/admob/android/mediation/mintegral#step_3_import_the_mintegral_sdk_and_adapter), [iOS](https://developers.google.com/admob/android/mediation/mintegral#step_3_import_the_mintegral_sdk_and_adapter)

Mediation đã bao gồm SDK, chỉ cần làm theo document là dùng được.

### Pangle
- Document: [Android](https://developers.google.com/admob/android/mediation/pangle#step_3_import_the_pangle_sdk_and_adapter), [iOS](https://developers.google.com/admob/ios/mediation/pangle#step_3_import_the_pangle_sdk_and_adapter)

Mediation đã bao gồm SDK, chỉ cần làm theo document là dùng được.

### Unity Ads
- Document: [Android](https://developers.google.com/admob/android/mediation/unity#step_3_import_the_unity_ads_sdk_and_adapter), [iOS](https://developers.google.com/admob/ios/mediation/unity#step_3_import_the_unity_ads_sdk_and_adapter)

Chỉ cần làm theo document là dùng được.

### IronSource
- Document: [Android](https://developers.google.com/admob/android/mediation/ironsource#step_3_import_the_ironsource_sdk_and_adapter), [iOS](https://developers.google.com/admob/ios/mediation/ironsource#step_3_import_the_ironsource_sdk_and_adapter)

Mediation đã bao gồm SDK, chỉ cần làm theo document là dùng được.
