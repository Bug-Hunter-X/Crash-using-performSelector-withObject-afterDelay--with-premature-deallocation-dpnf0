# Objective-C Crash with performSelector:withObject:afterDelay:

This repository demonstrates a common Objective-C bug involving the `performSelector:withObject:afterDelay:` method.  The issue occurs when the object targeted by the selector is deallocated before the specified delay has elapsed, resulting in a crash.

## Bug Description:
The code uses `performSelector:withObject:afterDelay:` to call a method on an object after a delay. If the object's reference count drops to zero (it gets deallocated) before the delay is complete, the method invocation will fail, resulting in a crash with an exception: `-[NSInvocation invoke]: message sent to deallocated instance 0x...`

## Solution:
The provided solution addresses the problem by using blocks and GCD (Grand Central Dispatch) timers to schedule the method call. This approach ensures that the method is executed safely even if the object is deallocated.