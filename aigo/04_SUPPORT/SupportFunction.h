/*
 * $Author: kidbaw $
 * $Revision: 59 $
 * $Date: 2012-03-23 22:44:48 +0700 (Fri, 23 Mar 2012) $
 */

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

#define STRING_ALERT_MESSAGE_KARD_BUILDER_NAME_TOO_SHORT(a)             [NSString stringWithFormat:@"Please enter a %@ name of at least 2 characters", a]
#define STRING_ALERT_MESSAGE_KARD_BUILDER_NAME_MUST_BE_AVAILABLE(a)     [NSString stringWithFormat:@"Sorry, please enter a %@ name with only standard letters a-z, standard numbers 0-9,  or hyphen", a]
#define STRING_ALERT_MESSAGE_KARD_BUILDER_NAME_TOO_LONG(a)              [NSString stringWithFormat:@"Sorry, this %@ name is just too long!  Please enter a name 20 characters or less", a]
#define STRING_ALERT_MESSAGE_KARD_BUILDER_NAME_IS_ALREADY_IN_USE(a)     [NSString stringWithFormat:@"Sorry, that %@ name is already in use.  Please try again", a]

#define STRING_ALERT_MESSAGE_KARD_BUILDER_PROFILE_FIRST_NAME_TOO_SHORT            @"Please enter a first name"
#define STRING_ALERT_MESSAGE_KARD_BUILDER_PROFILE_FIRST_NAME_MUST_BE_AVAILABLE    @"Sorry, please enter a first name with only standard letters a-z, space, or hyphen"
#define STRING_ALERT_MESSAGE_KARD_BUILDER_PROFILE_FIRST_NAME_TOO_LONG             @"Sorry, your first name is just too long!  Please enter a first name 32 characters or less"

#define STRING_ALERT_MESSAGE_KARD_BUILDER_PROFILE_LAST_NAME_TOO_SHORT            @"Please enter a last name"
#define STRING_ALERT_MESSAGE_KARD_BUILDER_PROFILE_LAST_NAME_MUST_BE_AVAILABLE    @"Sorry, please enter a last name with only standard letters a-z, space, or hyphen"
#define STRING_ALERT_MESSAGE_KARD_BUILDER_PROFILE_LAST_NAME_TOO_LONG             @"Sorry, your last name is just too long!  Please enter a first name 32 characters or less"

typedef enum {
	enumImageScalingType_Invalid,
    enumImageScalingType_Left,
    enumImageScalingType_Top,
    enumImageScalingType_Right,
    enumImageScalingType_Bottom,
    enumImageScalingType_TargetSize,
    enumImageScalingType_Center_ScaleSize,
    enumImageScalingType_Center_FullSize
} enumImageScalingType;

typedef enum {
    enumPhotoShopLayerTextAlignment_Invalid,
    enumPhotoShopLayerTextAlignment_Left = NSTextAlignmentLeft,
    enumPhotoShopLayerTextAlignment_Right = NSTextAlignmentRight,
    enumPhotoShopLayerTextAlignment_Center = NSTextAlignmentCenter,
    enumPhotoShopLayerTextAlignment_Justified = NSTextAlignmentJustified ,
    enumPhotoShopLayerTextAlignment_Natural = NSTextAlignmentNatural
}enumPhotoShopLayerTextAlignment;

#define WIDTH_IMAGE_REDUCED_QUALITY_DEFAULT                             720
#define HEIGHT_IMAGE_REDUCED_QUALITY_DEFAULT                            720
#define QUALITY_IMAGE_REDUCED_QUALITY_DEFAULT                           0.95

@interface UIImage (Extras)
- (UIImage *)imageByScalingToSize:(CGSize)size withOption:(enumImageScalingType)type;
- (NSData*)getImageDataWithMaxSize:(CGSize)size andQuality:(float)quality;
@end;


typedef enum {
    enumNSStringExtrasCheckingType_Invalid,
    enumNSStringExtrasCheckingType_KardBuilder_KardName,
    enumNSStringExtrasCheckingType_KardBuilder_ProfileName,
    enumNSStringExtrasCheckingType_KardBuilder_Profile_FirstName,
    enumNSStringExtrasCheckingType_KardBuilder_Profile_LastName
}enumNSStringExtrasCheckingType;

@interface NSString (Extras)
- (BOOL)isAvailableWithCheckingType:(enumNSStringExtrasCheckingType)checkingType;
@end;

typedef enum {
    enumVKNotificationAppearPosition_Invalid,
    enumVKNotificationAppearPosition_Top_Left,
    enumVKNotificationAppearPosition_Top_Right,
    enumVKNotificationAppearPosition_Top_Right_Not_Margin_Right,
    enumVKNotificationAppearPosition_Bottom_Left,
    enumVKNotificationAppearPosition_Bottom_Right
}enumVKNotificationAppearPosition;

enum {
    UIDeviceResolution_Unknown          = 0,
    UIDeviceResolution_iPhoneStandard   = 1,    // iPhone 1,3,3GS Standard Display  (320x480px)
    UIDeviceResolution_iPhoneRetina35   = 2,    // iPhone 4,4S Retina Display 3.5"  (640x960px)
    UIDeviceResolution_iPhoneRetina4    = 3,    // iPhone 5 Retina Display 4"       (640x1136px)
    UIDeviceResolution_iPadStandard     = 4,    // iPad 1,2 Standard Display        (1024x768px)
    UIDeviceResolution_iPadRetina       = 5     // iPad 3 Retina Display            (2048x1536px)
}; typedef NSUInteger UIDeviceResolution;

@interface UIDevice (Resolutions)

- (UIDeviceResolution)resolution;

NSString *NSStringFromResolution(UIDeviceResolution resolution);

@end

@interface SupportFunction : NSObject
+ (BOOL)deviceIsIPad;
+ (int)getDeviceHeight;
+ (int)getDeviceWidth;
+ (int)getKeyboardHeight;
+ (int)getKeyboardWidth;
+ (NSMutableArray *)sortArray:(NSMutableArray *)source withKey:(NSString *)key;

+ (NSString *)getStringDistanceFromMeter:(double)meters;

+ (void)alertWithError:(int)error andMessage:(NSString *)message;

+ (NSDate *)dateFromRFC1123String:(NSString *)string;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromDateUseForName:(NSDate *)date;
+ (NSMutableDictionary *)repairingDictionaryWith:(NSDictionary *)dictionary;

void ALERT(NSString* title, NSString* message);
void alertView(NSString *title, NSString *message,NSString *dismissString);
UIAlertView* UI_ALERT_VIEW(NSString* title, NSString* msg, id delegate, NSString* other_button, NSString* cancel_button);

+ (void)scalePickerView:(UIPickerView *)picker toSize:(CGSize)size;

+ (UIColor *)colorFromHexString:(NSString *)hexString;

+ (CGRect)getFrameNotificationWithFont:(UIFont *)font andNotificationNumber:(int)num andAppearPosition:(enumVKNotificationAppearPosition)position andParentFrame:(CGRect)frame;
+ (NSString *)getObjectTextWithCount:(NSInteger)count withText:(NSString *)text withHidden:(BOOL)isHidden;
+ (NSString *)textForDate:(NSString *)stringDate withTime:(BOOL)time;

@end
