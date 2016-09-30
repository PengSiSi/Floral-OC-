//
//  WHOrderedDictionary.m
//  OrderedDictionaryByMe
//
//  Created by PengSi on 16/5/31.
//  Copyright © 2016年 PengSi. All rights reserved.
//

#import "WHOrderedDictionary.h"

NSString *DescriptionForObject(NSObject *object, id locale, NSUInteger indent)
{
    NSString *objectString;
    if ([object isKindOfClass:[NSString class]])
    {
        objectString = (NSString *)object;
    }
    else if ([object respondsToSelector:@selector(descriptionWithLocale:indent:)])
    {
        objectString = [(NSDictionary *)object descriptionWithLocale:locale indent:indent];
    }
    else if ([object respondsToSelector:@selector(descriptionWithLocale:)])
    {
        objectString = [(NSSet *)object descriptionWithLocale:locale];
    }
    else
    {
        objectString = [object description];
    }
    return objectString;
}

@implementation WHOrderedDictionary

-(id)init
{
    self = [super init];
    
    
    
    return self;
}

- (id)initWithCapacity:(NSUInteger)capacity
{
    self = [super init];
    if (self != nil)
    {
        dictionary = [[NSMutableDictionary alloc] initWithCapacity:capacity];
        array = [[NSMutableArray alloc] initWithCapacity:capacity];
    }
    return self;
}


- (id)copy
{
    return [self mutableCopy];
}

- (void)setObject:(id)anObject forKey:(id)aKey
{
    if (![dictionary objectForKey:aKey])
    {
        [array addObject:aKey];
    }
    [dictionary setObject:anObject forKey:aKey];
}

- (void)removeObjectForKey:(id)aKey
{
    [dictionary removeObjectForKey:aKey];
    [array removeObject:aKey];
}

- (NSUInteger)count
{
    return [dictionary count];
}

- (id)objectForKey:(id)aKey
{
    return [dictionary objectForKey:aKey];
}

- (NSEnumerator *)keyEnumerator
{
    return [array objectEnumerator];
}

- (NSEnumerator *)reverseKeyEnumerator
{
    return [array reverseObjectEnumerator];
}

- (void)insertObject:(id)anObject forKey:(id)aKey atIndex:(NSUInteger)anIndex
{
    if (![dictionary objectForKey:aKey])
    {
        [self removeObjectForKey:aKey];
    }
    [array insertObject:aKey atIndex:anIndex];
    [dictionary setObject:anObject forKey:aKey];
}

- (id)keyAtIndex:(NSUInteger)anIndex
{
    return [array objectAtIndex:anIndex];
}

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *indentString = [NSMutableString string];
    NSUInteger i, count = level;
    for (i = 0; i < count; i++)
    {
        [indentString appendFormat:@"    "];
    }
    
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"%@{\n", indentString];
    for (NSObject *key in self)
    {
        [description appendFormat:@"%@    %@ = %@;\n",
         indentString,
         DescriptionForObject(key, locale, level),
         DescriptionForObject([self objectForKey:key], locale, level)];
    }
    [description appendFormat:@"%@}\n", indentString];
    return description;
}


- (void)dealloc
{

}

@end
