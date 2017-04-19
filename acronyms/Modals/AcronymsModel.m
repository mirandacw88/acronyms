//
//  AcronymsModel.m
//  acronyms
//
//  Created by Cesar Miranda on 4/17/17.
//  Copyright © 2017 Cesar Miranda. All rights reserved.
//

#import "AcronymsModel.h"
#import "AcronymFactory.h"

@implementation AcronymsModel{

}

# pragma mark - Private Methods

-(void) definitionsForAcronym:(NSString *)acronym withSuccess:(LBDataSuccessHandler _Nonnull)onSuccess{

    Client * client = [[Client alloc] init];
    NSString * path =  @"/software/acromine/dictionary.py?sf=";
    
    [client requestWithPath:[NSString stringWithFormat:@"%@%@", path, acronym] success:^(id _Nonnull array) {
       
        if([array count] > 0){
            NSDictionary * arrayData = array[0];
            NSArray * data = [AcronymFactory acronymForArrayData: arrayData[@"lfs"]];
            onSuccess(data);
        }else{
            onSuccess(@[]);
        }
    }];
    
    
}

@end
