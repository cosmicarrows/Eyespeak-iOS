//
//  TEPreferencesProxy.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/22/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TEPreferencesProxyDelegate <NSObject>
@optional
- (void)preferencesLoaded:(BOOL)success withMessage:(NSString *)message;
- (void)preferencesUpdated:(BOOL)success withMessage:(NSString *)message;
- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error;
@end

@interface TEPreferencesProxy : TEProxyBase  <RKObjectLoaderDelegate>


@property (nonatomic, weak) id<TEPreferencesProxyDelegate> delegate;


- (void)loadPreferencesForType:(NSString *)type;
- (void)updatePreferences:(NSString *)preferences forType:(NSString *)type;
- (void)stopProcessing;

@end




