The solution involves using blocks and GCD timers instead of `performSelector:withObject:afterDelay:`. This avoids the potential for the object to be deallocated before the delayed method call.

```objectivec
#import "MyObject.h"

@implementation MyObject
- (void)myMethod {
    NSLog(@"My method is executed");
}

- (void)dealloc {
    NSLog(@"MyObject deallocated");
}

- (void)scheduleMethod:(void (^)(void))block afterDelay:(NSTimeInterval)delay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}
@end

//In some other class
MyObject *obj = [[MyObject alloc] init];
[obj scheduleMethod:^{ [obj myMethod]; } afterDelay:2.0];
obj = nil; //This won't cause a crash

```