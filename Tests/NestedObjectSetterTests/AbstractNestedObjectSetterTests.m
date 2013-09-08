//
//  AbstractNestedObjectSetterTests.m
//  NestedObjectSetters
//
//  Created by Ryan Maxwell on 4/08/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import "AbstractNestedObjectSetterTests.h"

NSString *const TestObjectKeyA      = @"a";
NSString *const TestObjectKeyB      = @"b";
NSString *const TestObjectKeyPath   = @"a.b";
NSString *const TestObjectEmptyKey  = @"";

@implementation AbstractNestedObjectSetterTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    self.testObject = nil;
    
    [super tearDown];
}

#pragma mark -

- (void)testSetNestedStringValue {
    NSString *const stringValue = @"value";
    
    XCTAssertNil([self.testObject objectForKey:TestObjectKeyA], @"Value for key '%@' should be nil", TestObjectKeyA);
    
    [self.testObject setObject:stringValue forKeyPath:TestObjectKeyPath];
    
    XCTAssertTrue([[self.testObject valueForKeyPath:TestObjectKeyPath] isEqualToString:stringValue], @"String value for key path '%@' should be '%@'", TestObjectKeyPath, stringValue);
}

- (void)testSetNestedBoolValue {
    BOOL const boolValue = YES;
    
    XCTAssertNil([self.testObject objectForKey:TestObjectKeyA], @"Value for key '%@' should be nil", TestObjectKeyA);

    [self.testObject setObject:@(boolValue) forKeyPath:TestObjectKeyPath];

    XCTAssertTrue([[self.testObject valueForKeyPath:TestObjectKeyPath] boolValue], @"Bool value for key path '%@' should be %d", TestObjectKeyPath, boolValue);
}

- (void)testOverwriteExistingNestedStringValue {
    NSString *const stringValue1 = @"value1";
    NSString *const stringValue2 = @"value2";
    
    XCTAssertNil([self.testObject objectForKey:TestObjectKeyA], @"Value for key '%@' should be nil", TestObjectKeyA);
    
    [self.testObject setObject:@{TestObjectKeyB: stringValue1} forKey:TestObjectKeyA];
    
    XCTAssertTrue([[[self.testObject objectForKey:TestObjectKeyA] objectForKey:TestObjectKeyB] isEqualToString:stringValue1], @"String value for key path '%@' should be '%@'", TestObjectKeyPath, stringValue1);

    [self.testObject setObject:stringValue2 forKeyPath:TestObjectKeyPath];

    XCTAssertTrue([[[self.testObject objectForKey:TestObjectKeyA] objectForKey:TestObjectKeyB] isEqualToString:stringValue2], @"String value for key path '%@' should be '%@'", TestObjectKeyPath, stringValue2);
}

- (void)testSettingExistingNestedStringValueNil {
    NSString *const stringValue = @"value";
    
    XCTAssertNil([self.testObject objectForKey:TestObjectKeyA], @"Value for key '%@' should be nil", TestObjectKeyA);

    [self.testObject setObject:stringValue forKeyPath:TestObjectKeyPath];

    XCTAssertTrue([[self.testObject valueForKeyPath:TestObjectKeyPath] isEqualToString:stringValue], @"String value for key path '%@' should be '%@'", TestObjectKeyPath, stringValue);

    [self.testObject setObject:nil forKeyPath:TestObjectKeyPath];

    XCTAssertNotNil([self.testObject objectForKey:TestObjectKeyA], @"Dictionary value for key '%@' should exist", TestObjectKeyA);
    XCTAssertNil([self.testObject valueForKeyPath:TestObjectKeyPath], @"Value for key path '%@' should be nil", TestObjectKeyPath);
}

- (void)testNilKeyPathThrowsException {
    NSString *const stringValue = @"value";
    
    XCTAssertThrowsSpecificNamed([self.testObject setObject:stringValue forKeyPath:nil], NSException, NSInvalidArgumentException, @"Setting a nil key path should throw an NSInvalidArgumentException.");
}

- (void)testEmptyKeyPathSetsValue {
    NSString *const stringValue = @"value";
    
    XCTAssertNil([self.testObject objectForKey:TestObjectEmptyKey], @"Value for key '%@' should be nil", TestObjectEmptyKey);
    
    [self.testObject setObject:stringValue forKey:TestObjectEmptyKey];
    
    XCTAssertTrue([[self.testObject objectForKey:TestObjectEmptyKey] isEqualToString:stringValue], @"String value for key '%@' should be '%@'", TestObjectEmptyKey, stringValue);
}

- (void)testNotReplacingIntermediates {
    NSString *const stringValue = @"value";
    
    XCTAssertNil([self.testObject objectForKey:TestObjectKeyA], @"Value for key '%@' should be nil", TestObjectKeyA);

    [self.testObject setObject:stringValue forKey:TestObjectKeyA];
    
    XCTAssertTrue([self.testObject objectForKey:TestObjectKeyA], @"String value for key '%@' should be '%@'", TestObjectKeyA, stringValue);

    [self.testObject setObject:stringValue forKeyPath:TestObjectKeyPath createIntermediateDictionaries:YES replaceIntermediateObjects:NO];

    XCTAssertTrue([[self.testObject objectForKey:TestObjectKeyA] isEqualToString:stringValue], @"String value for key '%@' should be '%@'", TestObjectKeyA, stringValue);
}

- (void)testNotCreatingIntermediates {
    NSString *const stringValue = @"value";
    
    XCTAssertNil([self.testObject objectForKey:TestObjectKeyA], @"Value for key '%@' should be nil", TestObjectKeyA);

    [self.testObject setObject:stringValue forKeyPath:TestObjectKeyPath createIntermediateDictionaries:NO replaceIntermediateObjects:YES];

    XCTAssertNil([self.testObject valueForKeyPath:TestObjectKeyPath], @"Value for key path '%@' should be nil", TestObjectKeyPath);
}

@end
