This bug is related to the use of `performSelector:withObject:afterDelay:` method in Objective-C. The issue arises when the object on which this method is called is deallocated before the delay time expires.  This leads to a crash with an exception similar to `-[NSInvocation invoke]: message sent to deallocated instance 0x...`

```objectivec
@interface MyObject : NSObject
- (void)myMethod;
@end

@implementation MyObject
- (void)myMethod {
    NSLog(@"My method is executed");
}

- (void)dealloc {
    NSLog(@"MyObject deallocated");
}
@end

//In some other class
MyObject *obj = [[MyObject alloc] init];
[obj performSelector:@selector(myMethod) withObject:nil afterDelay:2.0];
obj = nil; //If this happens before delay is over, a crash happens
```