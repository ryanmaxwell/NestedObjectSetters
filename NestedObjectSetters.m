//
//  NestedObjectSetters.m
//  NestedObjectSetters
//
//  Created by Ryan Maxwell on 3/08/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import "NestedObjectSetters.h"

static NSString *const KeyPathDelimiter = @".";

@implementation NestedObjectSetters

+ (void)setNestedObject:(id)object onObject:(id)target forKeyPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates {
    
    if (!keyPath) {
        [NSException raise:NSInvalidArgumentException format:nil];
        return;
    }
    
    if ([keyPath rangeOfString:KeyPathDelimiter].location == NSNotFound) {
        [target setObject:object forKey:keyPath];
        return;
    }
    
    NSArray *pathComponents = [keyPath componentsSeparatedByString:KeyPathDelimiter];
    
    NSString *rootKey = [pathComponents objectAtIndex:0];
    
    NSMutableDictionary *replacementDict = [NSMutableDictionary dictionary];
    
    id previousObject = target;
    NSMutableDictionary *previousReplacement = replacementDict;
    
    BOOL reachedDictionaryLeaf = NO;
    
    for (NSString *path in pathComponents) {
        id currentObject = (reachedDictionaryLeaf) ? nil : [previousObject objectForKey:path];
        
        if (currentObject == nil) {
            reachedDictionaryLeaf = YES;
            
            if (createIntermediates) {
                NSMutableDictionary *newNode = [NSMutableDictionary dictionary];
                [previousReplacement setObject:newNode forKey:path];
                previousReplacement = newNode;
            } else {
                return;
            }
        } else if ([currentObject isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *newNode = [currentObject mutableCopy];
            [previousReplacement setObject:newNode forKey:path];
            previousReplacement = newNode;
        } else {
            reachedDictionaryLeaf = YES;
            
            if (replaceIntermediates) {
                NSMutableDictionary *newNode = [NSMutableDictionary dictionary];
                [previousReplacement setObject:newNode forKey:path];
                previousReplacement = newNode;
            } else {
                return;
            }
        }
        
        previousObject = currentObject;
    }
    
    [replacementDict setValue:object forKeyPath:keyPath];
    
    [target setObject:[replacementDict objectForKey:rootKey] forKey:rootKey];
}

@end

@implementation NSMutableDictionary (NestedObjectSetters)

#if NESTEDOBJECTSETTERS_NO_PREFIX

- (void)setNestedObject:(id)object forKeyPath:(NSString *)keyPath {
    [self setNestedObject:object forKeyPath:keyPath createIntermediateDictionaries:YES replaceIntermediateObjects:YES];
}

- (void)setNestedObject:(id)object forKeyPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates {
    [NestedObjectSetters setNestedObject:object
                                onObject:self
                              forKeyPath:keyPath
          createIntermediateDictionaries:createIntermediates
              replaceIntermediateObjects:replaceIntermediates];
}
    
#else
    
- (void)nos_setNestedObject:(id)object forKeyPath:(NSString *)keyPath {
    [self nos_setNestedObject:object forKeyPath:keyPath createIntermediateDictionaries:YES replaceIntermediateObjects:YES];
}

- (void)nos_setNestedObject:(id)object forKeyPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates {
    [NestedObjectSetters setNestedObject:object
                                onObject:self
                              forKeyPath:keyPath
          createIntermediateDictionaries:createIntermediates
              replaceIntermediateObjects:replaceIntermediates];
}

#endif

@end

@implementation NSUserDefaults (NestedObjectSetters)

#if NESTEDOBJECTSETTERS_NO_PREFIX

- (void)setNestedObject:(id)object forKeyPath:(NSString *)keyPath {
    [self setNestedObject:object forKeyPath:keyPath createIntermediateDictionaries:YES replaceIntermediateObjects:YES];
}

- (void)setNestedObject:(id)object forKeyPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates {
    [NestedObjectSetters setNestedObject:object
                                onObject:self
                              forKeyPath:keyPath
          createIntermediateDictionaries:createIntermediates
              replaceIntermediateObjects:replaceIntermediates];
}

#else

- (void)nos_setNestedObject:(id)object forKeyPath:(NSString *)keyPath {
    [self nos_setNestedObject:object forKeyPath:keyPath createIntermediateDictionaries:YES replaceIntermediateObjects:YES];
}

- (void)nos_setNestedObject:(id)object forKeyPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates {
    [NestedObjectSetters setNestedObject:object
                                onObject:self
                              forKeyPath:keyPath
          createIntermediateDictionaries:createIntermediates
              replaceIntermediateObjects:replaceIntermediates];
}

#endif

@end
