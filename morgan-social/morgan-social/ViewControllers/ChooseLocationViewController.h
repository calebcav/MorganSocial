//
//  ChooseLocationViewController.h
//  morgan-social
//
//  Created by Caleb Caviness on 7/24/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"
@import GooglePlaces;
NS_ASSUME_NONNULL_BEGIN
@protocol ChooseLocationViewControllerDelegate
- (void) addressFields: (Address *)address;
@end

@interface ChooseLocationViewController : UIViewController <GMSAutocompleteViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *addressLine1;
@property (strong, nonatomic) IBOutlet UITextField *addressLine2;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *state;
@property (strong, nonatomic) IBOutlet UITextField *postalCodeField;
@property (strong, nonatomic) IBOutlet UITextField *countryField;
@property (nonatomic, weak) id<ChooseLocationViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
