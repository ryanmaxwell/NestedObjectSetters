//
//  AbstractNestedObjectSetterTests.m
//  NestedObjectSetters
//
//  Created by Ryan Maxwell on 4/08/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import "AbstractNestedObjectSetterTests.h"

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
    NSString *const keyA = @"a";
    NSString *const keyB = @"b";
    
    NSString *const nestedKeyPath = [NSString stringWithFormat:@"%@.%@", keyA, keyB];
    NSString *const stringValue = @"value";
    
    [self.testObject setNestedObject:stringValue forKeyPath:nestedKeyPath];
    
    XCTAssertTrue([[[self.testObject objectForKey:keyA] objectForKey:keyB] isEqualToString:stringValue], @"String value for key path '%@' should be '%@'", nestedKeyPath, stringValue);
}

- (void)testSetNestedBoolValue {
    NSString *const keyA = @"a";
    NSString *const keyB = @"b";

    NSString *const nestedKeyPath = [NSString stringWithFormat:@"%@.%@", keyA, keyB];

    BOOL const boolValue = YES;

    [self.testObject setNestedObject:@(boolValue) forKeyPath:nestedKeyPath];

    XCTAssertTrue([[[self.testObject objectForKey:keyA] objectForKey:keyB] boolValue], @"Bool value for key path '%@' should be %d", nestedKeyPath, boolValue);
}

- (void)testOverwriteExistingNestedStringValue {
    NSString *const keyA = @"a";
    NSString *const keyB = @"b";

    NSString *const stringValue1 = @"value1";
    NSString *const stringValue2 = @"value2";
    
    NSString *const nestedKeyPath = [NSString stringWithFormat:@"%@.%@", keyA, keyB];
    
    [self.testObject setObject:@{keyB: stringValue1} forKey:keyA];
    
    XCTAssertTrue([[[self.testObject objectForKey:keyA] objectForKey:keyB] isEqualToString:stringValue1], @"String value for key path '%@' should be '%@'", nestedKeyPath, stringValue1);

    [self.testObject setNestedObject:stringValue2 forKeyPath:nestedKeyPath];

    XCTAssertTrue([[[self.testObject objectForKey:keyA] objectForKey:keyB] isEqualToString:stringValue2], @"String value for key path '%@' should be '%@'", nestedKeyPath, stringValue2);
}

- (void)testSettingExistingNestedStringValueNil {
    NSString *const keyA = @"a";
    NSString *const keyB = @"b";

    NSString *const stringValue = @"value";

    NSString *const nestedKeyPath = [NSString stringWithFormat:@"%@.%@", keyA, keyB];

    [self.testObject setNestedObject:stringValue forKeyPath:nestedKeyPath];

    XCTAssertTrue([[[self.testObject objectForKey:keyA] objectForKey:keyB] isEqualToString:stringValue], @"String value for key path '%@' should be '%@'", nestedKeyPath, stringValue);

    [self.testObject setNestedObject:nil forKeyPath:nestedKeyPath];

    XCTAssertNotNil([self.testObject objectForKey:keyA], @"Dictionary value for key '%@' should exist", keyA);
    XCTAssertNil([[self.testObject objectForKey:keyA] objectForKey:keyB], @"Value for key path '%@' should be nil", nestedKeyPath);
}

- (void)testNilKeyPathThrowsException {
    NSString *const stringValue = @"value";
    
    XCTAssertThrowsSpecificNamed([self.testObject setNestedObject:stringValue forKeyPath:nil], NSException, NSInvalidArgumentException, @"Setting a nil key path should throw an NSInvalidArgumentException.");
}

- (void)testEmptyKeyPathSetsValue {
    NSString *const key = @"";
    NSString *const stringValue = @"value";
    
    [self.testObject setObject:stringValue forKey:key];
    
    XCTAssertTrue([[self.testObject objectForKey:key] isEqualToString:stringValue], @"String value for key '%@' should be '%@'", key, stringValue);
}

- (void)testNotReplacingIntermediates {
    NSString *const keyA = @"a";
    NSString *const keyB = @"b";

    NSString *const stringValue = @"value";

    [self.testObject setObject:stringValue forKey:keyA];
    
    XCTAssertTrue([self.testObject objectForKey:keyA], @"String value for key '%@' should be '%@'", keyA, stringValue);

    NSString *const nestedKeyPath = [NSString stringWithFormat:@"%@.%@", keyA, keyB];
    [self.testObject setNestedObject:stringValue forKeyPath:nestedKeyPath createIntermediateDictionaries:YES replaceIntermediateObjects:NO];

    XCTAssertTrue([[self.testObject objectForKey:keyA] isEqualToString:stringValue], @"String value for key '%@' should be '%@'", keyA, stringValue);
}

- (void)testNotCreatingIntermediates {
    NSString *const keyA = @"a";
    NSString *const keyB = @"b";

    NSString *const stringValue = @"value";

    NSString *const nestedKeyPath = [NSString stringWithFormat:@"%@.%@", keyA, keyB];
    [self.testObject setNestedObject:stringValue forKeyPath:nestedKeyPath createIntermediateDictionaries:NO replaceIntermediateObjects:YES];

    XCTAssertNil([[self.testObject objectForKey:keyA] objectForKey:keyB], @"Value for key path '%@' should be nil", nestedKeyPath);
}

@end
