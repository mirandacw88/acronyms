//
//  AcronymFactory.h
//  acronyms
//
//  Created by Cesar Miranda on 4/17/17.
//  Copyright © 2017 Cesar Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AcronymsModel.h"

@interface AcronymFactory : NSObject

+ (AcronymsModel *) imageForData:(NSDictionary *)data;
+ (NSArray *)acronymForArrayData:(NSArray *)data;

@end
