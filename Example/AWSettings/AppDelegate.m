#import "AppDelegate.h"
#import "Settings.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self;
    [self.window makeKeyAndVisible];
    
    NSLog(@"Hello World!");
    
    return YES;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.label = [[UILabel alloc] initWithFrame:self.view.bounds];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
    [[Settings sharedSettings] addObserver:self
                                forKeyPath:@"name"
                                   options:(NSKeyValueObservingOptions)(NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew)
                                   context:0];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"Hello, %@", [Settings sharedSettings].name);
    self.label.text = [Settings sharedSettings].name;
}

@end
