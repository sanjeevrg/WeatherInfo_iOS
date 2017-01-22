//
//  FetchWeatherService.m
//  WeatherInfo
//
//  Created by Sanjeev G on 21/01/17.
//  Copyright © 2017 Sanjeev G. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchWeatherService.h"

#define kApiKey @"0f2ce24adbdd71d196d0157dd513ac9c" //&APPID=
#define kOpenWeatherUrl @"http://api.openweathermap.org/data/2.5/weather?"
#define kOpenWeatherForecastUrl @"http://api.openweathermap.org/data/2.5/forecast?"

@implementation FetchWeatherService

static FetchWeatherService *sharedOpenWeatherService = nil;

+ (FetchWeatherService*)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedOpenWeatherService = [[self alloc]init];
    });
    
    return sharedOpenWeatherService;
}

- (void)requestWeatherWithCityName:(NSString*)cityName success:(successBlock)success failure:(failureBlock)fail {
//    NSString *urlKey = @"&appid=";
    NSString * urlString = [NSString stringWithFormat:@"%@q=%@&appid=%@",kOpenWeatherUrl,cityName,kApiKey];
    [self requestWithUrlString:urlString
                       success:^(id responseObject) {
                           success(responseObject);
                       } failure:^(NSError *error) {
                           fail(error);
                       }
     ];
}

- (void)requestWithUrlString:(NSString*)urlString success:(successBlock)success failure:(failureBlock)fail {
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"POST";
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    request.timeoutInterval = 15;
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"charset" forHTTPHeaderField:@"utf-8"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         
         NSDictionary * dictionary = nil;
         if(data.length>0 && !error) {
             dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             success(dictionary);
         }
         
         if(error) {
             fail(error);
         }
         
     }];
}

- (void)requestForecastWithCityName:(NSString*)cityName success:(successBlock)success failure:(failureBlock)fail {
    //    NSString *urlKey = @"&appid=";
    NSString * urlString = [NSString stringWithFormat:@"%@q=%@&appid=%@",kOpenWeatherForecastUrl,cityName,kApiKey];
    [self requestWithUrlForecast:urlString
                       success:^(id responseObject) {
                           success(responseObject);
                       } failure:^(NSError *error) {
                           fail(error);
                       }
     ];
}

- (void)requestWithUrlForecast:(NSString*)urlString success:(successBlock)success failure:(failureBlock)fail {
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"POST";
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    request.timeoutInterval = 15;
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"charset" forHTTPHeaderField:@"utf-8"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         
         NSDictionary * dictionary = nil;
         if(data.length>0 && !error) {
             dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             success(dictionary);
         }
         
         if(error) {
             fail(error);
         }
         
     }];
}


@end
