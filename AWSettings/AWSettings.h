#import <Foundation/Foundation.h>

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
