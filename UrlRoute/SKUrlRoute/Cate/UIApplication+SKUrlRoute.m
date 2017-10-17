//
//  UIApplication+SKUrlRoute.m
//  UrlRoute
//
//  Created by lon on 2017/10/14.
//  Copyright © 2017年 lon. All rights reserved.
//

#import "UIApplication+SKUrlRoute.h"
#import <objc/runtime.h>
@implementation UIApplication (SKUrlRoute)
-(void)setCurrentViewController:(UIViewController *)currentViewController
{
    objc_setAssociatedObject(self, @selector(currentViewController), currentViewController, OBJC_ASSOCIATION_ASSIGN);
}

-(UIViewController *)currentViewController
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
