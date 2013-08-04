NestedObjectSetters
===================

Categories on NSMutableDictionary and NSUserDefauts that enable setting nested objects via key paths.

The following two instance methods are added to `NSMutableDictionary` and `NSUserDefaults`

```objc
- (void)setNestedObject:(id)object forKeyPath:(NSString *)keyPath;

- (void)setNestedObject:(id)object forKeyPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates;
```

The first method is a convenience method for the second – passing `YES` as both parameters – as that is likely the most wanted behavior.

## Category Method Prefix

The methods are prefixed with `nos_` by default, to avoid any namespace collisions.

To use the methods without the prefix, add `#define NESTEDOBJECTSETTERS_NO_PREFIX 1` to your project’s Prefix file, or `NESTEDOBJECTSETTERS_NO_PREFIX=1` to your Target’s Build Settings in the Preprocessor Macros section.

## Project Requirements

* This Xcode project uses the XCTest framework and so requires >= Xcode 5

## Category Requirements

The categories are compatible with all versions of Mac OS X and iOS.

## Usage

Add `NestedObjectSetters.h/m` to your project. Cocoapod coming soon.
