//
//  FetchWeatherModel.m
//  WeatherInfo
//
//  Created by Sanjeev G on 21/01/17.
//  Copyright © 2017 Sanjeev G. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchWeatherModel.h"

@implementation FetchWeatherModel

- (void)updateModelWithDictionary:(NSDictionary*)responseDict {
    if ([responseDict objectForKey:@"name"]) {
        self.cityName = [responseDict objectForKey:@"name"];
    }
    if ([responseDict objectForKey:@"main"]) {
        NSDictionary *mainDict = [responseDict objectForKey:@"main"];
        //temp being returned in kelvin scale
        float temp = ([[mainDict objectForKey:@"temp"] integerValue] -273.15 );
        float maxtemp = ([[mainDict objectForKey:@"temp_max"] integerValue] - 273.15);
        float mintemp = ([[mainDict objectForKey:@"temp_min"] integerValue] - 273.15);
        self.temperature = [NSString stringWithFormat:@"%.02f",temp];
        self.maxTemp = [NSString stringWithFormat:@"%.02f",maxtemp];
        self.minTemp = [NSString stringWithFormat:@"%.02f",mintemp];
        self.humidity = [mainDict objectForKey:@"humidity"];
        self.pressure = [mainDict objectForKey:@"pressure"];
    }
}

//Update with proper alert message for extreme conditions
- (void)updateAlertMessage:(NSDictionary*)responseDict {
    NSDictionary *list = [responseDict objectForKey:@"list"];
    NSString *date;
    NSString *alertText;
    for(id key in list) {
        NSDictionary *mainBlock = [key objectForKey:@"main"];
        NSString *tempString = [[[mainBlock description] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "];
        NSString *temp = [[tempString componentsSeparatedByString:@"temp ="]lastObject];
        NSString *futureTemp = [[temp componentsSeparatedByString:@";"]firstObject];
        NSString *tempVar = [futureTemp stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        float forecastTemp = [tempVar integerValue] - 273.15;
        
        if(forecastTemp>30){
            alertText = @"High temperature on ";
            date=[key objectForKey:@"dt_txt"];
            break;
        } else if(forecastTemp<5){
            alertText = @"Low temperature on ";
            date=[key objectForKey:@"dt_txt"];
            break;
        }
    }
    if(alertText && date){
        date = [[date componentsSeparatedByString:@" "]firstObject];
        self.alertMessage = [NSString stringWithFormat:@"%@%@", alertText, date];
    }
    
}

@end
