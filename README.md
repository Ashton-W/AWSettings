# AWSettings

[![CI Status](http://img.shields.io/travis/Ashton-W/AWSettings.svg?style=flat)](https://travis-ci.org/Ashton-W/AWSettings)
[![Version](https://img.shields.io/cocoapods/v/AWSettings.svg?style=flat)](http://cocoadocs.org/docsets/AWSettings)
[![License](https://img.shields.io/cocoapods/l/AWSettings.svg?style=flat)](http://cocoadocs.org/docsets/AWSettings)
[![Platform](https://img.shields.io/cocoapods/p/AWSettings.svg?style=flat)](http://cocoadocs.org/docsets/AWSettings)

---

```objc
/**
 *  Automatically updates properties with values from Settings.
 *  Loads defaults directory from Settings bundle or Plist.
 *  KVO compliant.
 *
 *  Subclass to define properties for your Settings keys.
 */
@interface AWSettings : NSObject

/**
 *  Shared instance that relates to `[NSUserDefaults standardUserDefaults]`.
 *
 *  @see NSUserDefaults
 *  @return singleton instance of settings class
 */
+ (instancetype)sharedSettings;

/**
 *  Bundle path for Plist dictionary containing default values.
 *  Override to customise.
 *
 *  @return path to file
 */
+ (NSString *)pathForDefaultsPlist;

/**
 *  Mapping of property names to Settings bundle keys.
 *  Override to customise.
 *
 *  @return mapping dictionary
 */
+ (NSDictionary *)propertyKeysBySettingsKey;

/**
 *  Prefix to remove from Settings keys to get property names.
 *  Override to customise.
 *
 *  @return prefix string
 */
+ (NSString *)settingsKeysPrefix;

@end
```

## Usage

Subclass `AWSettings`. Add properties for your Settings bundle preferences.

## Installation

AWSettings is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "AWSettings"

## License

AWSettings is available under the MIT license. See the LICENSE file for more info.

