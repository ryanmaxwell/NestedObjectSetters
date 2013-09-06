//
//  main.m
//  MacFoundationApp
//
//  Created by Ryan Maxwell on 7/09/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NestedObjectSetters.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"baz" forKeyPath:@"foo.bar"];
        NSLog(@"%@", dict[@"foo"][@"bar"]);
    }
    return 0;
}

