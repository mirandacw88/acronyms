//
//  Client.m
//  acronyms
//
//  Created by Cesar Miranda on 4/17/17.
//  Copyright © 2017 Cesar Miranda. All rights reserved.
//

#import "Client.h"

@implementation Client{
    NSURLSession * session;
    NSURLSessionDataTask * task;
    NSString * baseUrl;
}

#pragma mark - Private Variables

NSString * environment = Nil;


#pragma mark Strings
NSString * const P_LIST_DEV_KEY                 = @"Development";
NSString * const P_LIST_PROD_KEY                = @"Production";

#pragma mark Status Codes
int STATUS_CODE_200 = 200;



#pragma mark - Constructor

- (Client *) init
{
    
    Client * instance = [super init];
    
    // Checks for the current enviroment and set the appropriate endpoint.
    // NOTE: Currently all enviroments point to the same server.
    // If in the future a production server is created, the Production
    // property in the plist must be re-configured.
    
    #ifdef DEBUG
        environment = P_LIST_DEV_KEY;
    #else
        environment = P_LIST_PROD_KEY;
    #endif
    
    // Sets the server endpoint based on the current enviroment
    baseUrl = [[NSBundle mainBundle] objectForInfoDictionaryKey:environment];
    
    NSLog(@"\n Enviroment: %@", environment);
    NSLog(@"\n Server URL: %@", baseUrl);
    
    // Initialize the Session confirguration
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    return instance;
    
}

#pragma mark - Static Methods

// Methods created a singleton object of Client
+ (instancetype) sharedClient
{
    
    static Client * _client;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        _client = [[Client alloc] init];
    });
    
    
    return _client;
    
}

#pragma mark - Private Methods

-(void) logError:(NSError *) error{

    NSLog(@"Domain: %@", error.domain);
    NSLog(@"Error Code: %ld", error.code);
    NSLog(@"Description: %@", [error localizedDescription]);
    

}

#pragma mark - Public Methods


// Method abstracts NSURLSession
-(void) requestWithPath:(NSString * _Nonnull)path
                        success:(LBDataSuccessHandler _Nonnull)onSuccess{

    NSString * completePath = [baseUrl stringByAppendingString:path];
    
    
    task = [session dataTaskWithURL:[NSURL URLWithString:completePath]
                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

                            if(data == nil){

                                NSLog(@"Error: No data was retuned");
                                [self logError:error];
                                
                            }else{
                                
                                //Retrieve status code
                                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                int statusCode = (int)[httpResponse statusCode];
                                NSLog(@"response status code: %d", statusCode);
                                
                                if(statusCode == STATUS_CODE_200){
                                    
                                    NSError * error;
                                    NSMutableDictionary * json = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:kNilOptions
                                                                                       error:&error];
                                    if(json == nil){
                                    
                                        NSLog(@"No Valid JSON data was returned");
                                        [self logError:error];
                                    
                                    }else{
                           
                                        onSuccess(json);
                                    
                                    }
                                }else{
                                    
                                    NSLog(@"Bad Status Code Returned");
                                    [self logError:error];
                                    
                                }
                                
                            }
    }];
    
    // Send the request
    [task resume];
  
    
}

#pragma mark - Public Methods




@end
