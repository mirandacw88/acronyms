//
//  Client.h
//  acronyms
//
//  Created by Cesar Miranda on 4/17/17.
//  Copyright © 2017 Cesar Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Blocks

//////////////////////////////////////////////////////////////////////////////////////////
// Blocks are defined to consolidate success and failure responses for all method types.
//////////////////////////////////////////////////////////////////////////////////////////

typedef void (^LBAfSuccessHandler)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
typedef void (^LBAfErrorHandler)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);

////////////////////////////////////////////////////////////////////////////////////
// Abstracted blocks simplifies the data that will be returned to the model layer
////////////////////////////////////////////////////////////////////////////////////

typedef void (^LBsimpleSuccessHandler)(NSMutableDictionary * _Nonnull dict);
typedef void (^LBsimpleErrorHandler)(NSMutableDictionary * _Nonnull dict);
typedef void (^LBDataSuccessHandler)(id _Nullable);
typedef void (^LBDataErrorHandler)(NSArray * _Nonnull array);

@interface Client : NSObject

-(void) requestWithPath:(NSString * _Nonnull)path
                success:(LBDataSuccessHandler _Nonnull)onSuccess;

@end
