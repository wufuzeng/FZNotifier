//
//  FZViewController.m
//  FZNotifier
//
//  Created by wufuzeng on 07/30/2019.
//  Copyright (c) 2019 wufuzeng. All rights reserved.
//

#import "FZViewController.h"

#import <FZNotifier/FZNotifier.h>
#import "FZClassA.h"
#import "FZClassB.h"
@interface FZViewController ()
@property (nonatomic,strong) FZNotifier<FZViewControllerProtocol> *notifier;
@property (nonatomic,strong) FZClassA *a;
@property (nonatomic,strong) FZClassB *b;
@end

@implementation FZViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.a = [FZClassA new];
    self.b = [FZClassB new];
    
    [self addSubscriber:self.a];
    [self addSubscriber:self.b];
    
    if ([self.notifier respondsToSelector:@selector(testFunc:praram:)]) {
        [self.notifier testFunc:@(9) praram:@(1)];
    }
}


- (void)addSubscriber:(id<FZViewControllerProtocol>)subscriber{
    [self.notifier addSubscriber:subscriber];
}


-(FZNotifier *)notifier{
    if (_notifier == nil) {
        _notifier = (id)[FZNotifier notifier];
    }
    return _notifier;
}

@end
