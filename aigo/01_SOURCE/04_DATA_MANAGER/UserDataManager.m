//
//  UserDataManager.m
//  trongvm
//
//  Created by Phan Ba Minh on 6/5/12.
//  Copyright (c) 2012 kidbaw. All rights reserved.
//

#import "UserDataManager.h"
#import "Define.h"
#import "KardsDataManager.h"
#import "AutomationDataManager.h"

@implementation UserDataManager

@synthesize userID, userName, accessToken, password, sessionID, loginStatus, isLoginWith_FB_TW, avatarSmallURL, fullName, loginAtTheFirstTime,idProfile,idKards,fkUser, dealSmallURL, userLocation, feedsSmallURL, konnectSmallURL;
@synthesize myKardsUnreadMessage, feedsUnreadMessage, konnectWaitingForApproval, showMyKardUnread, sortMyKard, userIsVisible;

@synthesize userTotalPoints,userCurrentPoints,userLevel,userRank;

@synthesize myDealPrice, myDealValue, myDealHeadline, myDealMerchant, myDealCategory,myDealImageURL , pointUser,myCity,myDealCachedCity,myDealCachedCategory,currentPlaceMark,myDealLastStatus, userMeKards,myDefaultKardId;

- (void)dealloc
{
}

#pragma mark - Encode - Decode

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeBool:loginStatus forKey:STRING_CODER_USER_DATA_LOGIN_STATUS];
    [encoder encodeObject:userName forKey:STRING_CODER_USER_DATA_USER_NAME];
    [encoder encodeInt:userID forKey:STRING_CODER_USER_DATA_USER_ID];
    [encoder encodeObject:sessionID forKey:STRING_CODER_USER_DATA_SESSION_ID];
	[encoder encodeObject:password forKey:STRING_CODER_USER_DATA_PASSWORD];
    [encoder encodeBool:isLoginWith_FB_TW forKey:STRING_CODER_USER_DATA_LOGIN_WITH_FB_TW];
    [encoder encodeObject:avatarSmallURL forKey:STRING_CODER_USER_DATA_AVATAR_SMALL_URL];
    [encoder encodeObject:fullName forKey:STRING_CODER_USER_DATA_FULL_NAME];
    [encoder encodeBool:loginAtTheFirstTime forKey:STRING_CODER_USER_DATA_LOGIN_AT_THE_FIRST_TIME];
    [encoder encodeInteger:idProfile forKey:STRING_CODER_USER_DATA_USER_PROFILE_ID];
    [encoder encodeInteger:idKards forKey:STRING_CODER_USER_DATA_USER_KARD_ID];
    [encoder encodeInteger:fkUser forKey:STRING_CODER_USER_DATA_FK_USER_ID];
    [encoder encodeObject:userLocation forKey:STRING_CODER_USER_DATA_USER_LOCATION];
    [encoder encodeInteger:myKardsUnreadMessage forKey:STRING_CODER_USER_DATA_MY_KARDS_UNREAD_MESSAGE];
    [encoder encodeInteger:feedsUnreadMessage forKey:STRING_CODER_USER_DATA_FEEDS_UNREAD_MESSAGE];
    [encoder encodeInteger:konnectWaitingForApproval forKey:STRING_CODER_USER_DATA_KONNECT_WAITING_FOR_APPROVAL];
    [encoder encodeInteger:sortMyKard forKey:STRING_CODER_USER_DATA_KARD_SETTING_SORT_TYPE];
    [encoder encodeInteger:showMyKardUnread forKey:STRING_CODER_USER_DATA_KARD_SETTING_SHOW_UNREAD];
    [encoder encodeInteger:userIsVisible forKey:STRING_CODER_USER_DATA_USER_IS_VISIBLE];
    [encoder encodeInteger:userMeKards forKey:STRING_CODER_USER_DATA_USER_ME_KARDS];
    
    [encoder encodeInteger:userTotalPoints forKey:STRING_CODER_USER_DATA_USER_TOTAL_POINTS];
    [encoder encodeInteger:userCurrentPoints forKey:STRING_CODER_USER_DATA_USER_CURR_POINTS];
    [encoder encodeInteger:userLevel forKey:STRING_CODER_USER_DATA_USER_LEVEL];
    [encoder encodeObject:userRank forKey:STRING_CODER_USER_DATA_USER_RANK];
    
    [encoder encodeInteger:myDealValue forKey:STRING_CODER_USER_DATA_MY_DEAL_VALUE];
    [encoder encodeInteger:myDealPrice forKey:STRING_CODER_USER_DATA_MY_DEAL_PRICE];
    [encoder encodeObject:myDealImageURL forKey:STRING_CODER_USER_DATA_MY_DEAL_IMAGE_URL];
    
    [encoder encodeObject:myCity forKey:STRING_CODER_USER_DATA_MY_CITY];
    [encoder encodeObject:myDealCachedCity forKey:STRING_CODER_USER_DATA_MY_DEAL_CACHED_CITY];
    [encoder encodeObject:myDealCachedCategory forKey:STRING_CODER_USER_DATA_MY_DEAL_CACHED_CATEGORY];
    [encoder encodeObject:currentPlaceMark forKey:STRING_CODER_USER_DATA_CURRENT_PLACE_MARK];
    [encoder encodeInt:myDealLastStatus forKey:STRING_CODER_USER_DATA_MY_DEAL_LAST_STATUS];
    [encoder encodeInt:myDefaultKardId forKey:STRING_CODER_USER_DEFAULT_KARD_ID];
    
    
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        if ([decoder decodeBoolForKey:STRING_CODER_USER_DATA_LOGIN_STATUS]) self.loginStatus = [decoder decodeBoolForKey:STRING_CODER_USER_DATA_LOGIN_STATUS];
        if ([decoder decodeObjectForKey:STRING_CODER_USER_DATA_USER_NAME]) self.userName = [decoder decodeObjectForKey:STRING_CODER_USER_DATA_USER_NAME];
        if ([decoder decodeIntForKey:STRING_CODER_USER_DATA_USER_ID]) self.userID = [decoder decodeIntForKey:STRING_CODER_USER_DATA_USER_ID];
        if ([decoder decodeObjectForKey:STRING_CODER_USER_DATA_SESSION_ID]) self.sessionID = [decoder decodeObjectForKey:STRING_CODER_USER_DATA_SESSION_ID];
		if ([decoder decodeObjectForKey:STRING_CODER_USER_DATA_PASSWORD]) self.password = [decoder decodeObjectForKey:STRING_CODER_USER_DATA_PASSWORD];
        if ([decoder decodeBoolForKey:STRING_CODER_USER_DATA_LOGIN_WITH_FB_TW]) self.isLoginWith_FB_TW = [decoder decodeBoolForKey:STRING_CODER_USER_DATA_LOGIN_WITH_FB_TW];
        if ([decoder decodeObjectForKey:STRING_CODER_USER_DATA_AVATAR_SMALL_URL]) self.avatarSmallURL = [decoder decodeObjectForKey:STRING_CODER_USER_DATA_AVATAR_SMALL_URL];
        if ([decoder decodeObjectForKey:STRING_CODER_USER_DATA_FULL_NAME]) self.fullName = [decoder decodeObjectForKey:STRING_CODER_USER_DATA_FULL_NAME];
        if ([decoder decodeBoolForKey:STRING_CODER_USER_DATA_LOGIN_AT_THE_FIRST_TIME]) self.loginAtTheFirstTime = [decoder decodeBoolForKey:STRING_CODER_USER_DATA_LOGIN_AT_THE_FIRST_TIME];
        
        if ([decoder decodeIntegerForKey:STRING_CODER_USER_DATA_USER_PROFILE_ID]) {
            self.idProfile = [decoder decodeIntegerForKey:STRING_CODER_USER_DATA_USER_PROFILE_ID];
        }
        if ([decoder decodeIntegerForKey:STRING_CODER_USER_DATA_USER_KARD_ID]) {
            self.idKards = [decoder decodeIntegerForKey:STRING_CODER_USER_DATA_USER_KARD_ID];
        }
        if ([decoder decodeIntegerForKey:STRING_CODER_USER_DATA_FK_USER_ID]) {
            self.fkUser = [decoder decodeIntegerForKey:STRING_CODER_USER_DATA_FK_USER_ID];
        }
        if ([decoder decodeObjectForKey:STRING_CODER_USER_DATA_USER_LOCATION]) self.userLocation = [decoder decodeObjectForKey:STRING_CODER_USER_DATA_USER_LOCATION];
        if ([decoder decodeIntegerForKey:STRING_CODER_USER_DATA_MY_KARDS_UNREAD_MESSAGE]) {
            self.myKardsUnreadMessage = [decoder decodeIntegerForKey:STRING_CODER_USER_DATA_MY_KARDS_UNREAD_MESSAGE];
        }
        if ([decoder decodeIntegerForKey:STRING_CODER_USER_DATA_FEEDS_UNREAD_MESSAGE]) {
            self.feedsUnreadMessage = [decoder decodeIntegerForKey:STRING_CODER_USER_DATA_FEEDS_UNREAD_MESSAGE];
        }
        if ([decoder decodeIntegerForKey:STRING_CODER_USER_DATA_KONNECT_WAITING_FOR_APPROVAL]) {
            self.konnectWaitingForApproval = [decoder decodeIntegerForKey:STRING_CODER_USER_DATA_KONNECT_WAITING_FOR_APPROVAL];
        }
        if ([decoder decodeIntegerForKey:STRING_CODER_USER_DATA_KARD_SETTING_SORT_TYPE]) {
            self.sortMyKard = [decoder decodeIntegerForKey:STRING_CODER_USER_DATA_KARD_SETTING_SORT_TYPE];
        }
        if ([decoder decodeIntegerForKey:STRING_CODER_USER_DATA_KARD_SETTING_SHOW_UNREAD]) {
            self.showMyKardUnread = [decoder decodeIntegerForKey:STRING_CODER_USER_DATA_KARD_SETTING_SHOW_UNREAD];
        }
        if ([decoder decodeIntegerForKey:STRING_CODER_USER_DATA_USER_IS_VISIBLE]) {
            self.userIsVisible = [decoder decodeIntegerForKey:STRING_CODER_USER_DATA_USER_IS_VISIBLE];
        }
        if ([decoder decodeIntegerForKey:STRING_CODER_USER_DATA_USER_PROFILE_ID]) {
            self.idProfile = [decoder decodeIntegerForKey:STRING_CODER_USER_DATA_USER_PROFILE_ID];
        }
        if ([decoder decodeIntegerForKey:STRING_CODER_USER_DATA_USER_TOTAL_POINTS]) {
            self.userTotalPoints = [decoder decodeIntegerForKey:STRING_CODER_USER_DATA_USER_TOTAL_POINTS];
        }
        if ([decoder decodeIntegerForKey:STRING_CODER_USER_DATA_USER_CURR_POINTS]) {
            self.userCurrentPoints = [decoder decodeIntegerForKey:STRING_CODER_USER_DATA_USER_CURR_POINTS];
        }
        if ([decoder decodeIntegerForKey:STRING_CODER_USER_DATA_USER_LEVEL]) {
            self.userLevel = [decoder decodeIntegerForKey:STRING_CODER_USER_DATA_USER_LEVEL];
        }
        if ([decoder decodeObjectForKey:STRING_CODER_USER_DATA_USER_RANK]) {
            self.userRank = [decoder decodeObjectForKey:STRING_CODER_USER_DATA_USER_RANK];
        }
        if ([decoder decodeIntegerForKey:STRING_CODER_USER_DATA_USER_ME_KARDS]) {
            self.userMeKards = [decoder decodeIntegerForKey:STRING_CODER_USER_DATA_USER_ME_KARDS];
        }
        
        if ([decoder decodeIntegerForKey:STRING_CODER_USER_DATA_MY_DEAL_VALUE]) {
            self.myDealValue = [decoder decodeIntegerForKey:STRING_CODER_USER_DATA_MY_DEAL_VALUE];
        }
        if ([decoder decodeIntegerForKey:STRING_CODER_USER_DATA_MY_DEAL_PRICE]) {
            self.myDealPrice = [decoder decodeIntegerForKey:STRING_CODER_USER_DATA_MY_DEAL_PRICE];
        }
        if ([decoder decodeObjectForKey:STRING_CODER_USER_DATA_MY_DEAL_IMAGE_URL]) {
            self.myDealImageURL = [decoder decodeObjectForKey:STRING_CODER_USER_DATA_MY_DEAL_IMAGE_URL];
        }
        
        if ([decoder decodeObjectForKey:STRING_CODER_USER_DATA_MY_CITY]) {
            self.myCity = [decoder decodeObjectForKey:STRING_CODER_USER_DATA_MY_CITY];
        }
        
        if ([decoder decodeObjectForKey:STRING_CODER_USER_DATA_MY_DEAL_CACHED_CITY]) {
            self.myDealCachedCity = [decoder decodeObjectForKey:STRING_CODER_USER_DATA_MY_DEAL_CACHED_CITY];
        }
        
        if ([decoder decodeObjectForKey:STRING_CODER_USER_DATA_MY_DEAL_CACHED_CATEGORY]) {
            self.myDealCachedCategory = [decoder decodeObjectForKey:STRING_CODER_USER_DATA_MY_DEAL_CACHED_CATEGORY];
        }
        
        if ([decoder decodeObjectForKey:STRING_CODER_USER_DATA_CURRENT_PLACE_MARK]) {
            self.currentPlaceMark = [decoder decodeObjectForKey:STRING_CODER_USER_DATA_CURRENT_PLACE_MARK];
        }
        
        if ([decoder decodeObjectForKey:STRING_CODER_USER_DATA_MY_DEAL_LAST_STATUS]) {
            self.myDealLastStatus = [decoder decodeIntForKey:STRING_CODER_USER_DATA_MY_DEAL_LAST_STATUS];
        }
        
        if ([decoder decodeIntForKey:STRING_CODER_USER_DEFAULT_KARD_ID]) {
            self.myDefaultKardId = [decoder decodeIntForKey:STRING_CODER_USER_DEFAULT_KARD_ID];
        }
    }
    return self;
}

- (void)setAvatarSmallURL:url {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadWithURL:[NSURL URLWithString:url] delegate:self];
    avatarSmallURL = url;
}

- (void)setKonnectSmallURL:url {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadWithURL:[NSURL URLWithString:url] delegate:self];
    konnectSmallURL = url;
}

- (void)setDealSmallURL:url {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadWithURL:[NSURL URLWithString:url] delegate:self];
    dealSmallURL = url;
}

- (void)setFeedsSmallURL:url {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadWithURL:[NSURL URLWithString:url] delegate:self];
    feedsSmallURL = url;
}

#pragma mark - SDWebImageDownloaderDelegate

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image {
    //    NSLog(@"PhotoShopObject; webImageManager; didFinishWithImage");
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFailWithError:(NSError *)error {
    //    NSLog(@"PhotoShopObject; webImageManager; didFailWithError");
}

#pragma mark - Method

- (void)cleanUserCacheAndCookie {
    // *******NEW ACCOUNT******* //
    [[KardsDataManager kardsShared].categoryArray removeAllObjects];
    [[KardsDataManager konnectShared].categoryArray removeAllObjects];
    [[KardsDataManager konnectPendingShared].categoryArray removeAllObjects];
    
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie* cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [cookies deleteCookie:cookie];
    }
    // ************************* //
}

- (void)resetAllData {
    // reset profile data
    [UserDataManager Shared].userID = -1;
    [UserDataManager Shared].sessionID = @"";
    [UserDataManager Shared].userName = @"";
    [UserDataManager Shared].loginStatus = NO;
    [UserDataManager Shared].isLoginWith_FB_TW = NO;
    [UserDataManager Shared].avatarSmallURL = @"";
    [UserDataManager Shared].fullName = @"";
    [UserDataManager Shared].sortMyKard = 0;
    [UserDataManager Shared].showMyKardUnread = 0;
    [UserDataManager Shared].userIsVisible = 0;
    [UserDataManager Shared].pointUser = 0;
    [UserDataManager Shared].myDefaultKardId = 0;
    [UserDataManager Shared].userMeKards = 0;
    
    [self cleanUserCacheAndCookie];
}

- (NSString*)getUserPlaceMark {
    [[AutomationDataManager Shared] startUpdateLocationService];
    if (currentPlaceMark.locality == nil) {
        return currentPlaceMark.administrativeArea;
    }
    return currentPlaceMark.locality;
}

- (void)save {
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self] forKey:STRING_USER_DEFAULT_USER_DATA_MANAGER];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

static UserDataManager *m_Instance;
+ (UserDataManager *)Shared
{
    if ( !m_Instance ) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:STRING_USER_DEFAULT_USER_DATA_MANAGER];
        if ([NSKeyedUnarchiver unarchiveObjectWithData:data]) {
            m_Instance = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        
        if (m_Instance == nil) {
            m_Instance = [UserDataManager new];
        }
    }
    return m_Instance;
}

@end
