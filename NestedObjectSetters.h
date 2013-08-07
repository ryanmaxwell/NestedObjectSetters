//
//  NestedObjectSetters.h
//  NestedObjectSetters
//
//  Created by Ryan Maxwell on 3/08/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NestedObjectSetters : NSObject

+ (void)setObject:(id)object onObject:(id)target forKeyPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates;

@end

@interface NSMutableDictionary (NestedObjectSetters)

#if NESTEDOBJECTSETTERS_NO_PREFIX

/**
 *	Set an object for the property identified by a given key path to a given value.
 *
 *	@param	object                  The object for the property identified by _keyPath_.
 *	@param	keyPath                 A key path of the form _relationship.property_ (with one or more relationships): for example “department.name” or “department.manager.lastName.”
 */
- (void)setObject:(id)object forKeyPath:(NSString *)keyPath;

/**
 *	Set an object for the property identified by a given key path to a given value, with optional parameters to control creation and replacement of intermediate objects.
 *
 *	@param	object                  The object for the property identified by _keyPath_.
 *	@param	keyPath                 A key path of the form _relationship.property_ (with one or more relationships): for example “department.name” or “department.manager.lastName.”
 *	@param	createIntermediates     Intermediate dictionaries defined within the key path that do not currently exist in the receiver are created.
 *	@param	replaceIntermediates    Intermediate objects encountered in the key path that are not a direct subclass of `NSDictionary` are replaced.
 */
- (void)setObject:(id)object forKeyPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates;

#else

- (void)nos_setObject:(id)object forKeyPath:(NSString *)keyPath;

- (void)nos_setObject:(id)object forKeyPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates;

#endif

@end

@interface NSUserDefaults (NestedObjectSetters)

#if NESTEDOBJECTSETTERS_NO_PREFIX

/**
 *	Set an object for the property identified by a given key path to a given value.
 *
 *	@param	object                  The object for the property identified by _keyPath_.
 *	@param	keyPath                 A key path of the form _relationship.property_ (with one or more relationships): for example “department.name” or “department.manager.lastName.”
 */
- (void)setObject:(id)object forKeyPath:(NSString *)keyPath;

/**
 *	Set an object for the property identified by a given key path to a given value, with optional parameters to control creation and replacement of intermediate objects.
 *
 *	@param	object                  The object for the property identified by _keyPath_.
 *	@param	keyPath                 A key path of the form _relationship.property_ (with one or more relationships): for example “department.name” or “department.manager.lastName.”
 *	@param	createIntermediates     Intermediate dictionaries defined within the key path that do not currently exist in the receiver are created.
 *	@param	replaceIntermediates    Intermediate objects encountered in the key path that are not a direct subclass of `NSDictionary` are replaced.
 */
- (void)setObject:(id)object forKeyPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates;

#else

- (void)nos_setObject:(id)object forKeyPath:(NSString *)keyPath;

- (void)nos_setObject:(id)object forKeyPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates;

#endif

@end
