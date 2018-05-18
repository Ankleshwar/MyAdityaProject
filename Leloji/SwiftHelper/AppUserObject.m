//
//  AppUserObject.m
//  
//
//  Created by Shreesh Garg on 09/09/14.
//___COPYRIGHT___
//

#define kAppUserObject          @"kAppUserObject"

#import "AppUserObject.h"




@implementation AppUserObject

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
          self.token =[decoder decodeObjectForKey:@"token"];
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.ParlourId  =[decoder decodeObjectForKey:@"beautician_parlour_id"];
        self.countryCode=[decoder decodeObjectForKey:@"code"];
        self.userId = [decoder decodeObjectForKey:@"user_id"];
        self.userType=[decoder decodeObjectForKey:@"beautician_type"];
        self.firstName = [decoder decodeObjectForKey:@"firstname"];
        self.lastName = [decoder decodeObjectForKey:@"lastname"];
        self.device_id = [decoder decodeObjectForKey:@"device_id"];
        self.Gender = [decoder decodeObjectForKey:@"gender"];
        self.BloodGroup = [decoder decodeObjectForKey:@"blood_group"];
        self.userName=[decoder decodeObjectForKey:@"username"];
        self.Age=[decoder decodeObjectForKey:@"age"];
        self.email=[decoder decodeObjectForKey:@"email"];
        self.Mobile=[decoder decodeObjectForKey:@"mobile"];
        self.arrSearch=[decoder decodeObjectForKey:@"arrSearch"];
        self.locality=[decoder decodeObjectForKey:@"locality"];
        self.pincode=[decoder decodeObjectForKey:@"pincode"];
        self.Area_Covered=[decoder decodeObjectForKey:@"area_covered"];
        self.city=[decoder decodeObjectForKey:@"city"];
        //self.statusCode=[aDictionary nonNullObjectForKey:@"status"];
        self.address=[decoder decodeObjectForKey:@"address"];
        self.contactpersonName=[decoder decodeObjectForKey:@"contactperson"];
        self.Date_employment=[decoder decodeObjectForKey:@"date_employment"];
        self.weekoff=[decoder decodeObjectForKey:@"week_off"];
        self.UserImageUrl=[decoder decodeObjectForKey:@"image"];
         self.entityId = [decoder decodeObjectForKey:@"entityId"];
        
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
      [encoder encodeObject:self.entityId forKey:@"entityId"];
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.ParlourId forKey:@"beautician_parlour_id"];
    [encoder encodeObject:self.token forKey:@"token"];
    [encoder encodeObject:self.countryCode forKey:@"code"];
    [encoder encodeObject:self.userId forKey:@"user_id"];
    [encoder encodeObject:self.userType forKey:@"beautician_type"];
    [encoder encodeObject:self.firstName forKey:@"firstname"];
    [encoder encodeObject:self.lastName forKey:@"lastname"];
    [encoder encodeObject:self.device_id forKey:@"device_id"];
    [encoder encodeObject:self.Gender forKey:@"gender"];
    [encoder encodeObject:self.BloodGroup forKey:@"blood_group"];
    [encoder encodeObject:self.userName forKey:@"username"];
    [encoder encodeObject:self.Age forKey:@"age"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.Mobile forKey:@"mobile"];
    [encoder encodeObject:self.arrSearch forKey:@"arrSearch"];
    [encoder encodeObject:self.locality forKey:@"locality"];
    [encoder encodeObject:self.pincode forKey:@"pincode"];
    [encoder encodeObject:self.Area_Covered forKey:@"area_covered"];
    [encoder encodeObject:self.city forKey:@"city"];
    //[encoder encodeObject:self.userName forKey:@"city"];
    [encoder encodeObject:self.address forKey:@"address"];
    [encoder encodeObject:self.contactpersonName forKey:@"contactperson"];
    [encoder encodeObject:self.Date_employment forKey:@"date_employment"];
    [encoder encodeObject:self.weekoff forKey:@"week_off"];
    [encoder encodeObject:self.UserImageUrl forKey:@"image"];

}



+ (AppUserObject *)instanceFromDictionary:(NSDictionary *)aDictionary {

    AppUserObject *instance = [[AppUserObject alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)rootDictionary {
    
    
    if (![rootDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSDictionary * aDictionary = [rootDictionary objectForKey:@"data"];

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    self.entityId = [aDictionary objectForKey:@"entityId"];
    self.userId = [aDictionary objectForKey:@"user_id"];
    self.access_token = [aDictionary objectForKey:@"access_token"];
   // self.arrSearch = [aDictionary objectForKey:@"arrSearch"];
//    self.ParlourId = [aDictionary ];
//    self.countryCode = [aDictionary nonNullObjectForKey:@"code"];
//
//    self.userType = [aDictionary nonNullNumberForKey:@"beautician_type"];
//    self.firstName = [aDictionary nonNullObjectForKey:@"firstname"];
//    self.lastName = [aDictionary nonNullObjectForKey:@"lastname"];
//    self.device_id = [aDictionary nonNullObjectForKey:@"device_id"];
//    self.Gender = [aDictionary nonNullObjectForKey:@"gender"];
//    self.BloodGroup = [aDictionary nonNullObjectForKey:@"blood_group"];
//    self.userName=[aDictionary nonNullObjectForKey:@"username"];
//    self.Age=[aDictionary nonNullObjectForKey:@"age"];
//    self.email=[aDictionary nonNullObjectForKey:@"email"];
//    self.Mobile=[aDictionary nonNullObjectForKey:@"mobile"];
//    self.AlternativeNumber=[aDictionary nonNullObjectForKey:@"alternative_number"];
//    self.locality=[aDictionary nonNullObjectForKey:@"locality"];
//    self.pincode=[aDictionary nonNullObjectForKey:@"pincode"];
//    self.Area_Covered=[aDictionary nonNullObjectForKey:@"area_covered"];
//    self.city=[aDictionary nonNullObjectForKey:@"city"];
//    //self.statusCode=[aDictionary nonNullObjectForKey:@"status"];
//    self.address=[aDictionary nonNullObjectForKey:@"address"];
//    self.contactpersonName=[aDictionary nonNullObjectForKey:@"contactperson"];
//    self.Date_employment=[aDictionary nonNullObjectForKey:@"date_employment"];
//    self.weekoff=[aDictionary nonNullObjectForKey:@"week_off"];
//    self.UserImageUrl=[aDictionary nonNullObjectForKey:@"image"];
    NSDictionary * authDict = [rootDictionary objectForKey:@"auth"];
    
   
 self.token = [authDict objectForKey:@"token"];


    
}


//- (void)savePersonArrayData:(PlaceObject*)personObject
//{
//    NSArray *dataArray ;
//    NSMutableArray *mutableDataArray = [[NSMutableArray alloc]init];
//    NSMutableArray *tempMuteArray = [[NSMutableArray alloc]init];
//    [_mutableDataArray addObject:personObject];
//    
//    
//    _tempMuteArray = [NSMutableArray arrayWithArray:_mutableDataArray];
//    
//    
//    NSData *personEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:personObject];
//    
//   
//    [_tempMuteArray addObject:personEncodedObject];
//    
//
//    dataArray = [[NSArray alloc] initWithArray:_mutableDataArray];
//
//    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
//    [userData setObject:dataArray forKey:@"personDataArray"];
//    [userData synchronize];
//}



-(void)saveToUserDefault
{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [ECSUserDefault saveObject:data ToUserDefaultForKey:kAppUserObject];
}
+(instancetype)getFromUserDefault
{
    NSData * data = [ECSUserDefault getObjectFromUserDefaultForKey:kAppUserObject];
    return[NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+(void)removeFromUserDefault
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:kAppUserObject];
    [[NSUserDefaults standardUserDefaults]synchronize];
}



@end


@implementation ECSUserDefault


// get the values from user defaults

+(BOOL)getBoolFromUserDefaultForKey:(NSString *)string
{
    return [[NSUserDefaults standardUserDefaults]boolForKey:string];
    
}

+(NSInteger)getIntFromUserDefaultForKey:(NSString *)string{
    
    return [[NSUserDefaults standardUserDefaults]integerForKey:string];
    
}
+(NSString *)getStringFromUserDefaultForKey:(NSString *)string{
    
    return [[NSUserDefaults standardUserDefaults]stringForKey:string];
    
}
+(float)getFloatFromUserDefaultForKey:(NSString *)string{
    
    return [[NSUserDefaults standardUserDefaults]floatForKey:string];
    
}
+(id)getObjectFromUserDefaultForKey:(NSString *)string{
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:string];
    
}

// svae the values to user defaults


+(void)saveBool:(BOOL)val ToUserDefaultForKey:(NSString *)string{
    
    [[NSUserDefaults standardUserDefaults]setBool:val forKey:string];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

+(void)saveInt:(int)val ToUserDefaultForKey:(NSString *)string
{
    [[NSUserDefaults standardUserDefaults]setInteger:val forKey:string];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


+(void)saveString:(NSString *)val ToUserDefaultForKey:(NSString *)string
{
    [[NSUserDefaults standardUserDefaults]setObject:val forKey:string];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


+(void)saveFloat :(float)val ToUserDefaultForKey:(NSString *)string
{
    [[NSUserDefaults standardUserDefaults]setFloat:val forKey:string];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


+(void)saveObject:(id)val ToUserDefaultForKey:(NSString *)string
{
    [[NSUserDefaults standardUserDefaults]setObject:val forKey:string];
    [[NSUserDefaults standardUserDefaults]synchronize];
}





@end




