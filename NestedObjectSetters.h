//
//  NestedObjectSetters.h
//  NestedObjectSetters
//
//  Created by Ryan Maxwell on 3/08/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NestedObjectSetters : NSObject

+ (void)setNestedObject:(id)object onObject:(id)target forKeyPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates;

@end

@interface NSMutableDictionary (NestedObjectSetters)

#if NESTEDOBJECTSETTERS_NO_PREFIX

- (void)setNestedObject:(id)object forKeyPath:(NSString *)keyPath;

- (void)setNestedObject:(id)object forKeyPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates;

#else

- (void)nos_setNestedObject:(id)object forKeyPath:(NSString *)keyPath;

- (void)nos_setNestedObject:(id)object forKeyPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates;

#endif

@end

@interface NSUserDefaults (NestedObjectSetters)

#if NESTEDOBJECTSETTERS_NO_PREFIX

- (void)setNestedObject:(id)object forKeyPath:(NSString *)keyPath;

- (void)setNestedObject:(id)object forKeyPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates;

#else

- (void)nos_setNestedObject:(id)object forKeyPath:(NSString *)keyPath;

- (void)nos_setNestedObject:(id)object forKeyPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates;

#endif

@end
