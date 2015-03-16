#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <AWSettings/AWSettings.h>

#pragma clang diagnostic ignored "-Wobjc-missing-property-synthesis"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"
#pragma clang diagnostic ignored "-Wreceiver-is-weak"
#pragma clang diagnostic ignored "-Wgnu"

@interface TestSettings : AWSettings

@property (nonatomic) NSString *stringProperty;
@property (nonatomic) BOOL boolProperty;

@end

@implementation TestSettings

@end

#pragma mark - Tests

@interface AWSettingsTests : XCTestCase

@property (nonatomic) NSUserDefaults *defaults;

@end

@implementation AWSettingsTests

- (void)setUp
{
    self.defaults = [NSUserDefaults standardUserDefaults];
    [super setUp];
}

- (void)tearDown
{
    self.defaults = nil;
    [NSUserDefaults resetStandardUserDefaults];
    [super tearDown];
}

- (void)testKVO
{
    [self.defaults setObject:@"One" forKey:@"stringProperty"];
    TestSettings *settings = [TestSettings sharedSettings];

    XCTAssertEqualObjects(@"One", settings.stringProperty);

    [self keyValueObservingExpectationForObject:settings keyPath:@"stringProperty" expectedValue:@"Two"];

    [self.defaults setObject:@"Two" forKey:@"stringProperty"];

    [self waitForExpectationsWithTimeout:5 handler:NULL];
}

@end
