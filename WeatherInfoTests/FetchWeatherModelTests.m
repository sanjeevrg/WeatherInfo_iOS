//
//  FetchWeatherModelTests.m
//  WeatherInfo
//
//  Created by Sanjeev G on 23/01/17.
//  Copyright © 2017 Sanjeev G. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FetchWeatherModel.h"

@interface FetchWeatherModelTests : XCTestCase

@end

@implementation FetchWeatherModelTests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = YES;
    
}

- (void)testDataModel {
    FetchWeatherModel *dataModel = [[FetchWeatherModel alloc]init];
    
    NSError *err = nil;
    NSString *resp = @"{main = { humidity = 36; pressure = 1018; temp = \"299.15\";\"temp_max\" = \"299.15\";\"temp_min\" = \"299.15\";};name = Bangalore;weather= ({description = \"clear sky\";});}";
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[resp dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
    NSDictionary *dictionary = [array objectAtIndex:0];
    
    [dataModel updateModelWithDictionary:(NSDictionary*)dictionary];
    
    XCTAssertEqualObjects(@"Bangalore", dataModel.cityName, @"Result was not correct!");
    XCTAssertEqualObjects(@"26", dataModel.temperature, @"Result was not correct!");
    XCTAssertEqualObjects(@"1018", dataModel.pressure, @"Result was not correct!");
    
}



- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
