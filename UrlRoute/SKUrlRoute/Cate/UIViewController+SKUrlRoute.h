//
//  UIViewController+SKUrlRoute.h
//  UrlRoute
//
//  Created by lon on 2017/10/13.
//  Copyright © 2017年 lon. All rights reserved.
//

#import <UIKit/UIKit.h>
//customMsg 用户做一些判断 或者返回的标记 页面间自定义
typedef void (^DataReCallBlock)(id customValue);

@interface UIViewController (SKUrlRoute)

@property(nonatomic,copy) DataReCallBlock routeReCallBlock;

@end
