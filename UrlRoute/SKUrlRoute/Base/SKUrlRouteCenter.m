//
//  SKUrlRouteCenter.m
//  UrlRoute
//
//  Created by lon on 2017/10/13.
//  Copyright © 2017年 lon. All rights reserved.
//

#import "SKUrlRouteCenter.h"
#import "SKUrlRouteData.h"
#import "UIApplication+SKUrlRoute.h"
@implementation SKUrlRouteCenter
NSString* localRouteUrl(NSString *routekey) {

    return [LocalRouteUrlPrefix stringByAppendingString:routekey];
}

+ (void)open:(NSString *)urlkry animated:(BOOL)animated{

    [self open:urlkry animated:animated URLRedirectType:kUrlRedirectPush];
}

+ (void)open:(NSString *)urlkry animated:(BOOL)animated URLRedirectType:(UrlRedirectType)type{

    [self open:urlkry animated:animated URLRedirectType:type extraParams:nil];
}

+ (void)open:(NSString *)urlkry animated:(BOOL)animated extraParams:(NSDictionary *)extraParams{

    [self open:urlkry animated:animated URLRedirectType:kUrlRedirectPush extraParams:extraParams];
}

+ (void)open:(NSString *)urlkey animated:(BOOL)animated URLRedirectType:(UrlRedirectType)type extraParams:(NSDictionary *)extraParams{

    if ([urlkey isKindOfClass:[NSURL class]]) {
        urlkey = [((NSURL *)urlkey) absoluteString];
    }

    if ([SKUrlRouteData isWebUrl:urlkey]) {
        //判断当前的urlKey 是否是 网址

        NSString *urlStr = [SKUrlRouteData findUrlWithUrlKey:urlkey extraParams:extraParams];
        [self goToWeb:urlStr animated:animated URLRedirectType:type];

    }else{

        if (!extraParams) {
            extraParams = [SKUrlRouteData  findParamsContainInUrlKey:urlkey];
        }

        UIViewController *vc = [SKUrlRouteData  findVCWithUrlKey:urlkey extraParams:extraParams];
        [self goToVC:vc animated:animated URLRedirectType:type];
    }
}

#pragma mark Method
+ (void)goToWeb:(NSString *)urlStr animated:(BOOL)animated URLRedirectType:(UrlRedirectType)type {

    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlStr]];

}

+ (void)goToVC:(UIViewController *)vc animated:(BOOL)animated URLRedirectType:(UrlRedirectType)type {

    switch (type) {
        case kUrlRedirectPop:
            [self popToVC:vc animated:animated];
            break;
        case kUrlRedirectPush:
            [self pushToVC:vc animated:animated];
            break;
        case kUrlRedirectPresent:
            [self presentToVC:vc animated:animated];
            break;
        case kUrlRedirectDismiss:
            [self dismissToVC:vc animated:animated];
            break;
        default:
            [self goToErrorVC];
            break;
    }
}

+ (void)closeWithAnimated:(BOOL)animated {

    [self close:nil animated:animated];
}

+ (void)close:(NSString *)url animated:(BOOL)animated {

//    if ([SKUrlRouteData getCurrentVC].navigationController && [SKUrlRouteData getCurrentVC].navigationController.viewControllers.count > 1) {
//
//        //才可以理解为是popVC
//        UIViewController *vc = [SKUrlRouteData findVCWithUrlKey:url extraParams:nil];
//        [self goToVC:vc animated:animated URLRedirectType:kUrlRedirectPop];
//    }else {
//
//        UIViewController *vc = [SKUrlRouteData findVCWithUrlKey:url extraParams:nil];
//        [self goToVC:vc animated:animated URLRedirectType:kUrlRedirectDismiss];
//    }
    if ([UIApplication sharedApplication].currentViewController.navigationController && [UIApplication sharedApplication].currentViewController.navigationController.viewControllers.count > 1) {

        //才可以理解为是popVC
        UIViewController *vc = [SKUrlRouteData findVCWithUrlKey:url extraParams:nil];
        [self goToVC:vc animated:animated URLRedirectType:kUrlRedirectPop];
    }else {

        UIViewController *vc = [SKUrlRouteData findVCWithUrlKey:url extraParams:nil];
        [self goToVC:vc animated:animated URLRedirectType:kUrlRedirectDismiss];
    }
}


+ (void)popToVC:(UIViewController *)vc animated:(BOOL)animated{

//    if (!vc) {
//        UINavigationController *nav = [SKUrlRouteData getCurrentVC].navigationController;
//        [nav popViewControllerAnimated:animated];
//        
//    }else{
//        UINavigationController *nav = [SKUrlRouteData getCurrentVC].navigationController;
//        [nav popToViewController:vc animated:animated];
//    }

    if (!vc) {
        UINavigationController *nav = [UIApplication sharedApplication].currentViewController.navigationController;
        [nav popViewControllerAnimated:animated];

    }else{
        UINavigationController *nav = [UIApplication sharedApplication].currentViewController.navigationController;
        [nav popToViewController:vc animated:animated];
    }
}

+ (void)pushToVC:(UIViewController *)vc animated:(BOOL)animated{

//    if (vc) {
//
//        UINavigationController *nav = [SKUrlRouteData getCurrentVC].navigationController;
//        
//        [nav pushViewController:vc animated:animated];
//    }else{
//
//        [self goToErrorVC];
//    }
    if (vc) {

        UINavigationController *nav =  [UIApplication sharedApplication].currentViewController.navigationController;

        [nav pushViewController:vc animated:animated];
    }else{

        [self goToErrorVC];
    }
}

+ (void)presentToVC:(UIViewController *)vc animated:(BOOL)animated{

//    if (vc) {
//
//        UINavigationController *nv=[[UINavigationController alloc]initWithRootViewController:vc];
//        [[SKUrlRouteData getCurrentVC] presentViewController:nv animated:animated completion:nil];
//        
//    }else{
//
//        [self goToErrorVC];
//    }
    if (vc) {

        UINavigationController *nv=[[UINavigationController alloc]initWithRootViewController:vc];
        [[UIApplication sharedApplication].currentViewController presentViewController:nv animated:animated completion:nil];

    }else{

        [self goToErrorVC];
    }

}

+ (void)dismissToVC:(UIViewController *)vc animated:(BOOL)animated{

//    UINavigationController *nav = [SKUrlRouteData getCurrentVC].navigationController;
//    if(nav == nil){
//
//        [[SKUrlRouteData getCurrentVC] dismissViewControllerAnimated:animated completion:nil];
//    }else{
//        
//        [[SKUrlRouteData getCurrentVC].navigationController dismissViewControllerAnimated:animated completion:nil];
//        }

    UINavigationController *nav = [UIApplication sharedApplication].currentViewController.navigationController;
    if(nav == nil){

        [[UIApplication sharedApplication].currentViewController dismissViewControllerAnimated:animated completion:nil];
    }else{

        [[UIApplication sharedApplication].currentViewController.navigationController dismissViewControllerAnimated:animated completion:nil];
    }
}

+ (void)goToErrorVC{
    
    NSLog(@"goToErrorVC");
}

@end
