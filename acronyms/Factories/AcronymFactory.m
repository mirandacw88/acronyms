//
//  AcronymFactory.m
//  acronyms
//
//  Created by Cesar Miranda on 4/17/17.
//  Copyright © 2017 Cesar Miranda. All rights reserved.
//

#import "AcronymFactory.h"


@implementation AcronymFactory

const NSString * FULL_DESCRIPTION_KEY = @"lf";

// Creates a single drone object from a dictionary of key value pairs
+ (AcronymsModel *) imageForData:(NSDictionary *)data{
    
    AcronymsModel * acronynModel = [[AcronymsModel alloc] init];
    
    if(data[FULL_DESCRIPTION_KEY]){
        acronynModel.fullDescription = data[FULL_DESCRIPTION_KEY];
    }
    
    return acronynModel;
    
}

+ (NSArray *)acronymForArrayData:(NSArray *)data{
    
    NSMutableArray *returnArray = [NSMutableArray array];
    
    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [returnArray addObject:[self imageForData:obj]];
    }];
    
    return [returnArray copy];
    
}

@end
