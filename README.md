NestedObjectSetters
===================

Categories on NSMutableDictionary and NSUserDefaults that enable setting nested objects via key paths.

## Purpose

I often want to set a value multiple levels deep in a mutable dictionary. Unfortunately this will fail if the nested mutable dictionary does not exist. The following statement outputs null:

```objc
NSMutableDictionary *dict = [NSMutableDictionary dictionary];
dict[@"a"][@"b"] = @"foo";

NSLog(@"%@", dict[@"a"][@"b"]);
```

Slightly rewriting the statement makes it more obvious:

```objc
[[dict objectForKey:@"a"] setObject:@"foo" forKey:@"b];
```

The first `objectForKey:` method returns nil, and the subsequent `setObject:ForKey:` fails silently.

Another common case is when I make a mutable copy of a dictionary - any dictionaries contained within the dictionary still remain immutable, which leads to annoying, error-prone code like this to simply set a new value at anything other than the root level:

```objc
NSDictionary *colorSets = @{
	@"ColorsOfTheRainbow": @{
		@"Red": @"#F00",
		@"Yellow": @"#FF0",
		@"Pink": @"#F0F",
		@"Green": @"#0F0",
		@"Purple": @"#8000FF",
		@"Orange": @"#F80"
	}
};

/* Create mutable copy of dictionary */
NSMutableDictionary *newColorSets = [colorSets mutableCopy];

/* Get second-level dictionary */
NSDictionary *currentColorsOfTheRainbow = [colorSets objectForKey:@"ColorsOfTheRainbow"];

/* Check that the second level dictionary existed. If so - create a mutable copy; if not - create a new mutable dictionary to use */
NSMutableDictionary *newColorsOfTheRainbow = (currentColorsOfTheRainbow) ? [currentColorsOfTheRainbow mutableCopy] : [NSMutableDictionary dictionary];

/* Set the value in the new dictionary */
[newColorsOfTheRainbow setObject:@"#00F" forKey:@"Blue"];

/* Set the second-level dictionary back into the mutable dictionary */
[newColorSets setObject:newColorsOfTheRainbow forKey:@"ColorsOfTheRainbow"];

```

## Category Interface

The following two instance methods are added to `NSMutableDictionary` and `NSUserDefaults`

```objc
- (void)setObject:(id)object forKeyPath:(NSString *)keyPath;

- (void)setObject:(id)object
       forKeyPath:(NSString *)keyPath
createIntermediateDictionaries:(BOOL)createIntermediates
    replaceIntermediateObjects:(BOOL)replaceIntermediates;
```

The first method is a convenience method for the second – passing `YES` as both parameters – as that is likely the most wanted behavior.

* `createIntermediateDictionaries` creates any necessary dictionaries that do not exist while traversing the key path.
* `replaceIntermediateObjects` replaces any returned objects in the key path that are not a subclass of an NSDictionary.

The above examples could simply be achieved with:

```objc
[dict setObject:@"foo" forKeyPath:@"a.b"];
```
and

```objc
[newColorSets setObject:@"#00F" forKeyPath:@"ColorsOfTheRainbow.Blue"];
```

## Category Method Prefix

The methods are prefixed with `nos_` by default, to avoid any namespace collisions.

To use the methods without the prefix, add `#define NESTEDOBJECTSETTERS_NO_PREFIX 1` to your project’s Prefix file, or `NESTEDOBJECTSETTERS_NO_PREFIX=1` to your Target’s Build Settings in the Preprocessor Macros section.

## Category Requirements

The categories are compatible with all versions of Mac OS X and iOS.

## Project Requirements

* This Xcode project uses the XCTest framework and so requires >= Xcode 5

## Usage

Add `NestedObjectSetters.h/m` to your project. Cocoapod coming soon.
