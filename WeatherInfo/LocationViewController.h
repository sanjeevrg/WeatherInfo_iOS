//
//  LocationViewController.h
//  WeatherInfo
//
//  Created by Sanjeev G on 21/01/17.
//  Copyright © 2017 Sanjeev G. All rights reserved.
//

#ifndef LocationViewController_h
#define LocationViewController_h

#import <UIKit/UIKit.h>

@protocol LocationDataDelegate;

@interface LocationViewController : UIViewController
@property (nonatomic,weak) id<LocationDataDelegate> delegate;

@end

@protocol LocationDataDelegate <NSObject>
@required
- (void)didSelectLocation:(NSString*)selectedLocation;
@end

#endif /* LocationViewController_h */
