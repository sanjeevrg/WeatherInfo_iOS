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

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
    [self.navigationItem setRightBarButtonItem:cancelButton];
    self.title = @"Select a Location";
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
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
//    [[UIButton alloc] initWithFrame:CGRectMake(30, 240, 100, 30)];
    [self.view addSubview:self.selectLocation];
    
//    self.locationTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    [self.locationTableview setBackgroundColor:[UIColor lightGrayColor]];
//    self.locationTableview.showsVerticalScrollIndicator = NO;
//    self.locationTableview.dataSource = self;
//    self.locationTableview.delegate = self;
//    [self.view addSubview:self.locationTableview];
    
    self.locationDataSource = [[NSMutableArray alloc] initWithObjects:@"Bangalore",@"Sunnyvale,USA",@"Mountain View,USA",@"Fremont,USA",@"San Francisco,USA",@"Los Angeles,USA",@"New York,USA", nil];
    
}

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
    
//    NSMutableArray *sortedCountryArray = [[NSMutableArray alloc] init];
    
    for (NSString *countryCode in countryArray) {
        
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        if([displayNameString isEqualToString:country]){
            return true;
        }
//        [sortedCountryArray addObject:displayNameString];
        
    }
    return false;
}

-(BOOL) validateCity:(NSString*) country :(NSString*) city{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"listOfCities" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSArray *listOfCities = [json valueForKey:country];
    
    if([listOfCities containsObject:city]){
        return true;
    }

//    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
//    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    return false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelButtonPressed {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.locationDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *locationCellID = @"LocationCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:locationCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:locationCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.textLabel.text = [self.locationDataSource objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        [OWLocationManager sharedInstance].isCurDeviceLocation = YES;
//    } else {
//        [OWLocationManager sharedInstance].isCurDeviceLocation = NO;
//    }
//    [OWLocationManager sharedInstance].curUserLocation = [self.locationDataSource objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didSelectLocation:)]) {
        [self.delegate didSelectLocation:[self.locationDataSource objectAtIndex:indexPath.row]];
    }
    
    [self cancelButtonPressed];
}


@end
