//
//  Address.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/24/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "Address.h"
#import <Parse/Parse.h>

@implementation Address

@dynamic addressLine1;
@dynamic addressLine2;
@dynamic city;
@dynamic state;
@dynamic postalCode;
@dynamic country;

+ (nonnull NSString *)parseClassName {
    return @"Address";
}

+ (void) createAddress:(NSString *)addressLine1 withAdressLine2:(NSString *)addressLine2 withCity:(NSString *)city withState:(NSString *)state withPostalCode:(NSString *)postalCode withCountry:(NSString *)country withCompletion:(nonnull PFBooleanResultBlock)completion{
    Address *newAddress = [Address new];
    newAddress.addressLine1 = addressLine1;
    newAddress.addressLine2 = addressLine2;
    newAddress.city = city;
    newAddress.country = country;
    newAddress.postalCode = postalCode;
    newAddress.state = state;
    
    [newAddress saveInBackgroundWithBlock:completion];
}

@end
