//
//  ImplicitRequester.m
//  trongvm
//
//  Created by Phan Ba Minh on 11/6/12.
//
//

#import "ImplicitRequester.h"
#import "SBJSON.h"
#import "SupportFunction.h"

@implementation ImplicitRequester

- (id)init
{
    self = [super init];
    if (self) {
        _APIRequester = [APIRequester new];
    }
    return self;
}

static ImplicitRequester *_implicitRequester;
+ (ImplicitRequester *)Shared
{
    if (!_implicitRequester) {
        _implicitRequester = [ImplicitRequester new];
    }
    return _implicitRequester;
}

- (void)update {
    
}

#pragma mark - Actions


#pragma mark - APIRequesterProtocol

- (void)requestFinished:(ASIHTTPRequest *)request andType:(ENUM_API_REQUEST_TYPE)type {
    NSLog(@"ImplicitRequester requestFinished: %@", [request responseString]);
    
    NSError *error;
    SBJSON *sbJSON = [SBJSON new];
    
    if (![sbJSON objectWithString:[request responseString] error:&error] || request.responseStatusCode != 200 || !request) {
        return;
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request andType:(ENUM_API_REQUEST_TYPE)type {
    NSLog(@"ImplicitRequester requestFailed: %@", [request responseString]);
}

@end
