//
//  SKUrlRouteConfig.h
//  UrlRoute
//
//  Created by lon on 2017/10/13.
//  Copyright © 2017年 lon. All rights reserved.
//

#ifndef SKUrlRouteConfig_h
#define SKUrlRouteConfig_h

typedef NS_ENUM (NSUInteger,UrlRedirectType){
    kUrlRedirectPush = 1,       /**< push操作 */
    kUrlRedirectPop = 2,        /**< pop操作 */
    kUrlRedirectPresent = 3,    /**< present 操作 */
    kUrlRedirectDismiss = 4,    /**< dismissViewController 操作 */

};


//配置 跳转的scheme
#define LocalRouteUrlPrefix  @"local://"    /**< app内页面跳转的url */
#define ThirdRouteUrlPrefix   @"App://"   /**< 第三方的跳转到app内 */


#endif /* SKUrlRouteConfig_h */
