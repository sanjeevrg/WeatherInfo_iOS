//
//  FetchWeatherView.h
//  WeatherInfo
//
//  Created by Sanjeev G on 21/01/17.
//  Copyright © 2017 Sanjeev G. All rights reserved.
//

#ifndef FetchWeatherView_h
#define FetchWeatherView_h

#import <UIKit/UIKit.h>

@interface FetchWeatherView : UIView

@property (nonatomic,strong)UILabel *cityNameLabel;
@property (nonatomic,strong)UILabel *temperatureLabel;
@property (nonatomic,strong)UILabel *maxTempLabel;
@property (nonatomic,strong)UILabel *minTempLabel;
@property (nonatomic,strong)UILabel *humidityLabel;
@property (nonatomic,strong)UILabel *pressureLabel;

@end

#endif /* FetchWeatherView_h */
