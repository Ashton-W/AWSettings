#import <AWSettings/AWSettings.h>

@interface Settings : AWSettings

@property (nonatomic) NSString *name;
@property (nonatomic) BOOL enabled;
@property (nonatomic) NSNumber *slider;

@end
