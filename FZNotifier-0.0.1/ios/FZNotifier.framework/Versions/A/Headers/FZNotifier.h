//
//  FZNotifier.h
//  FZMyLibiary
//
//  Created by 吴福增 on 2019/7/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FZNotifier : NSObject

+ (instancetype)notifier;
+ (instancetype)ratainNotifier;

- (void)addSubscriber:(id)subscriber;
- (void)removeSubscriber:(id)subscriber;

@end

NS_ASSUME_NONNULL_END
