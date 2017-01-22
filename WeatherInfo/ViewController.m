//
//  ViewController.m
//  WeatherInfo
//
//  Created by Sanjeev G on 21/01/17.
//  Copyright © 2017 Sanjeev G. All rights reserved.
//

#import "ViewController.h"
#import "LocationViewController.h"
#import "FetchWeatherService.h"
#import "FetchWeatherModel.h"
#import "FetchWeatherView.h"

@interface ViewController ()

@property (nonatomic,strong)FetchWeatherModel *curDataModel;
@property (nonatomic,strong)FetchWeatherView *curWeatherView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"Weather Information";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    locationButton.frame = CGRectMake((self.view.frame.size.width-160)/2, 80, 160, 80);
    [locationButton setTitle:@"Change location" forState:UIControlStateNormal];
    [locationButton addTarget:self action:@selector(locationButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locationButton];
    
    
    self.curWeatherView = [[FetchWeatherView alloc] initWithFrame:CGRectMake(10, 200, self.view.frame.size.width, self.view.frame.size.height-200)];
    [self.view addSubview:self.curWeatherView];
    [self updateWithDefaultLocation];
}

- (void)updateWeatherView {
    self.curWeatherView.cityNameLabel.text = @"Place Name:";
    self.curWeatherView.temperatureLabel.text = @"Temperature:";
    self.curWeatherView.maxTempLabel.text = @"Max Temp:";
    self.curWeatherView.minTempLabel.text = @"Min Temp:";
    self.curWeatherView.humidityLabel.text = @"Humidity:";
    self.curWeatherView.pressureLabel.text = @"Pressure:";
    
    self.curWeatherView.cityNameLabel.text = [NSString stringWithFormat:@"%@ %@",self.curWeatherView.cityNameLabel.text,self.curDataModel.cityName];
    self.curWeatherView.temperatureLabel.text = [NSString stringWithFormat:@"%@ %@",self.curWeatherView.temperatureLabel.text,self.curDataModel.temperature];
    self.curWeatherView.maxTempLabel.text = [NSString stringWithFormat:@"%@ %@",self.curWeatherView.maxTempLabel.text,self.curDataModel.maxTemp];
    self.curWeatherView.minTempLabel.text = [NSString stringWithFormat:@"%@ %@",self.curWeatherView.minTempLabel.text,self.curDataModel.minTemp];
    self.curWeatherView.humidityLabel.text = [NSString stringWithFormat:@"%@ %@",self.curWeatherView.humidityLabel.text,self.curDataModel.humidity];
    self.curWeatherView.pressureLabel.text = [NSString stringWithFormat:@"%@ %@",self.curWeatherView.pressureLabel.text,self.curDataModel.pressure];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateWithDefaultLocation {
    [[FetchWeatherService sharedInstance] requestWeatherWithCityName:@"Bangalore"
                                                             success:^(id responseObject){
                                                                 NSLog(@"Response Object %@",responseObject);
                                                                 if (!self.curDataModel) {
                                                                     self.curDataModel = [[FetchWeatherModel alloc] init];
                                                                 }
                                                                 [self.curDataModel updateModelWithDictionary:(NSDictionary*)responseObject];
                                                                 [self performSelectorOnMainThread:@selector(updateWeatherView) withObject:nil waitUntilDone:NO];
                                                                 
                                                             } failure:^(NSError *error) {
                                                                 NSLog(@"Response Error %@",error);
                                                                 UIAlertView *authAV = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please, try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                                 [authAV show];
                                                             }];
}

- (void)locationButtonPressed {
    LocationViewController *locationVC = [[LocationViewController alloc] init];
    locationVC.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:locationVC];
    [navController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

#pragma LocationDataDelegate
- (void)didSelectLocation:(NSString*)selectedLocation {
//    if ([OWLocationManager sharedInstance].isCurDeviceLocation) {
//        [[OWService sharedInstance] requestWeatherWithLocation:[OWLocationManager sharedInstance].curDeviceLocation
//                                                       success:^(id responseObject){
//                                                           NSLog(@"Response Object %@",responseObject);
//                                                           if (!self.curDataModel) {
//                                                               self.curDataModel = [[OWModel alloc] init];
//                                                           }
//                                                           [self.curDataModel updateModelWithDictionary:(NSDictionary*)responseObject];
//                                                           [self performSelectorOnMainThread:@selector(updateWeatherView) withObject:nil waitUntilDone:NO];
//                                                           
//                                                       } failure:^(NSError *error) {
//                                                           NSLog(@"Response Error %@",error);
//                                                           UIAlertView *authAV = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please, try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                                           [authAV show];
//                                                       }];
//    } else {
    if([selectedLocation isEqualToString:@"InvalidEntry"]){
//        UIAlertController *alert = [UIAlertController
//                                    alertControllerWithTitle:@"Invalid Location"
//                                    message:@"Please enter Valid Country and City"
//                                    preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction* ok = [UIAlertAction
//                             actionWithTitle:@"OK"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * action)
//                             {
//                                 [alert dismissViewControllerAnimated:YES completion:nil];
//                                 
//                             }];
//        [alert addAction:ok];
//        [self presentViewController:alert animated:YES completion:nil];
        UIAlertView *authAV = [[UIAlertView alloc] initWithTitle:@"Invalid Location" message:@"Please enter Valid Country and City" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [authAV show];


    }else {
        [[FetchWeatherService sharedInstance] requestWeatherWithCityName:selectedLocation
                                                                 success:^(id responseObject){
                                                                     NSLog(@"Response Object %@",responseObject);
                                                                     if (!self.curDataModel) {
                                                                         self.curDataModel = [[FetchWeatherModel alloc] init];
                                                                     }
                                                                     [self.curDataModel updateModelWithDictionary:(NSDictionary*)responseObject];
                                                                     [self performSelectorOnMainThread:@selector(updateWeatherView) withObject:nil waitUntilDone:NO];
                                                                     
                                                                 } failure:^(NSError *error) {
                                                                     NSLog(@"Response Error %@",error);
                                                                     UIAlertView *authAV = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please, try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                                     [authAV show];
                                                                 }];

        
    }
        //    }
}


@end
