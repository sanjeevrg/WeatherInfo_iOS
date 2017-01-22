//
//  FetchWeatherService.h
//  WeatherInfo
//
//  Created by Sanjeev G on 21/01/17.
//  Copyright © 2017 Sanjeev G. All rights reserved.
//

#ifndef FetchWeatherService_h
#define FetchWeatherService_h

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FetchWeatherService : NSObject

typedef void (^successBlock)(id responseObject);
typedef void (^failureBlock)(NSError* error);

+(FetchWeatherService*)sharedInstance;
- (void)requestWeatherWithCityName:(NSString*)cityName success:(successBlock)success failure:(failureBlock)fail;

@end

#endif /* FetchWeatherService_h */
