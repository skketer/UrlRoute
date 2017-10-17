//
//  UIViewController+SKUrlRoute.m
//  UrlRoute
//
//  Created by lon on 2017/10/13.
//  Copyright © 2017年 lon. All rights reserved.
//

#import "UIViewController+SKUrlRoute.h"
#import <objc/runtime.h>
#import "UIApplication+SKUrlRoute.h"
@implementation UIViewController (SKUrlRoute)
static char routeReCallBlockKey;

@dynamic routeReCallBlock;

+(void)load {
    //swizzle方法调换
    SEL originalSelector = @selector(viewWillAppear:);
    SEL swizzleSelector = @selector(trick_viewWillAppear:);

    Method originalMethod = class_getInstanceMethod([self class], originalSelector);
    Method swizzleMethod = class_getInstanceMethod([self class], swizzleSelector);

    method_exchangeImplementations(originalMethod, swizzleMethod);
}

-(void)trick_viewWillAppear:(BOOL)animated{

    [self trick_viewWillAppear:animated];

    NSBundle *mainB = [NSBundle bundleForClass:[self class]];
    if (mainB == [NSBundle mainBundle]) {
        [UIApplication sharedApplication].currentViewController = self;
    }
}

#pragma mark routeReCallBlock set&get

-(void)setRouteReCallBlock:(DataReCallBlock)routeReCallBlock {

    objc_setAssociatedObject(self, &routeReCallBlockKey, routeReCallBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(DataReCallBlock)routeReCallBlock{

    return objc_getAssociatedObject(self, &routeReCallBlockKey);
}


@end
