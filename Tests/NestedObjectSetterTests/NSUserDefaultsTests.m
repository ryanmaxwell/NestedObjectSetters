//
//  NSUserDefaultsTests.m
//  NestedObjectSetters
//
//  Created by Ryan Maxwell on 3/08/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import "AbstractNestedObjectSetterTests.h"

@interface NSUserDefaultsTests : AbstractNestedObjectSetterTests

@end

@implementation NSUserDefaultsTests

- (void)setUp {
    [super setUp];
    
    [NSUserDefaults resetStandardUserDefaults];
    
    self.testObject = [NSUserDefaults standardUserDefaults];
    
    /* sometimes initializing with values in the defaults - even though we called resetStandardUserDefaults above! */
    [self.testObject removeObjectForKey:TestObjectKeyA];
    [self.testObject removeObjectForKey:TestObjectEmptyKey];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark -

- (void)testSetNestedStringValue {
    [super testSetNestedStringValue];
}

- (void)testSetNestedBoolValue {
    [super testSetNestedBoolValue];
}

- (void)testOverwriteExistingNestedStringValue {
    [super testOverwriteExistingNestedStringValue];
}

- (void)testSettingExistingNestedStringValueNil {
    [super testSettingExistingNestedStringValueNil];
}

- (void)testNilKeyPathThrowsException {
    [super testEmptyKeyPathSetsValue];
}

- (void)testEmptyKeyPathSetsValue {
    [super testEmptyKeyPathSetsValue];
}

- (void)testNotReplacingIntermediates {
    [super testNotReplacingIntermediates];
}

- (void)testNotCreatingIntermediates {
    [super testNotCreatingIntermediates];
}

@end
