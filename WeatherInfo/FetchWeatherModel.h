//
//  FetchWeatherModel.h
//  WeatherInfo
//
//  Created by Sanjeev G on 21/01/17.
//  Copyright © 2017 Sanjeev G. All rights reserved.
//

#ifndef FetchWeatherModel_h
#define FetchWeatherModel_h

@interface FetchWeatherModel : NSObject

@property (nonatomic,strong)NSString *cityName;
@property (nonatomic,strong)NSString *temperature;
@property (nonatomic,strong)NSString *maxTemp;
@property (nonatomic,strong)NSString *minTemp;
@property (nonatomic,strong)NSString *humidity;
@property (nonatomic,strong)NSString *pressure;
@property (nonatomic,strong)NSString *alertMessage;

- (void)updateModelWithDictionary:(NSDictionary*)responseDict;
- (void)updateAlertMessage:(NSDictionary*)responseDict;

@end


#endif /* FetchWeatherModel_h */
