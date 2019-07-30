//
//  FZNotifier.m
//  FZMyLibiary
//
//  Created by 吴福增 on 2019/7/30.
//

#import "FZNotifier.h"

@interface FZNotifier ()

@property (nonatomic, strong) NSHashTable *subscribers;

@end

@implementation FZNotifier

+ (id)alloc {return [FZNotifier notifier:NO];}
+ (instancetype)notifier {return [FZNotifier notifier:NO];}
+ (instancetype)ratainNotifier {return [FZNotifier notifier:YES];}
+ (instancetype)notifier:(BOOL)shouldRetainObserver {
    FZNotifier *notifier = [super alloc];
    notifier.subscribers = [NSHashTable hashTableWithOptions:shouldRetainObserver ? NSPointerFunctionsStrongMemory : NSPointerFunctionsWeakMemory];
    return notifier;
}

#pragma mark - Interface --

- (void)addSubscriber:(id)subscriber {
    if (subscriber) {
        dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
        [self.subscribers addObject:subscriber];
        dispatch_semaphore_signal(self.lock);
    }
}

- (void)removeSubscriber:(id)subscriber {
    if (subscriber) {
        dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
        [self.subscribers removeObject:subscriber];
        dispatch_semaphore_signal(self.lock);
    }
}

#pragma mark - Override --

- (BOOL)respondsToSelector:(SEL)aSelector {
    for (id observer in self.subscribers.allObjects) {
        if ([observer respondsToSelector:aSelector]) { return YES; }
    }
    return NO;
}

#pragma mark - Forward --

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    for (id observer in self.subscribers.allObjects) {
        NSMethodSignature *signature = [observer methodSignatureForSelector:aSelector];
        if (signature) { return signature; }
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    for (id observer in self.subscribers.allObjects) {
        if ([observer respondsToSelector:invocation.selector]) {
            [invocation invokeWithTarget:observer];
        }
    }
}

#pragma mark - Getter --

- (dispatch_semaphore_t)lock {
    static dispatch_semaphore_t lock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock = dispatch_semaphore_create(1);
    });
    return lock;
}


@end
