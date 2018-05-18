//
//  AppUserObject.h
//  
//
//  Created by Shreesh Garg on 09/09/14.
//___COPYRIGHT___
//

#import <Foundation/Foundation.h>

@class LocationObject;

@interface AppUserObject : NSObject <NSCopying>

@property (nonatomic, copy) NSNumber * entityId;
@property double refreshTime;
@property (nonatomic, copy) NSString * token;
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, copy) NSString *ParlourId;
@property (nonatomic, copy) NSString *ProfileId;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *device_id;
@property (nonatomic, copy) NSString *Gender;
@property (nonatomic, copy) NSString *BloodGroup;
@property (nonatomic, copy) NSNumber *isProfileCompleted;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *user_name_object;
@property (nonatomic, copy) NSString *Mobile;
@property (nonatomic,copy)  NSString *pincode;
@property (nonatomic,copy)  NSString *address;
@property (nonatomic,copy)  NSString *locality;
@property (nonatomic,copy)  NSString *Age;
@property (nonatomic,copy)  NSString *Area_Covered;
@property (nonatomic,copy)  NSString *city;
@property (nonatomic,copy)  NSString *contactpersonName;
@property (nonatomic,copy)  NSString *Date_employment;
@property (nonatomic,copy)  NSString *weekoff;
@property (nonatomic,copy)  NSString *UserImageUrl;
@property (nonatomic,copy)  NSArray *arrSearch;
@property (nonatomic,copy)  NSString *userId;
@property (nonatomic,copy)  NSString *countryCode;
@property (nonatomic,copy)  NSMutableArray *mutableDataArray;
@property (nonatomic,copy)  NSMutableArray *tempMuteArray;


+ (AppUserObject *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

-(void)saveToUserDefault;
+(instancetype)getFromUserDefault;
+(void)removeFromUserDefault;

@end

@interface ECSUserDefault: NSObject

+(BOOL)getBoolFromUserDefaultForKey:(NSString *)string;
+(NSInteger)getIntFromUserDefaultForKey:(NSString *)string;
+(NSString *)getStringFromUserDefaultForKey:(NSString *)string;
+(float)getFloatFromUserDefaultForKey:(NSString *)string;
+(id)getObjectFromUserDefaultForKey:(NSString *)string;


+(void)saveBool:(BOOL)val ToUserDefaultForKey:(NSString *)string;
+(void)saveInt:(int)val ToUserDefaultForKey:(NSString *)string;
+(void)saveString:(NSString *)val ToUserDefaultForKey:(NSString *)string;
+(void)saveFloat :(float)val ToUserDefaultForKey:(NSString *)string;
+(void)saveObject:(id)val ToUserDefaultForKey:(NSString *)string;

@end

