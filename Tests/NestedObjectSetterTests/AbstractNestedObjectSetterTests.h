//
//  AbstractNestedObjectSetterTests.h
//  NestedObjectSetters
//
//  Created by Ryan Maxwell on 4/08/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NestedObjectSetters.h"

@interface AbstractNestedObjectSetterTests : XCTestCase

@property (strong, nonatomic) id testObject;

- (void)testSetNestedStringValue;
- (void)testSetNestedBoolValue;
- (void)testOverwriteExistingNestedStringValue;

- (void)testSettingExistingNestedStringValueNil;
- (void)testNilKeyPathThrowsException;
- (void)testEmptyKeyPathSetsValue;

- (void)testNotReplacingIntermediates;
- (void)testNotCreatingIntermediates;

@end
