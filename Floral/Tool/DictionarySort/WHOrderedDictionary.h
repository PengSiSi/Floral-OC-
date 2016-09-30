//
//  WHOrderedDictionary.h
//  OrderedDictionaryByMe
//
//  Created by PengSi on 16/5/31.
//  Copyright © 2016年 PengSi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHOrderedDictionary : NSMutableDictionary

{
    NSMutableDictionary *dictionary;
    NSMutableArray *array;
}

- (void)insertObject:(id)anObject forKey:(id)aKey atIndex:(NSUInteger)anIndex;
- (id)keyAtIndex:(NSUInteger)anIndex;
- (NSEnumerator *)reverseKeyEnumerator;


@end
