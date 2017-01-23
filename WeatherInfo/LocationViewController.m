//
//  LocationViewController.m
//  WeatherInfo
//
//  Created by Sanjeev G on 21/01/17.
//  Copyright © 2017 Sanjeev G. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationViewController.h"


@interface LocationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITableView *locationTableview;
@property (nonatomic,strong) NSMutableArray *locationDataSource;
@property (nonatomic,strong) UITextField *preferredCountry;
@property (nonatomic,strong) UITextField *preferredCity;
@property (nonatomic,strong) UIButton *selectLocation;

@end

@implementation LocationViewController

// Implement viewDidLoad to do additional setup after loading the view
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
    [self.navigationItem setRightBarButtonItem:cancelButton];
    self.title = @"Select a Location";
    
    self.view.backgroundColor = [UIColor colorWithRed:34 green:34 blue:34 alpha:1.0];
    
    CGRect textFieldRect = CGRectMake(30.0, 80.0, 200.0, 30.0);
    self.preferredCountry = [[UITextField alloc] initWithFrame:textFieldRect];
    self.preferredCountry.placeholder = @"Enter Country";
    self.preferredCountry.delegate = self;
    [self.view addSubview:self.preferredCountry];
    
    self.preferredCity = [[UITextField alloc] initWithFrame:CGRectMake(30, 160, 200, 30)];
    self.preferredCity.placeholder = @"Enter City";
    self.preferredCity.delegate = self;
    [self.view addSubview:self.preferredCity];
    
    self.selectLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectLocation addTarget:self
               action:@selector(updateWithLocation:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.selectLocation setTitle:@"Select" forState:UIControlStateNormal];
    self.selectLocation.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.selectLocation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:self.selectLocation];
    
    self.locationDataSource = [[NSMutableArray alloc] initWithObjects:@"Bangalore",@"Sunnyvale,USA",@"Mountain View,USA",@"Fremont,USA",@"San Francisco,USA",@"Los Angeles,USA",@"New York,USA", nil];
    
}

//Update Location with input
-(void) updateWithLocation:(UIButton *)sender {
    if ([self.preferredCountry hasText] && [self.preferredCity hasText]){
        BOOL validCountry = [self validateCountry:self.preferredCountry.text];
        BOOL validCity = false;
        if(validCountry){
            validCity = [self validateCity:self.preferredCountry.text :self.preferredCity.text];
        }
        
        if(!validCountry || !validCity){
            [self.delegate didSelectLocation:@"InvalidEntry"];
            [self cancelButtonPressed];
                        
        }else if ([self.delegate respondsToSelector:@selector(didSelectLocation:)]) {
            [self.delegate didSelectLocation:self.preferredCity.text];
            [self cancelButtonPressed];
        }
    }else{
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Empty Location"
                                    message:@"Please enter Country and City"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
         [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (BOOL) validateCountry:(NSString*)country {
    NSLocale *locale = [NSLocale currentLocale];
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    
    for (NSString *countryCode in countryArray) {
        
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        if([displayNameString isEqualToString:country]){
            return true;
        }
        
    }
    return false;
}

// City is validated by checking entry in json
-(BOOL) validateCity:(NSString*) country :(NSString*) city{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"listOfCities" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSArray *listOfCities = [json valueForKey:country];
    
    if([listOfCities containsObject:city]){
        return true;
    }

    return false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelButtonPressed {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end
