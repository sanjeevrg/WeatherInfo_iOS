//
//  FetchWeatherView.m
//  WeatherInfo
//
//  Created by Sanjeev G on 21/01/17.
//  Copyright © 2017 Sanjeev G. All rights reserved.
//

#import "FetchWeatherView.h"

@implementation FetchWeatherView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 250, 25)];
        self.cityNameLabel.font = [UIFont systemFontOfSize:16];
        self.cityNameLabel.textColor = [UIColor blackColor];
        self.cityNameLabel.backgroundColor = [UIColor clearColor];
        self.cityNameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.cityNameLabel];
        
        self.temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.cityNameLabel.frame.origin.y+self.cityNameLabel.frame.size.height+10, 200, 25)];
        self.temperatureLabel.font = [UIFont systemFontOfSize:16];
        self.temperatureLabel.textColor = [UIColor blackColor];
        self.temperatureLabel.backgroundColor = [UIColor clearColor];
        self.temperatureLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.temperatureLabel];
        
        self.maxTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.temperatureLabel.frame.origin.y+self.temperatureLabel.frame.size.height+10, 200, 25)];
        self.maxTempLabel.font = [UIFont systemFontOfSize:16];
        self.maxTempLabel.textColor = [UIColor blackColor];
        self.maxTempLabel.backgroundColor = [UIColor clearColor];
        self.maxTempLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.maxTempLabel];
        
        self.minTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.maxTempLabel.frame.origin.y+self.maxTempLabel.frame.size.height+10, 200, 25)];
        self.minTempLabel.font = [UIFont systemFontOfSize:16];
        self.minTempLabel.textColor = [UIColor blackColor];
        self.minTempLabel.backgroundColor = [UIColor clearColor];
        self.minTempLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.minTempLabel];
        
        self.humidityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.minTempLabel.frame.origin.y+self.minTempLabel.frame.size.height+10, 200, 25)];
        self.humidityLabel.font = [UIFont systemFontOfSize:16];
        self.humidityLabel.textColor = [UIColor blackColor];
        self.humidityLabel.backgroundColor = [UIColor clearColor];
        self.humidityLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.humidityLabel];
        
        self.pressureLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.humidityLabel.frame.origin.y+self.humidityLabel.frame.size.height+10, 200, 25)];
        self.pressureLabel.font = [UIFont systemFontOfSize:16];
        self.pressureLabel.textColor = [UIColor blackColor];
        self.pressureLabel.backgroundColor = [UIColor clearColor];
        self.pressureLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.pressureLabel];
    }
    return self;
}


@end
