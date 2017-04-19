//
//  AcronymsModel.h
//  acronyms
//
//  Created by Cesar Miranda on 4/17/17.
//  Copyright © 2017 Cesar Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Client.h"

@interface AcronymsModel : NSObject

@property (strong, nonatomic) NSString * _Nullable fullDescription;

-(void) definitionsForAcronym:(NSString *_Nullable)acronym withSuccess:(LBDataSuccessHandler _Nonnull)onSuccess;

@end
