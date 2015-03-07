#import "AWSettings.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#pragma clang diagnostic ignored "-Wobjc-missing-property-synthesis"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"
#pragma clang diagnostic ignored "-Wreceiver-is-weak"
#pragma clang diagnostic ignored "-Wgnu"

@interface AWSettings ()

@property (nonatomic) NSUserDefaults *userDefaults;

@end

@implementation AWSettings

#pragma mark - Class methods

+ (void)load
{
    if (self != [AWSettings class]) {
        //only load subclasses
        // load defaults immediately
        [[self sharedSettings] loadDefaults];
    }
}

+ (void)initialize
{
    if (self != [AWSettings class]) {
        // only load subclasses
        // load defaults immediately
        [[self sharedSettings] loadDefaults];
    }
}

+ (instancetype)sharedSettings
{
    static id _shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    
    return _shared;
}

- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _userDefaults = userDefaults;
    [self observeNotifications];
    
    return self;
}

- (instancetype)init
{
    return [self initWithUserDefaults:[NSUserDefaults standardUserDefaults]];
}

+ (NSString *)pathForDefaultsPlist
{
    return nil;
}

+ (NSDictionary *)propertyKeysBySettingsKey
{
    return nil;
}

+ (NSString *)settingsKeysPrefix
{
    return nil;
}

#pragma mark - Instance methods

- (void)loadDefaults
{
    [self loadDefaultsFromSettings];
    [self loadDefaultsFromDefaultsDictionary];
}

- (void)loadDefaultsFromDefaultsDictionary
{
    NSString *path = [[self class] pathForDefaultsPlist];
    if (!path) {
        return;
    }
    
    NSDictionary *defaults = [NSDictionary dictionaryWithContentsOfFile:path];
    if (!defaults) {
        return;
    }
    
    [self.userDefaults registerDefaults:defaults];
}

- (void)loadDefaultsFromSettings
{
    NSDictionary *defaults = [self defaultsFromSettingsFile:@"Root"];
    [self.userDefaults registerDefaults:defaults];
}

- (NSDictionary *)defaultsFromSettingsFile:(NSString *)file
{
    NSString *settingsBundlePath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    NSBundle *settingsBundle = [NSBundle bundleWithPath:settingsBundlePath];
    
    NSString *path = [settingsBundle pathForResource:file ofType:@"plist"];
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    
    for (NSDictionary *preference in preferences) {
        
        NSString *type = preference[@"Type"];
        if ([type isEqualToString:@"PSChildPaneSpecifier"]) {
            NSString *file = preference[@"File"];
            [defaults addEntriesFromDictionary:[self defaultsFromSettingsFile:file]];
        }
        else {
            NSString *key = preference[@"Key"];
            id defaultValue = preference[@"DefaultValue"];
            if ([key length] > 0 && defaultValue) {
                [defaults setObject:defaultValue forKey:key];
            }
        }
    }
    
    return defaults;
}

#pragma mark Notification

- (void)observeNotifications
{
    NSNotificationCenter *notifications = [NSNotificationCenter defaultCenter];
    [notifications addObserver:self
                      selector:@selector(applicationDidBecomeActiveNotification:)
                          name:UIApplicationDidBecomeActiveNotification
                        object:nil];
}

- (void)applicationDidBecomeActiveNotification:(NSNotification *)notification
{
    [self.userDefaults synchronize];
    [self updateProperties];
}

- (void)updateProperties
{
    NSDictionary *updatedDefaults = [self.userDefaults dictionaryRepresentation];
    
    for (NSString *key in updatedDefaults.allKeys) {
        NSString *propertyKey = [[self class] propertyKeysBySettingsKey][key];
        propertyKey = propertyKey ?: key;
        
        NSString *prefix = [[self class] settingsKeysPrefix];
        if (prefix) {
            propertyKey = [propertyKey stringByReplacingOccurrencesOfString:prefix withString:@""];
            propertyKey = [NSString stringWithFormat:@"%@%@", [[propertyKey substringToIndex:1] lowercaseString], [propertyKey substringFromIndex:1]];
        }
        
        if ([self respondsToSelector:NSSelectorFromString(propertyKey)]) {
            id value = [self valueForKey:propertyKey];
            id newValue = updatedDefaults[key];
            
            if (![value isEqual:newValue]) {
                [self setValue:newValue forKey:propertyKey];
            }
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end