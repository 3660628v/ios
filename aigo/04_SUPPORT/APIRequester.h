//
//  APIRequester.h
//  VFA_QUEUENCE
//
//  Created by Phan Ba Minh on 2/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#ifdef __DEBUG__DEV__
#define STRING_REQUEST_ROOT                                                 @"http://dev.visikard.vn:6868/vk4"
#endif
#ifdef __RELEASE__DEV__
#define STRING_REQUEST_ROOT                                                 @"http://dev.visikard.vn:6868/vk4"
#endif

#ifdef __DEBUG__DEV__R1__
#define STRING_REQUEST_ROOT                                                 @"http://dev.visikard.vn:6868/vk4"
#endif
#ifdef __RELEASE__DEV__R1__
#define STRING_REQUEST_ROOT                                                 @"http://dev.visikard.vn:6868/vk4"
#endif

#ifdef __DEBUG__DEV__R2__
#define STRING_REQUEST_ROOT                                                 @"http://dev.visikard.vn:6868/vk4"
#endif
#ifdef __RELEASE__DEV__R2__
#define STRING_REQUEST_ROOT                                                 @"http://dev.visikard.vn:6868/vk4"
#endif

#ifdef __DEBUG__DEV1__
//#define STRING_REQUEST_ROOT                                                 @"http://108.166.81.13:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://dev1.visikard.com:6868/vk4"
//#define STRING_REQUEST_ROOT @"http://dev.visikard.vn:6868/vk4prod"
#endif
#ifdef __RELEASE__DEV1__
//#define STRING_REQUEST_ROOT                                                 @"http://108.166.81.13:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://dev1.visikard.com:6868/vk4"
#endif

#ifdef __DEBUG__DEV1__R1__
//#define STRING_REQUEST_ROOT                                                 @"http://108.166.81.13:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://dev2.visikard.vn:6868/vk4v2"
#endif
#ifdef __RELEASE__DEV1__R1__
//#define STRING_REQUEST_ROOT                                                 @"http://108.166.81.13:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://dev2.visikard.vn:6868/vk4v2"
#endif

#ifdef __DEBUG__DEV1__R2__
//#define STRING_REQUEST_ROOT                                                 @"http://108.166.81.13:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://dev2.visikard.vn:6868/vk4v2"
#endif
#ifdef __RELEASE__DEV1__R2__
//#define STRING_REQUEST_ROOT                                                 @"http://108.166.81.13:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://dev2.visikard.vn:6868/vk4v2"
#endif

#ifdef __DEBUG__STAGING1__
//#define STRING_REQUEST_ROOT                                                 @"http://198.101.250.246:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://staging1.visikard.com:6868/vk4"
#endif
#ifdef __RELEASE__STAGING1__
//#define STRING_REQUEST_ROOT                                                 @"http://198.101.250.246:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://staging1.visikard.com:6868/vk4"
#endif

#ifdef __DEBUG__STAGING1__R1__
//#define STRING_REQUEST_ROOT                                                 @"http://198.101.250.246:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://108.166.93.21:6868/vk4"
#endif
#ifdef __RELEASE__STAGING1__R1__
//#define STRING_REQUEST_ROOT                                                 @"http://198.101.250.246:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://108.166.93.21:6868/vk4"
#endif

#ifdef __DEBUG__STAGING1__R2__
//#define STRING_REQUEST_ROOT                                                 @"http://198.101.250.246:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://108.166.93.21:6868/vk4"
#endif
#ifdef __RELEASE__STAGING1__R2__
//#define STRING_REQUEST_ROOT                                                 @"http://198.101.250.246:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://108.166.93.21:6868/vk4"
#endif

#ifdef __DEBUG__PRODUCTION1__
//#define STRING_REQUEST_ROOT                                                 @"http://198.101.250.254:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://www.visikard.com:6868/vk4"
#endif
#ifdef __RELEASE__PRODUCTION1__
//#define STRING_REQUEST_ROOT                                                 @"http://198.101.250.254:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://www.visikard.com:6868/vk4"
#endif

#ifdef __DEBUG__PRODUCTION1__R1__
//#define STRING_REQUEST_ROOT                                                 @"http://198.101.250.254:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://108.171.178.16:6868/vk4"
#endif
#ifdef __RELEASE__PRODUCTION1__R1__
//#define STRING_REQUEST_ROOT                                                 @"http://198.101.250.254:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://108.171.178.16:6868/vk4"
#endif

#ifdef __DEBUG__PRODUCTION1__R2__
//#define STRING_REQUEST_ROOT                                                 @"http://198.101.250.254:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://108.171.178.16:6868/vk4"
#endif
#ifdef __RELEASE__PRODUCTION1__R2__
//#define STRING_REQUEST_ROOT                                                 @"http://198.101.250.254:6868/vk4"
#define STRING_REQUEST_ROOT                                                 @"http://108.171.178.16:6868/vk4"
#endif

//#define STRING_REQUEST_ROOT                                                 @"http://dev.visikard.com:6868/vk4"
//#define STRING_REQUEST_ROOT                                                 @"http://dev1.visikard.com:6868/vk4"
//#define STRING_REQUEST_ROOT                                                 @"http://192.168.2.83:8080/vk4"
//#define STRING_REQUEST_ROOT                                                 @"http://khanh-pc:8080/vk4"
//#define STRING_REQUEST_ROOT                                                 @"http://192.168.2.150:8080/vk4"
//#define STRING_REQUEST_ROOT                                                 @"http://lcalserver.visikard.vn/vk4"
//#define STRING_REQUEST_ROOT                                                 @"http://staging1.visikard.com:6868/vk4"
//#define STRING_REQUEST_ROOT                                                 @"http://216.119.157.11:6868/vk4"
//#define STRING_REQUEST_ROOT                                                 @"http://216.119.158.150:6868/vk4"

#ifndef STRING_REQUEST_ROOT
#define STRING_REQUEST_ROOT                                                 @"http://108.166.81.13:6868/vk4"
#endif

#define TIMER_REQUEST_TIMEOUT											60

//http://dev1.visikard.com:6868/vk4/serversetupinfo/2


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


// BANNER ADS
#define STRING_REQUEST_URL_BANNER_ADS                                  [NSString stringWithFormat:@"%@/accounts/kard/seedpartner/user/ads", STRING_REQUEST_ROOT]

// USER
#define STRING_REQUEST_URL_USER_LOGIN                                   [NSString stringWithFormat:@"%@/accounts/login", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_USER_LOGOUT                                  [NSString stringWithFormat:@"%@/session/delete", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_USER_LOGIN_WITH_FB_TW						[NSString stringWithFormat:@"%@/accounts/other/app/add", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_USER_UPDATE_LOCATION                         [NSString stringWithFormat:@"%@/session/lacation/setting", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_USER_UPDATE_LOCATION_AND_GPS                 [NSString stringWithFormat:@"%@/session/set/gps/lacation/add", STRING_REQUEST_ROOT] 
#define STRING_REQUEST_URL_USER_GET_PROFILE                             [NSString stringWithFormat:@"%@/accounts/profile/default", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_USER_UPDATE_ONLINE_STATUS                    [NSString stringWithFormat:@"%@/session/update", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_USER_CHANGE_PASSWORD                         [NSString stringWithFormat:@"%@/accounts/change/password", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_USER_FULL_NAME                               [NSString stringWithFormat:@"%@/accounts/settings", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_USER_RECOVERY_PASSWORD                       [NSString stringWithFormat:@"%@/accounts/forget/password/user", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_USER_CHECK_INVATION_CODE                     [NSString stringWithFormat:@"%@/accounts/invitation/code/check/exist", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_USER_FORGET_PASSWORD                         [NSString stringWithFormat:@"%@/accounts/recovery/forget/password", STRING_REQUEST_ROOT] 
// KARDS
#define STRING_REQUEST_URL_KARDS_GET_ALL                                [NSString stringWithFormat:@"%@/konnect/NotAccepted/Accepted/user", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_GET_ALL_FOR_SETTING                     [NSString stringWithFormat:@"%@/konnect/user/accepted",STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARDS_GET_ME                                 [NSString stringWithFormat:@"%@/kards/user", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARDS_DELETE                                 [NSString stringWithFormat:@"%@/kards/delete", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_MY_KARDS_SETTING                             [NSString stringWithFormat:@"%@/kards/setting/my/kard", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARDS_CHANGE_PROFILE                         [NSString stringWithFormat:@"%@/profile/change/kard", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARDS_CHECK_IN                               [NSString stringWithFormat:@"%@/backkard/checkin", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARDS_CHECK_OUT                              [NSString stringWithFormat:@"%@/backkard/checkout", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_SHARE_KARD_VIA_KONNECT                  [NSString stringWithFormat:@"%@/konnect/share/kard/add", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_REPLACE_ALL_KONNECT                     [NSString stringWithFormat:@"%@/kards/relation/from/to", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_REPLACE_SIMPLE_KONNECT                  [NSString stringWithFormat:@"%@/kards/relation/kard/konnect", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_SEARCH_MY_KARDS                         [NSString stringWithFormat:@"%@/konnect/user/accepted/search/kard", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_ME_KARDS_TRADED_ONE_KARD                     [NSString stringWithFormat:@"%@/konnect/accepted/me", STRING_REQUEST_ROOT] 
#define STRING_REQUEST_URL_KARDS_GET_SHARE_KARD                         [NSString stringWithFormat:@"%@/konnect/NotAccepted/Accepted/share/kard", STRING_REQUEST_ROOT]

// KONNECT
#define STRING_REQUEST_URL_KONNECT_GET_ALL                              [NSString stringWithFormat:@"%@/session/all", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KONNECT_GET_PENDING                          [NSString stringWithFormat:@"%@/konnect/user/notaccepted/all", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_TRADE_PENDING							[NSString stringWithFormat:@"%@/konnect/add", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_TRADE_APPROVE							[NSString stringWithFormat:@"%@/konnect/update", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_TRADE_DISAPPROVE                        [NSString stringWithFormat:@"%@/konnect/untrade", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_TRADE_CANCEL                            [NSString stringWithFormat:@"%@/konnect/untrade", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_SET_VISIBILITY                          [NSString stringWithFormat:@"%@/konnect/setting", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_TRADE_DELETE                            [NSString stringWithFormat:@"%@/konnect/delete", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_TRADE_UNHIDE                            [NSString stringWithFormat:@"%@/deck/unhide/delete/kard/traded", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_TRADE_HIDE                              [NSString stringWithFormat:@"%@/deck/delete/kard/traded", STRING_REQUEST_ROOT]

#define STRING_REQUEST_URL_KONNECT_SEARCH                               [NSString stringWithFormat:@"%@/konnect/search/kard", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KONNECT_MUTUAL_TRADE                         [NSString stringWithFormat:@"%@/konnect/view/mutual/kard", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KONNECT_DELETE_MY_KARDS                      [NSString stringWithFormat:@"%@/konnect/delete/kard", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KONNECT_MULTIPLE_PENDING_KARD                [NSString stringWithFormat:@"%@/konnect/user/my/kard/traded", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KONNECT_APPROVE_ALL                          [NSString stringWithFormat:@"%@/konnect/approve/pending/trade/kard", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KONNECT_DISAPPROVE_ALL                       [NSString stringWithFormat:@"%@/konnect/deny/pending/trade/kard", STRING_REQUEST_ROOT]

#define STRING_REQUEST_URL_KONNECT_HOME_GET_ALL                         [NSString stringWithFormat:@"%@/session/konnect/home/app", STRING_REQUEST_ROOT]

// KARD BUILDER
#define STRING_REQUEST_URL_KARD_BUILDER_GET_TEMPLATE                    [NSString stringWithFormat:@"%@/kardtemplates/category", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_BUILDER_GET_BORDER_TEMPLATE_STRUCTURE   [NSString stringWithFormat:@"%@/bordertemplates/template/user", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_BUILDER_GET_BORDER_TEMPLATE             [NSString stringWithFormat:@"%@/bordertemplates", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_BUILDER_CHECK_EXIST_KARD_NAME           [NSString stringWithFormat:@"%@/kard/check/exist/name", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_BUILDER_CHECK_EXIST_PROFILE_NAME        [NSString stringWithFormat:@"%@/profile/check/exist/name", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_BUILDER_GET_GRAPHIC_ALL                 [NSString stringWithFormat:@"%@/trophytemplates/all", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_BUILDER_GET_GRAPHIC                     [NSString stringWithFormat:@"%@/trophytemplates", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_BUILDER_ADD                             [NSString stringWithFormat:@"%@/kards/add", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_BUILDER_ADD_IMAGE                       [NSString stringWithFormat:@"%@/kards/upload/addImage", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_BUILDER_SET_PROFILE_DEFAULT             [NSString stringWithFormat:@"%@/profiles/change", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_BUILDER_TEMPLATE_ADD                    [NSString stringWithFormat:@"%@/kards/new/add", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_BUILDER_TEMPLATE_EDIT_POST              [NSString stringWithFormat:@"%@/kards/update/add", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_BUILDER_TEMPLATE_EDIT_GET               [NSString stringWithFormat:@"%@/kards/edit/detail", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_BUILDER_UPLOAD_ORIGINAL_IMAGE           [NSString stringWithFormat:@"%@/image/upload/images/add", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_KARD_BUILDER_UPLOAD_ORIGINAL_IMAGE_IMPLICIT  [NSString stringWithFormat:@"%@/image/upload/images/savekard", STRING_REQUEST_ROOT]

// PROFILE
#define STRING_REQUEST_URL_PROFILES_GET                                 [NSString stringWithFormat:@"%@/profiles/user", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_PROFILES_ADD                                 [NSString stringWithFormat:@"%@/profiles/add", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_PROFILE_DELETE                               [NSString stringWithFormat:@"%@/profiles/delete", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_PROFILES_UPDATE                              [NSString stringWithFormat:@"%@/profiles/update", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_PROFILES_COUNTRY                             [NSString stringWithFormat:@"%@/profile/country/all", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_PROFILES_CITY                                [NSString stringWithFormat:@"%@/profile/country/city", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_PROFILES_DETAIL                              [NSString stringWithFormat:@"%@/profiles", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_PROFILES_MY_KARDS                            [NSString stringWithFormat:@"%@/profile/manager/kard", STRING_REQUEST_ROOT]

// NEW DEALS
#define STRING_REQUEST_URL_DEAL_GET_BY_CITY_CATEGORY_DISTANCE_SORTED                             [NSString stringWithFormat:@"%@/deals/category", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_DEAL_GET_CITY_SETTING                             [NSString stringWithFormat:@"%@/deals/settingdeal/getcitysettings", STRING_REQUEST_ROOT]

// DEALS
#define STRING_REQUEST_URL_DEAL_GET_ALL                                 [NSString stringWithFormat:@"%@/deals/all", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_DEAL_GET_MY                                  [NSString stringWithFormat:@"%@/deals/mydeals/all", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_DEAL_GET_CATEGORY                            [NSString stringWithFormat:@"%@/deals/category", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_DEAL_GET_BY_CITY                             [NSString stringWithFormat:@"%@/deals/all/bycity", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_DEAL_GET_ALL_CITY                            [NSString stringWithFormat:@"%@/deals/getallcities", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_DEAL_GET_DETAIL                              [NSString stringWithFormat:@"%@/backkard/deals/info", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_DEAL_GET_MESSAGE                             [NSString stringWithFormat:@"%@/backkard/message", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_DEAL_GET_MESSAGE                             [NSString stringWithFormat:@"%@/backkard/message", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_DEAL_PASS                                    [NSString stringWithFormat:@"%@/deals/adddealtootheruser", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_DEAL_GET_INFO_SETTING                        [NSString stringWithFormat:@"%@/deals/settingdeal/getmysettingspriority", STRING_REQUEST_ROOT] 
#define STRING_REQUEST_URL_DEAL_SET_PRIORITY_SETTING                    [NSString stringWithFormat:@"%@/deals/settingdeal/priority", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_DEAL_GET_CITIES_DISTANCE                     [NSString stringWithFormat:@"%@/deals/getallcities/sortbydistance", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_DEAL_SET_CITY                                [NSString stringWithFormat:@"%@/deals/settingdeal/city", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_DEAL_BUY_DEAL                                [NSString stringWithFormat:@"%@/deals/buydeal", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_DEAL_CANCEL_PASS                             [NSString stringWithFormat:@"%@/deals/cancle", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_DEAL_APPROVE                                 [NSString stringWithFormat:@"%@/deals/pass", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_DEAL_MAP_DIRECTION                           @"http://maps.googleapis.com/maps/api/directions/json?"
// REWARDS

#define STRING_REQUEST_URL_REWARDS_GET_ALL                              [NSString stringWithFormat:@"%@/product/getall", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_REWARDS_GET_MY                               [NSString stringWithFormat:@"%@/product/all/my/reward", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_REWARDS_GET_MAP                              [NSString stringWithFormat:@"%@/product/get/top20", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_REWARDS_SAVE_SETTINGS                        [NSString stringWithFormat:@"%@/point/seting", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_REWARDS_PURCHASE                             [NSString stringWithFormat:@"%@/point/user/get/it/now", STRING_REQUEST_ROOT]

// POINTS
#define STRING_REQUEST_URL_POINTS_GET_LEVEL                             [NSString stringWithFormat:@"%@/point/get/point/level", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_POINTS_GET_EARN_POINTS                       [NSString stringWithFormat:@"%@/point/user/earn", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_POINTS_GET_SPENT_POINTS                      [NSString stringWithFormat:@"%@/point/user/spend", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_POINTS_GET_EARN_SPENT_POINTS                 [NSString stringWithFormat:@"%@/point/user/earn/spend", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_POINTS_GET_BADGES_ALL                        [NSString stringWithFormat:@"%@/reward/get/all/badge/0", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_POINTS_GET_BADGES_MY                         [NSString stringWithFormat:@"%@/reward/get/all/badge/1", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_POINTS_GET_BADGES_USER                       [NSString stringWithFormat:@"%@/reward/get/my/badge/user", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_POINTS_GET_EARN_POINTS_BY_TYPE               [NSString stringWithFormat:@"%@/point/earn/point/type/user", STRING_REQUEST_ROOT]


// FEEDS
#define STRING_REQUEST_URL_FEEDS_GET_KONNECT                            [NSString stringWithFormat:@"%@/news/feed/user", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_FEEDS_GET_COMMENTS                           [NSString stringWithFormat:@"%@/newsresponse", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_FEEDS_POST_COMMENTS                          [NSString stringWithFormat:@"%@/newsresponse/add", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_FEEDS_ADD                                    [NSString stringWithFormat:@"%@/news/thread/add", STRING_REQUEST_ROOT]

#define STRING_REQUEST_URL_FEEDS_PRIORITISE                             [NSString stringWithFormat:@"%@/news/prioritize", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_FEEDS_UN_PRIORITISE                          [NSString stringWithFormat:@"%@/news/unprioritize", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_FEEDS_HIDE                                   [NSString stringWithFormat:@"%@/news/hideupdate", STRING_REQUEST_ROOT]

#define STRING_REQUEST_URL_FEEDS_KARDS                                  [NSString stringWithFormat:@"%@/news/mykard/setting", STRING_REQUEST_ROOT]

#define STRING_REQUEST_URL_PRIORITISE_KKARD                             [NSString stringWithFormat:@"%@/news/prioritize/kard", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_UN_PRIORITISE_KKARD                          [NSString stringWithFormat:@"%@/news/unprioritize/kard", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_HIDE_KARD                                    [NSString stringWithFormat:@"%@/news/hide/kard", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_UN_HIDE_KARD                                 [NSString stringWithFormat:@"%@/news/unhide/kard", STRING_REQUEST_ROOT]
#define STRING_REQUEST_FEEDS_URL_FEEDS_CHECK_UNREAD                     [NSString stringWithFormat:@"%@/news/set/read/this", STRING_REQUEST_ROOT]                  

// BACK OF KARD
#define STRING_REQUEST_URL_BACKARD_PRIVATE_MESSAGE                      [NSString stringWithFormat:@"%@/news/message/kard", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_BACKARD_PRIVATE_CONVERSATION_DETAILS         [NSString stringWithFormat:@"%@/news/message/view", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_BACKARD_MESSAGE                              [NSString stringWithFormat:@"%@/news/feed/back/kard", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_BACKARD_INFO                                 [NSString stringWithFormat:@"%@/kards/back/view/info", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_BACKARD_ADD_COMMENT                          [NSString stringWithFormat:@"%@/news/feed/newsresponse/add", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_BACKARD_ADD_MESSAGE                          [NSString stringWithFormat:@"%@/news/message/add", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_BACKARD_ADD_MESSAGE_CONVERSATION             [NSString stringWithFormat:@"%@/news/message/reply", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_BACKARD_MEDIA                                [NSString stringWithFormat:@"%@/backkard/media", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_BACKARD_ADD_MEDIA                            [NSString stringWithFormat:@"%@/backkard/media/save", STRING_REQUEST_ROOT]

#define STRING_REQUEST_URL_BACKARD_IOS_MEDIA_SAVE                       [NSString stringWithFormat:@"%@/backkard/ios/media/save", STRING_REQUEST_ROOT]

#define STRING_REQUEST_URL_BACKARD_DELETE_MEDIA                         [NSString stringWithFormat:@"%@/backkard/media/delete", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_BACKARD_ADD_MEDIA_COMMENT                    [NSString stringWithFormat:@"%@/backkard/addmediacomment", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_BACKARD_GET_MEDIA_COMMENT                    [NSString stringWithFormat:@"%@/backkard/media/getallcomments", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_BACKARD_EDIT_MEDIA                           [NSString stringWithFormat:@"%@/backkard/media/update", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_BACKARD_GET_MESSAGE_COMMENTS                 [NSString stringWithFormat:@"%@/backkard/message/getallcomments", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_GET_AUDIENCE                                 [NSString stringWithFormat:@"%@/konnect/accepted/traded/this/kard", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_GET_MESAGES_KARDS                            [NSString stringWithFormat:@"%@/konnect/accepted/traded/this/kard", STRING_REQUEST_ROOT]
// get list my kard that traded with specific kard
#define STRING_REQUEST_URL_GET_MY_KARDS_TRADED_WITH                     [NSString stringWithFormat:@"%@/konnect/accepted/me", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_SAVE_BACK_KARD_SETTING                       [NSString stringWithFormat:@"%@/kards/setting/back/add", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_BACKARD_VIEW_MEDIA                           [NSString stringWithFormat:@"%@/backkard/mediabyid", STRING_REQUEST_ROOT]
#define STRING_REQUEST_URL_BACKARD_DELETE_MEDIA                         [NSString stringWithFormat:@"%@/backkard/media/delete", STRING_REQUEST_ROOT]



// DRUPAL
#define STRING_REQUEST_KEY_METHOD                                       @"method"
#define STRING_REQUEST_VALUE_USER_GET_ALL                               @"user.get_all"
#define STRING_REQUEST_VALUE_USER_LOGIN                                 @"user.login"

// LOGIN
#define STRING_REQUEST_KEY_USER_NAME                                    @"username"
#define STRING_REQUEST_KEY_PASSWORD                                     @"password"
#define STRING_REQUEST_KEY_FK_USER                                      @"fkUser"
#define STRING_REQUEST_KEY_LATITUDE                                     @"latitude"
#define STRING_REQUEST_KEY_LONGITUDE                                    @"longitude"
#define STRING_REQUEST_KEY_SESSION_ID                                   @"sessionID"
#define STRING_REQUEST_KEY_SESSION                                      @"session"
#define STRING_REQUEST_KEY_GPS                                          @"gps"
#define STRING_REQUEST_KEY_F_NAME										@"fname"
#define STRING_REQUEST_KEY_L_NAME										@"lname"
#define STRING_REQUEST_KEY_EMAIL										@"email"
#define STRING_REQUEST_KEY_FULL_NAME                                    @"fullName"
#define STRING_REQUEST_KEY_PROFILE_NAME                                 @"profilename"
#define STRING_REQUEST_KEY_GENDER										@"gender"
#define STRING_REQUEST_KEY_ABOUT										@"about"
#define STRING_REQUEST_KEY_FK_KARD										@"fkKard"

// KONNECT
#define STRING_REQUEST_KEY_FK_FRIEND_KARD                               @"fkFriendKard"
#define STRING_REQUEST_KEY_LIST_KONNECT                                 @"listkonnect"

// KARD BUILDER 
#define STRING_REQUEST_KEY_CONTENT_TYPE_IMAGE_JPEG                      @"image/jpeg"
#define STRING_REQUEST_KEY_ID_NEW_KARD                                  @"idNewKard"
#define STRING_REQUEST_KEY_FILE                                         @"file"

#define STRING_RESPONSE_KEY_ID_PROFILE                                  @"idProfile"
#define STRING_RESPONSE_KEY_ID                                          @"id"
#define STRING_RESPONSE_KEY_CODE                                        @"code"
#define STRING_RESPONSE_KEY_IS_MY_DEFAULT                               @"isMyDefault"

#define STRING_REQUEST_KEY_USER_ID                                      @"userid"
#define STRING_REQUEST_KEY_CATEGORY                                     @"Category"
#define STRING_REQUEST_KEY_IMAGE_SOURCE                                 @"imagesource"
#define STRING_REQUEST_KEY_IS_LOGO                                      @"isLogo"
#define STRING_REQUEST_KEY_IS_EXTENSION                                 @"extension"

// MESSAGE
#define STRING_RESPONSE_KEY_SUCCESS                                     @"SUCCESS"
#define STRING_RESPONSE_KEY_INVALID                                     @"INVALID"
#define STRING_RESPONSE_KEY_FAILURE                                     @"FAILURE"
#define STRING_RESPONSE_KEY_EMPTY                                       @"EMPTY"

// LOGIN
#define STRING_RESPONSE_KEY_STATUS                                      @"status"
#define STRING_RESPONSE_KEY_RESULT                                      @"result"
#define STRING_RESPONSE_KEY_SESSION_ID                                  @"sessionID"
#define STRING_RESPONSE_KEY_USER_ID                                     @"idUsers"
#define STRING_RESPONSE_KEY_USER_NAME                                   @"username"
#define STRING_RESPONSE_KEY_MESSAGE_LOGIN                               @"messageLogin"
#define STRING_RESPONSE_KEY_F_NAME_LOGIN                                @"fname"
#define STRING_RESPONSE_KEY_L_NAME_LOGIN                                @"lname"
#define STRING_RESPONSE_KEY_FULL_NAME_LOGIN                             @"fullName"
#define STRING_RESPONSE_KEY_SORT_MY_KARD                                @"sortMyKard"
#define STRING_RESPONSE_KEY_SHOW_UNREAD                                 @"showUnread"
#define STRING_RESPONSE_KEY_USER_VISIBLE                                @"userVisible"
#define STRING_RESPONSE_KEY_PASSWORD                                    @"password"
#define STRING_RESPONSE_KEY_POINT_USER                                  @"pointUser"

// TRADE
#define STRING_RESPONSE_KEY_FK_LOCATION_TYPE                            @"fkLocationType"
#define STRING_RESPONSE_KEY_FK_ME										@"fkMe"
#define STRING_RESPONSE_KEY_FK_KARD										@"fkKard"
#define STRING_RESPONSE_KEY_FK_FRIEND									@"fkFriend"
#define STRING_RESPONSE_KEY_FK_FRIEND_KARD								@"fkFriendKard"

// KARDS: GET ALL, ME
#define STRING_RESPONSE_KEY_NAME                                        @"name"
#define STRING_RESPONSE_KEY_KARD_NAME                                   @"kardName"
#define STRING_RESPONSE_KEY_FK_USER                                     @"fkUser"
#define STRING_RESPONSE_KEY_FK_PROFILE                                  @"fkProfile"
#define STRING_RESPONSE_KEY_FK_KARD_TYPE                                @"fkKardType"
// MinhPB 2012/10/15
#define STRING_RESPONSE_KEY_DECK_IMAGE_SMALL                            @"imageSmall"
//#define STRING_RESPONSE_KEY_IMAGE_SMALL                                 @"imageSmall"
//#define STRING_RESPONSE_KEY_IMAGE_MEDIUM                                @"imageMedium"
//#define STRING_RESPONSE_KEY_IMAGE_LARGE                                 @"imageLarge"
#define STRING_RESPONSE_KEY_IMAGE_SMALL                                 @"imageSmall"
#define STRING_RESPONSE_KEY_IMAGE_MEDIUM                                @"imageLarge"
#define STRING_RESPONSE_KEY_IMAGE_LARGE                                 @"imageLarge"

#define STRING_RESPONSE_KEY_IMAGE_MEDIA_THUMB                           @"mediathumb"
#define STRING_RESPONSE_KEY_KONNECT_IMAGE                               @"konnectImage"
#define STRING_RESPONSE_KEY_DEAL_IMAGE                                  @"dealImage"
#define STRING_RESPONSE_KEY_FEEDS_IMAGE                                 @"feedImage"
#define STRING_RESPONSE_KEY_IS_KARD_ONLY                                @"isKardOnly"
#define STRING_RESPONSE_KEY_FK_FRIEND                                   @"fkFriend"
#define STRING_RESPONSE_KEY_ID_KONNECTS                                 @"idKonnects"
#define STRING_RESPONSE_KEY_ID_KARDS                                    @"idKards"
#define STRING_RESPONSE_KEY_KARD_TYPE_NAME                              @"kardTypeName"
#define STRING_RESPONSE_KEY_DATE_CREATED                                @"datecreated"
#define STRING_RESPONSE_KEY_FK_NEWS                                     @"fkNews"
#define STRING_RESPONSE_KEY_ID_NEWS_RESPONSE                            @"idNewsResponse"
#define STRING_RESPONSE_KEY_F_NAME                                      @"fName"
#define STRING_RESPONSE_KEY_L_NAME                                      @"lName"
#define STRING_RESPONSE_KEY_MY_TRADE                                    @"myTrade"
#define STRING_RESPONSE_KEY_APPROVED                                    @"approved"
#define STRING_RESPONSE_KEY_NUMBER_WAITING_ARROVE                       @"numberWaitingArrove"
#define STRING_RESPONSE_KEY_GET_DECK_USER_INFO                          @"getDeckUserInfo"
#define STRING_RESPONSE_KEY_FK_ME_KARD                                  @"fkMeKard"
#define STRING_RESPONSE_KEY_IS_MY_DEFAULT                               @"isMyDefault"
#define STRING_RESPONSE_KEY_KONNECT_VISIBILITY                          @"konnectVisibility"
#define STRING_RESPONSE_KEY_POST_BACK_KARD                              @"postBackKard"
#define STRING_RESPONSE_KEY_IS_DECK                                     @"isDeck" 
#define STRING_RESPONSE_KEY_NUMBER_FEED                                 @"numberfeed"
#define STRING_RESPONSE_KEY_FEED_UNREAD                                 @"feedUnread"
#define STRING_RESPONSE_KEY_FEED_UNREAD_ME_DECK                         @"feedUnreadMedeck"
#define STRING_RESPONSE_KEY_MESSAGE_UNREAD                              @"messageUnread"
#define STRING_RESPONSE_KEY_DECK_NAME                                   @"deckName"
#define STRING_RESPONSE_KEY_IS_HIDE                                     @"isHide"
#define STRING_RESPONSE_KEY_MUTUAL_FRIEND                               @"mutualFriend"
#define STRING_RESPONSE_KEY_KARD_IMAGE                                  @"kardImage"
#define STRING_RESPONSE_KEY_MEDIA_COMMENT                               @"mediaComment"
#define STRING_RESPONSE_KEY_COMMENT_DATE                                @"commentDate"

// KARD BUILDER
#define STRING_RESPONSE_KEY_TEMPLATE_NAME                               @"templateName"
#define STRING_RESPONSE_KEY_TEMPLATE_IMAGE                              @"templateImage"
#define STRING_RESPONSE_KEY_TITLE                                       @"title"
#define STRING_RESPONSE_KEY_POSITION                                    @"position"
#define STRING_RESPONSE_KEY_COMPANY                                     @"company"
#define STRING_RESPONSE_KEY_PHONE                                       @"phone"
#define STRING_RESPONSE_KEY_FAX                                         @"fax"
#define STRING_RESPONSE_KEY_PHONE2                                      @"phone2"
#define STRING_RESPONSE_KEY_EMAIL                                       @"email"
#define STRING_RESPONSE_KEY_WEBSITE                                     @"website"
#define STRING_RESPONSE_KEY_DETAIL                                      @"detail"
#define STRING_RESPONSE_KEY_ADDRESS                                     @"address"
#define STRING_RESPONSE_KEY_CITY                                        @"city"
#define STRING_RESPONSE_KEY_STATE                                       @"state"
#define STRING_RESPONSE_KEY_COUNTRY                                     @"country"
#define STRING_RESPONSE_KEY_CITY_NAME                                   @"cityName"
#define STRING_RESPONSE_KEY_COUNTRY_NAME                                @"countryName"
#define STRING_RESPONSE_KEY_STATE_NAME                                  @"stateName"
#define STRING_RESPONSE_KEY_ZIP                                         @"zip"
#define STRING_RESPONSE_KEY_GENDER                                      @"gender"
#define STRING_RESPONSE_KEY_GENDER_SHOW                                 @"genderShow"
#define STRING_RESPONSE_KEY_KEYWORK                                     @"keywork"
#define STRING_RESPONSE_KEY_AGE                                         @"age"
#define STRING_RESPONSE_KEY_AGE13_17                                    @"age13_17"
#define STRING_RESPONSE_KEY_AGE18_25                                    @"age18_25"
#define STRING_RESPONSE_KEY_AGE26_35                                    @"age26_35"
#define STRING_RESPONSE_KEY_AGE36_45                                    @"age36_45"
#define STRING_RESPONSE_KEY_AGE46_55                                    @"age46_55"
#define STRING_RESPONSE_KEY_AGE56                                       @"age56"
#define STRING_RESPONSE_KEY_AGE_SHOW                                    @"ageShow"
#define STRING_RESPONSE_KEY_AGE_ALL                                     @"ageAll"
#define STRING_RESPONSE_KEY_INCOME                                      @"inCome"
#define STRING_RESPONSE_KEY_INCOME_0_25                                 @"inCome025" 
#define STRING_RESPONSE_KEY_INCOME_26_50                                @"inCome2650"
#define STRING_RESPONSE_KEY_INCOME_51_100                               @"inCome51100"
#define STRING_RESPONSE_KEY_INCOME_101                                  @"inCome101"
#define STRING_RESPONSE_KEY_INCOME_SHOW                                 @"inComeShow"
#define STRING_RESPONSE_KEY_INCOME_ALL                                  @"inComeAll"
#define STRING_RESPONSE_KEY_EDUCATION                                   @"education"
#define STRING_RESPONSE_KEY_EDUCATION_ADV                               @"educationAdv"
#define STRING_RESPONSE_KEY_EDUCATION_COLL                              @"educationColl" 
#define STRING_RESPONSE_KEY_EDUCATION_HIGHT                             @"educationHight"
#define STRING_RESPONSE_KEY_EDUCATION_SHOW                              @"educationShow"
#define STRING_RESPONSE_KEY_EDUCATION_SOME                              @"educationSome"
#define STRING_RESPONSE_KEY_EDUCATION_ALL                               @"educationAll"
#define STRING_RESPONSE_KEY_RELATIONSHIP                                @"relationship"
#define STRING_RESPONSE_KEY_RE_BREAKUP                                  @"reBreakup"
#define STRING_RESPONSE_KEY_RE_ENGAGED                                  @"reEngaged"
#define STRING_RESPONSE_KEY_RE_MARRIED                                  @"reMarried"
#define STRING_RESPONSE_KEY_RE_RE_ENGAGED                               @"reReEngaged" 
#define STRING_RESPONSE_KEY_RE_RE_MARRIED                               @"reReMarried"
#define STRING_RESPONSE_KEY_RE_SHOW                                     @"reShow"
#define STRING_RESPONSE_KEY_RE_INA                                      @"reIna"
#define STRING_RESPONSE_KEY_RE_SING                                     @"reSingle"
#define STRING_RESPONSE_KEY_PARENTAL                                    @"parental"
#define STRING_RESPONSE_KEY_PARENTAL_EXP                                @"parentalExp"
#define STRING_RESPONSE_KEY_PARENTAL_GAVE_BIRTH                         @"parentalGaveBirth" 
#define STRING_RESPONSE_KEY_PARENTAL_NO_KID                             @"parentalNoKid"
#define STRING_RESPONSE_KEY_PARENTAL_PARANT                             @"parentalParant"
#define STRING_RESPONSE_KEY_PARENTAL_SHOW                               @"parentalShow"
#define STRING_RESPONSE_KEY_PARENTAL_ALL                                @"parentalAll"
#define STRING_RESPONSE_KEY_KEYWORD                                     @"keyWord"
#define STRING_RESPONSE_KEY_BORDER_TEMPLATE_NAME                        @"borderTemplateName"
#define STRING_RESPONSE_KEY_BORDER_TEMPLATE_IMAGE                       @"borderTemplateImage"
#define STRING_RESPONSE_KEY_EXIST_KARD_NAME                             @"EXIST NAME"
#define STRING_RESPONSE_KEY_URL                                         @"url"
#define STRING_RESPONSE_KEY_IMAGE                                       @"image"
#define STRING_RESPONSE_KEY_IMAGES                                      @"images"
#define STRING_RESPONSE_KEY_OVERLAYS                                    @"overlays"
#define STRING_RESPONSE_KEY_LABELS                                      @"labels"
#define STRING_RESPONSE_KEY_GRAPHICS                                    @"graphics"
#define STRING_RESPONSE_KEY_IPOSITION_X                                 @"iPositionX"
#define STRING_RESPONSE_KEY_IPOSITION_Y                                 @"iPositionY"
#define STRING_RESPONSE_KEY_POSITION_X                                  @"positionX"
#define STRING_RESPONSE_KEY_POSITION_Y                                  @"positionY"
#define STRING_RESPONSE_KEY_LABEL                                       @"label"
#define STRING_RESPONSE_KEY_MAXLENGTH                                   @"maxLength"
#define STRING_RESPONSE_KEY_SIZE                                        @"size"
#define STRING_RESPONSE_KEY_COLOR                                       @"color"
#define STRING_RESPONSE_KEY_FONT_FACE                                   @"fontface"
#define STRING_RESPONSE_KEY_URL                                         @"url"
#define STRING_RESPONSE_KEY_NUMBER_OF_COMMENT                           @"numberOfComment"
#define STRING_RESPONSE_KEY_WIDTH                                       @"width"
#define STRING_RESPONSE_KEY_HEIGHT                                      @"height"
#define STRING_RESPONSE_KEY_COMMENTS_LIST                               @"commentList"
#define STRING_RESPONSE_KEY_NUMBER_OF_VIEW                              @"numberOfViewer"
#define STRING_RESPONSE_KEY_URL_IMAGE                                   @"urlImage"
#define STRING_RESPONSE_MEDIA_DESCRIPTION                               @"mediaDesc"
#define STRING_RESPONSE_KEY_F_NAME_IS_CHECK                             @"fNameisCheck"
#define STRING_RESPONSE_KEY_L_NAME_IS_CHECK                             @"lNameisCheck"
#define STRING_RESPONSE_KEY_POSITION_IS_CHECK                           @"positionisCheck" 
#define STRING_RESPONSE_KEY_COMPANY_IS_CHECK                            @"companyisCheck"   
#define STRING_RESPONSE_KEY_PHONE_IS_CHECK                              @"phoneisCheck" 
#define STRING_RESPONSE_KEY_PHONE2_IS_CHECK                             @"phone2isCheck"    
#define STRING_RESPONSE_KEY_FAX_IS_CHECK                                @"faxisCheck"   
#define STRING_RESPONSE_KEY_EMAIL_IS_CHECK                              @"emailisCheck" 
#define STRING_RESPONSE_KEY_ADDRESS_IS_CHECK                            @"addressisCheck"   
#define STRING_RESPONSE_KEY_CITY_IS_CHECK                               @"cityisCheck"  
#define STRING_RESPONSE_KEY_STATE_IS_CHECK                              @"stateisCheck" 
#define STRING_RESPONSE_KEY_COUNTRY_IS_CHECK                            @"countryisCheck"   
#define STRING_RESPONSE_KEY_ZIP_IS_CHECK                                @"zipisCheck"   
#define STRING_RESPONSE_KEY_WEBSITE_IS_CHECK                            @"websiteisCheck"   
#define STRING_RESPONSE_KEY_DETAIL_IS_CHECK                             @"detailisCheck"    
#define STRING_RESPONSE_KEY_GENDER_IS_CHECK                             @"genderisCheck"    
#define STRING_RESPONSE_KEY_AGE_IS_CHECK                                @"ageisCheck"   
#define STRING_RESPONSE_KEY_IN_COME_IS_CHECK                            @"inComeisCheck"    
#define STRING_RESPONSE_KEY_EDUCATION_IS_CHECK                          @"educationisCheck" 
#define STRING_RESPONSE_KEY_RELATIONSHIP_IS_CHECK                       @"relationshipisCheck"  
#define STRING_RESPONSE_KEY_PARENTAL_IS_CHECK                           @"parentalisCheck" 
#define STRING_RESPONSE_KEY_KEY_WORK_IS_CHECK                           @"keyWordischeck"
#define STRING_RESPONSE_KEY_ALIGNMENT                                   @"alignment"
#define STRING_RESPONSE_KEY_TEMPLATE_ID                                 @"idVisikardTemplates"

#define STRING_RESPONSE_KEY_LAYER1                                      @"layer1"    
#define STRING_RESPONSE_KEY_LAYER1X                                     @"layer1X"   
#define STRING_RESPONSE_KEY_LAYER1Y                                     @"layer1Y"    
#define STRING_RESPONSE_KEY_LAYER2                                      @"layer2" 
#define STRING_RESPONSE_KEY_LAYER2X                                     @"layer2X"  
#define STRING_RESPONSE_KEY_LAYER2Y                                     @"layer2Y" 
#define STRING_RESPONSE_KEY_LAYER2H                                     @"layer2H"
#define STRING_RESPONSE_KEY_LAYER2W                                     @"layer2W" 

// COUNTRY
#define STRING_RESPONSE_KEY_ID                                          @"id"
#define STRING_RESPONSE_KEY_CODE                                        @"code"

// BACK KARD
#define STRING_RESPONSE_KEY_MESSAGE                                     @"messages"
#define STRING_RESPONSE_KEY_POST_DATE                                   @"postDate"
#define STRING_RESPONSE_KEY_MEDIA_ID                                    @"mediaId"

// BANNER ADS
#define STRING_RESPONSE_KEY_BANNER_IMAGE_URL                            @"adsUrl"
#define STRING_RESPONSE_KEY_BANNER_ADS_ID                               @"adsId"

// FEEDS
#define  STRING_RESPONSE_KEY_COMMENTS                                   @"comment"
#define  STRING_RESPONSE_KEY_MEDIA                                      @"media"
#define  STRING_RESPONSE_KEY_ID_NEWS                                    @"idNews"
#define  STRING_RESPONSE_KEY_COUNT_RESP                                 @"countResponse"
#define  STRING_RESPONSE_KEY_COUNT_LIKE                                 @"countLike"
#define  STRING_RESPONSE_KEY_IS_LIKE                                    @"isLike"
#define  STRING_RESPONSE_KEY_COUNT_UNLIKE                               @"countUnLike"
#define  STRING_RESPONSE_KEY_IS_UNLIKE                                  @"isUnLike"
#define  STRING_RESPONSE_KEY_IS_PRIORITIZE                              @"isPrioritize"


// DEALS: GET ALL, ME
#define STRING_RESPONSE_KEY_MERCHANT_NAME                               @"merchantName"
#define STRING_RESPONSE_KEY_THUMBNAIL                                   @"thumbnail"
#define STRING_RESPONSE_KEY_MERCHANT_ADDRESS                            @"merchantAddress"
#define STRING_RESPONSE_KEY_HEADLINE                                    @"headline"
#define STRING_RESPONSE_KEY_LATITUDE                                    @"latitude"
#define STRING_RESPONSE_KEY_LOGITUDE                                    @"longitude"
#define STRING_RESPONSE_KEY_DISTANCE_TO_MERCHANT                        @"distanceToMerchant"
#define STRING_RESPONSE_KEY_IS_PENDING                                  @"isPending"
#define STRING_RESPONSE_KEY_IS_REDEEMED                                 @"isRedeemed"
#define STRING_RESPONSE_KEY_CITY_NAME                                   @"cityName"
#define STRING_RESPONSE_KEY_DESCRIPTION                                 @"description"
#define STRING_RESPONSE_KEY_DISCOUNT_PRICE                              @"discountPrice"
#define STRING_RESPONSE_KEY_REGULAR_PRICE                               @"regularPrice"
#define STRING_RESPONSE_KEY_NUMBER_OF_FRIEND                            @"numberOfFriends"
#define STRING_RESPONSE_KEY_DEAL_ID                                     @"dealId"
#define STRING_RESPONSE_KEY_KARD_ID                                     @"kardId"
#define STRING_RESPONSE_KEY_REDEEMED_DATE                               @"redeemedDate"
#define STRING_RESPONSE_KEY_MINIMUM_QUANTITY                            @"minimumQuantity"
#define STRING_RESPONSE_KEY_MAXIMUM_QUANTITY                            @"maximumQuantity"
#define STRING_RESPONSE_KEY_DEAL_NEAR_YOU                               @"listLocationsNearYou"
#define STRING_RESPONSE_KEY_DEAL_REDEEMCODE                             @"redeemedCode"
#define STRING_RESPONSE_KEY_DEAL_MECHANT_NAME                           @"dealMerchant"
#define STRING_RESPONSE_KEY_MY_DEAL_MECHANT_NAME                        @"myDealMerchant"
#define STRING_RESPONSE_KEY_DEAL_HEADLINE                               @"dealShortdesc"
#define STRING_RESPONSE_KEY_MY_DEAL_HEADLINE                            @"myDealShortdesc"
#define STRING_RESPONSE_KEY_DEAL_PRICE                                  @"dealPrice"
#define STRING_RESPONSE_KEY_MY_DEAL_PRICE                               @"myDealPrice"
#define STRING_RESPONSE_KEY_DEAL_VALUE                                  @"dealValue"
#define STRING_RESPONSE_KEY_MY_DEAL_VALUE                               @"myDealValue"
#define STRING_RESPONSE_KEY_DEAL_CATEGORY                               @"category"
#define STRING_RESPONSE_KEY_DEAL_CATEGORY_HOME                          @"dealCategory"
#define STRING_RESPONSE_KEY_MY_DEAL_CATEGORY_HOME                       @"myDealCategory"
#define STRING_RESPONSE_KEY_MY_DEAL_IMAGE                               @"myDealImage"

// KONNECT
#define STRING_RESPONSE_KEY_DISTANCE_MAP                                @"distanceMap"
#define STRING_RESPONSE_KEY_DISTANCE_USER                               @"distanceUser"
#define STRING_RESPONSE_KEY_IS_TRADED                                   @"isTraded"
#define STRING_RESPONSE_KEY_ACCEPTED                                    @"accepted"
#define STRING_RESPONSE_KEY_NUMBER_MUTUAL                               @"numberMutual"
#define STRING_RESPONSE_KEY_KONNECT_LABEL                               @"konnectLabel"
#define STRING_RESPONSE_KEY_HIDE_THIS_KARD                              @"hideThisKard"
#define STRING_RESPONSE_KEY_HIDE_THIS_KARD_DATE                         @"hideThisKardDate"
#define STRING_RESPONSE_KEY_IS_ONLINE                                   @"isOnline"
#define STRING_RESPONSE_KEY_NUMBER_KARD_TRADED                          @"numberKardTraded"

// FB
#define STRING_RESPONSE_KEY_FB_NAME                                     @"name" 
#define STRING_RESPONSE_KEY_FB_ID                                       @"id" 
#define STRING_RESPONSE_KEY_FB_PICTURE                                  @"picture"
#define STRING_RESPONSE_KEY_FB_F_NAME									@"first_name"
#define STRING_RESPONSE_KEY_FB_L_NAME									@"last_name"
#define	STRING_RESPONSE_KEY_FB_EMAIL									@"email"
#define	STRING_RESPONSE_KEY_FB_GENDER									@"gender"
#define	STRING_RESPONSE_KEY_FB_ABOUT									@"about"

// TW
#define STRING_RESPONSE_KEY_TW_NAME                                     @"name" 
#define STRING_RESPONSE_KEY_TW_GENDER                                   @"gender"
#define STRING_RESPONSE_KEY_TW_ABOUT                                    @"about" 

#define INT_RESPONSE_CODE_FINISH                                        200
#define INT_RESPONSE_CODE_CONNECTION_ERROR                              1000
#define STRING_RESPONSE_CODE_SUCCESS                                    @"SUCCESS"
#define STRING_RESPONSE_CODE_FAILER                                     @"FAILER"
#define STRING_RESPONSE_CODE_EXIST                                      @"EXIST"
#define STRING_RESPONSE_CODE_ACCEPTED                                   @"ACCEPTED"

#define RELOAD_FEEDS                                                    @"reload"

#define STRING_ALERT_CONNECTION_ERROR_TITLE                             @"Offline"
#define STRING_ALERT_CONNECTION_ERROR									@"Sorry, this function is not available in offline mode.  Please connect to the internet to perform this function"
//#define STRING_ALERT_SERVER_ERROR                                       @"Sorry, server's response is not in the format"
#define STRING_ALERT_SERVER_ERROR                                       @"We are sorry, the VisiKard server is temporarily offline for an upgrade...We will be back within the next few minutes. Please try again."

#define STRING_ALERT_DATA_IS_NIL										@"DATA is nil"


#define kSqliteFileName @"VisiKard"

@protocol APIRequesterProtocol <NSObject>

@optional

- (void)requestFailed:(ASIHTTPRequest *)request andType:(ENUM_API_REQUEST_TYPE)type;
- (void)requestFinished:(ASIHTTPRequest *)request andType:(ENUM_API_REQUEST_TYPE)type;
- (void)requestTimeoutWithType:(ENUM_API_REQUEST_TYPE)type;
- (void)requestRetried:(ENUM_API_REQUEST_TYPE)type;

@end

@interface APIRequester : NSObject <ASIHTTPRequestDelegate, AppViewControllerProtocol, UIAlertViewDelegate>
{
    ENUM_API_REQUEST_TYPE                               m_RequestType;
    ASIHTTPRequest                                      *m_ASIRequest;
    
    id<APIRequesterProtocol>                              m_Delegate;
    
    ENUM_API_REQUESTER_STEP                             m_RequestStep;
    CFAbsoluteTime                                      m_TimerRequest;
    UIAlertView                                         *m_AlertFail;
    NSString                                            *m_StringURL;
    
    ASIFormDataRequest                                  *m_ASIFormRequest;
    NSMutableDictionary                                 *m_ParamsDic;
}
- (void)requestWithType:(ENUM_API_REQUEST_TYPE)type andURL:(NSString *)url andDelegate:(id)delegate;
- (void)requestWithType:(ENUM_API_REQUEST_TYPE)type andRootURL:(NSString *)rootURL andPostMethodKind:(BOOL)methodKind andParams:(NSMutableDictionary *)params andDelegate:(id)delegate;
- (void)requestWithType:(ENUM_API_REQUEST_TYPE)type andRootURL:(NSString *)rootURL andPostMethodKind:(BOOL)methodKind andParams:(NSMutableDictionary *)params andImageData:(NSData *)data andDelegate:(id)delegate;
- (void)requestMultiPartRequestType:(ENUM_API_REQUEST_TYPE)type andRootURL:(NSString *)rootURL 
      andPostMethodKind:(BOOL)methodKind 
              andParams:(NSArray *)params 
                andKeys:(NSArray*)keysArr
            andDelegate:(id)delegate;

- (void)videoRequestMultiPartRequestType:(ENUM_API_REQUEST_TYPE)type andRootURL:(NSString *)rootURL 
                       andPostMethodKind:(BOOL)methodKind 
                               andParams:(NSArray *)params 
                                 andKeys:(NSArray*)keysArr
                             andDelegate:(id)delegate;

- (void)requestSimpleRequestType:(ENUM_API_REQUEST_TYPE)type andRootURL:(NSString *)rootURL 
               andPostMethodKind:(BOOL)methodKind 
                       andParams:(NSArray *)params 
                         andKeys:(NSArray*)keysArr
                     andDelegate:(id)delegate;

- (void)cancelRequest;
+ (APIRequester *)Shared;
@end
