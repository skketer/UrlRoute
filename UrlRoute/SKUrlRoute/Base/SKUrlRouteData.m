//
//  SKUrlRouteData.m
//  UrlRoute
//
//  Created by lon on 2017/10/13.
//  Copyright © 2017年 lon. All rights reserved.
//

#import "SKUrlRouteData.h"

@interface SKUrlRouteData ()

@property(nonatomic,strong)  NSDictionary *mappingData;

@end

@implementation SKUrlRouteData

+ (instancetype)shareInstance{
    static SKUrlRouteData *shareRoutedData = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareRoutedData = [[SKUrlRouteData alloc]init];
    });
    return shareRoutedData;
}
- (NSDictionary *)mappingData {

    //这里可以更新动态更新map
    if (!_mappingData) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SKUrlRouteFile" ofType:@"plist" inDirectory:nil];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        _mappingData = dict;
    }
    return _mappingData;

}
//找到参数
+ (NSDictionary *)findParamsContainInUrlKey:(NSString *)urlKey{

    NSRange range = [urlKey rangeOfString:@"?"];
    if (range.length != 0) {

        NSString *paramsStr = [urlKey substringFromIndex:(range.location + range.length)];
        NSArray *paramsArr = [paramsStr componentsSeparatedByString:@"&"];

        NSMutableDictionary *mutDict = [[NSMutableDictionary alloc]init];
        for (NSString *str in paramsArr) {
            NSArray *arr = [str componentsSeparatedByString:@"="];
            if (arr.count == 2) {
                NSString *key = [arr firstObject];
                id value = [arr lastObject];
                [mutDict setObject:value forKey:key];
            }else {
                continue;
            }
        }

        return [mutDict copy];
    }

    return nil;
}
+ (BOOL)isWebUrl:(NSString *)urlKey{

    if (!urlKey) {
        return NO;
    }
    //先这样简单的判断 还有ftp:// 什么的
    if ([self checkUrlPathValid:urlKey]) {
        return YES;
    }

    //如果urlkey 本身不是一个网址 那么相对于的类 是不是一个连接地址
    NSString *className = [self classNameWithKey:urlKey];
    if ([self checkUrlPathValid:className]) {
        return YES;
    }

    return NO;
}

+ (UIViewController *)findVCWithUrlKey:(NSString *)key extraParams:(NSDictionary *)extraParams{

    NSString  *className = [self classFromUrlKey:key];
    UIViewController *bridgeVC = [[NSClassFromString(className) alloc]init];
    if([extraParams isKindOfClass:[NSDictionary class]] || !extraParams){

        //        [bridgeVC modelSetWithDictionary:valueDic];
        @try {
            NSArray *allKey = extraParams.allKeys;
            for (NSString *key in allKey) {
                [bridgeVC setValue:extraParams[key] forKey:key];
            }
        } @catch (NSException *exception) {

        } @finally {

        }


        return bridgeVC;
    }else {
        return nil;
    }
}
+ (NSString *)findUrlWithUrlKey:(NSString *)key extraParams:(NSDictionary *)extraParams{

    NSString *urlStr = nil;
    if ([self checkUrlPathValid:key]) {
        urlStr = key;
    }

    NSString *className = [self classNameWithKey:key];
    if ([self checkUrlPathValid:className]) {
        urlStr = className;
    }

    for (int i = 0; i < extraParams.allKeys.count ; i ++) {
        if (i == 0) {
            [urlStr stringByAppendingString:@"?"];
        }else {

            [urlStr stringByAppendingString:@"&"];
        }
        NSString *key =  extraParams.allKeys[i];
        NSString *str = [NSString stringWithFormat:@"%@=%@",key,extraParams[key]];
        [urlStr stringByAppendingString:str];
    }

    return urlStr;
}

//根据urlkey 找出class 字符串
+ (NSString *)classFromUrlKey:(NSString *)urlkey {

    if (urlkey) {

        NSString *className = [self classNameWithKey:urlkey];
        return className;
    }else {

        return nil;
    }

}
//根据key找到类名
+ (NSString *)classNameWithKey:(NSString *)key{

    if (!key) {
        return nil;
    }

    NSURL *url = [NSURL URLWithString:key];
    NSString *classNameKey = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@%@",url.host,url.path]];

    return [SKUrlRouteData shareInstance].mappingData[classNameKey];
}

+ (BOOL)checkUrlPathValid:(NSString *)urlStr{

    if (urlStr) {

        NSString *regx = @"(http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&amp;*+?:_/=<>]*)?";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
        return [predicate evaluateWithObject:urlStr];

    }
    return NO;
}

+ (UIViewController *)getCurrentVC {

    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {

            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {

            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {

            vc = vc.presentedViewController;
        }else {
            break;
        }
    }
    return vc;
}
@end
