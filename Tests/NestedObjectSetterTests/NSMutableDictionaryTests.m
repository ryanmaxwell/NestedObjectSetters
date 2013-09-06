//
//  NSMutableDictionaryTests.m
//  NestedObjectSetters
//
//  Created by Ryan Maxwell on 3/08/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import "AbstractNestedObjectSetterTests.h"

@interface NSMutableDictionaryTests : AbstractNestedObjectSetterTests

@end

@implementation NSMutableDictionaryTests

- (void)setUp {
    [super setUp];
    
    self.testObject = [[NSMutableDictionary alloc] init];
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
