//
//  Address.h
//  morgan-social
//
//  Created by Caleb Caviness on 7/24/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface Address : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *addressLine1;
@property (nonatomic, strong) NSString *addressLine2;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) NSString *country;

+ (void) createAddress: (NSString * _Nullable)addressLine1 withAdressLine2: (NSString *_Nullable)addressLine2 withCity: (NSString *_Nullable)city withState: (NSString *_Nullable) state withPostalCode: (NSString *_Nullable) postalCode withCountry: (NSString *_Nullable) country withCompletion:(PFBooleanResultBlock _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
