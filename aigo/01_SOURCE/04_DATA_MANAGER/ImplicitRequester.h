//
//  ImplicitRequester.h
//  VISIKARD
//
//  Created by Phan Ba Minh on 11/6/12.
//
//

#import <Foundation/Foundation.h>
#import "APIRequester.h"
#import "UserDataManager.h"

#define INT_IMPLICIT_REQUESTER_NUMBER_LOOP_MAX                          5

@interface ImplicitRequester : NSObject <APIRequesterProtocol> {
    APIRequester                                *_APIRequester;
}

- (void)update;
+ (ImplicitRequester *)Shared;

@end
