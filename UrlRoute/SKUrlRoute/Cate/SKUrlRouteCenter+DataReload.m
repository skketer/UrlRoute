//
//  SKUrlRouteCenter+DataReload.m
//  UrlRoute
//
//  Created by lon on 2017/10/13.
//  Copyright © 2017年 lon. All rights reserved.
//

#import "SKUrlRouteCenter+DataReload.h"
#import "SKUrlRouteData.h"
@implementation SKUrlRouteCenter (DataReload)
/**
 *  url跳转   默认是push 操作
 *
 *  @param urlkey   跳转路径（可以是网址、也可以是协议）
 *  @param animated 是否需要动画
 */
+ (void)open:(NSString *)urlkey animated:(BOOL)animated WithReloadBlock:(DataReCallBlock)block{

    [self open:urlkey animated:animated URLRedirectType:kUrlRedirectPush extraParams:nil WithReloadBlock:block];
}

/**
 *  url跳转   默认是push操作
 *
 *  @param urlkey      跳转路径（可以是网址、也可以是协议）
 *  @param animated    是否需要动画
 *  @param extraParams 额外的参数
 */
+ (void)open:(NSString *)urlkey animated:(BOOL)animated extraParams:(NSDictionary *)extraParams WithReloadBlock:(DataReCallBlock)block{

    [self open:urlkey animated:animated URLRedirectType:kUrlRedirectPush extraParams:extraParams WithReloadBlock:block];
}


/**
 *  url跳转
 *
 *  @param urlkey   跳转路径（可以是网址、也可以是协议）
 *  @param animated 是否需要动画
 *  @param type     跳转动作
 */
+ (void)open:(NSString *)urlkey animated:(BOOL)animated URLRedirectType:(UrlRedirectType)type WithReloadBlock:(DataReCallBlock)block{

    [self open:urlkey animated:animated URLRedirectType:type extraParams:nil WithReloadBlock:block];
}

/**
 *  url跳转
 *
 *  @param urlkey      跳转路径（可以是网址、也可以是协议）
 *  @param animated    是否需要动画
 *  @param type        跳转动作
 *  @param extraParams 额外的参数
 */
+ (void)open:(NSString *)urlkey animated:(BOOL)animated URLRedirectType:(UrlRedirectType)type extraParams:(NSDictionary *)extraParams WithReloadBlock:(DataReCallBlock)block {

    if (urlkey.length == 0) {
        return;
    }

    if ([SKUrlRouteData isWebUrl:urlkey]) {
        //跳转的是网页
        [self goToWeb:urlkey animated:animated URLRedirectType:type];
    }else {

        if (!extraParams) {
            extraParams = [SKUrlRouteData  findParamsContainInUrlKey:urlkey];
        }

        UIViewController *vc = [SKUrlRouteData findVCWithUrlKey:urlkey extraParams:extraParams];
        vc.routeReCallBlock = block;
        [self goToVC:vc animated:animated URLRedirectType:type];
    }
}

@end
