//
//  ChooseLocationViewController.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/24/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "ChooseLocationViewController.h"
@import GooglePlaces;
@interface ChooseLocationViewController ()
@property (strong, nonatomic) NSString *street_number;
@property (strong, nonatomic) NSString *route;
@property (strong, nonatomic) NSString *neighborhood;
@property (strong, nonatomic) NSString *locality;
@property (strong, nonatomic) NSString *administrative_area_level_1;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *postal_code;
@property (strong, nonatomic) NSString *postal_code_suffix;
@property (strong, nonatomic) Address *address;
@end

@implementation ChooseLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.address = [Address new];
    // Do any additional setup after loading the view.
}

- (void)updateAddress {
    self.address.addressLine1 = self.addressLine1.text;
    self.address.city = self.city.text;
    self.address.state = self.state.text;
    self.address.postalCode = self.postalCodeField.text;
    self.address.country = self.countryField.text;
    self.address.addressLine2 = @"";
}

- (IBAction)closeButton:(id)sender {
    [self.delegate addressFields:self.address];
    [self dismissViewControllerAnimated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchAddressButton:(id)sender {
    GMSAutocompleteViewController *autoCompleteController = [GMSAutocompleteViewController new];
    autoCompleteController.delegate = self;
    
    GMSAutocompleteFilter *addressFilter = [GMSAutocompleteFilter new];
    autoCompleteController.autocompleteFilter = addressFilter;
    
    [self presentViewController:autoCompleteController animated:true completion:nil];
}

- (void) fillAddressForm {
    self.addressLine1.text = [self.street_number stringByAppendingFormat:@" %@", self.route];
    self.city.text = self.locality;
    self.state.text = self.administrative_area_level_1;
    if (![self.postal_code_suffix isEqualToString:@""]) {
        self.postalCodeField.text = [self.postal_code stringByAppendingFormat:@"-%@", self.postal_code_suffix];
    } else {
        self.postalCodeField.text = self.postal_code;
    }
    self.countryField.text = self.country;
    
    self.street_number = @"";
    self.route = @"";
    self.neighborhood = @"";
    self.locality = @"";
    self.administrative_area_level_1 = @"";
    self.country = @"";
    self.postal_code = @"";
    self.postal_code_suffix = @"";
}

- (void)viewController:(nonnull GMSAutocompleteViewController *)viewController didAutocompleteWithPlace:(nonnull GMSPlace *)place {
    if (place.addressComponents) {
        NSArray *addressLines = place.addressComponents;
        for (GMSAddressComponent *field in addressLines) {
            if ([field.type isEqualToString:kGMSPlaceTypeStreetNumber]) {
                self.street_number = field.name;
            }
            if ([field.type isEqualToString:kGMSPlaceTypeRoute]) {
                self.route = field.name;
            }
            if ([field.type isEqualToString:kGMSPlaceTypeNeighborhood]) {
                self.neighborhood = field.name;
            }
            if ([field.type isEqualToString:kGMSPlaceTypeLocality]) {
                self.locality = field.name;
            }
            if ([field.type isEqualToString:kGMSPlaceTypeAdministrativeAreaLevel1]) {
                self.administrative_area_level_1 = field.name;
            }
            if ([field.type isEqualToString:kGMSPlaceTypeCountry]) {
                self.country = field.name;
            }
        }
    }
    [self fillAddressForm];
    [self updateAddress];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewController:(nonnull GMSAutocompleteViewController *)viewController didFailAutocompleteWithError:(nonnull NSError *)error {
    NSLog(@"%@", error.localizedDescription);
}

- (void)wasCancelled:(nonnull GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
