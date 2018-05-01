//
//  TETourProxy.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/21/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEProxyBase.h"


@protocol TETourProxyDelegate <NSObject>
@optional
- (void)tourAdded:(BOOL)success withID:(NSInteger)tourID withMessage:(NSString *)message;
- (void)buildingAddedToTour:(BOOL)success withMessage:(NSString *)message;
- (void)buildingRemovedFromTour:(BOOL)success withMessage:(NSString *)message;
- (void)memberAddedToTour:(BOOL)success withMessage:(NSString *)message;
- (void)toursLoaded:(BOOL)success withMessage:(NSString *)message;
- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error;
@end


@interface TETourProxy : TEProxyBase <RKObjectLoaderDelegate>

@property (nonatomic, weak) id<TETourProxyDelegate> delegate;
@property (nonatomic, strong) NSArray *tours;


- (void)addTour:(NSString *)tourName forType:(NSString *)tourType;
- (void)addBuilding:(NSInteger)buildingID toTour:(NSInteger)tourID;
- (void)removeBuilding:(NSInteger)buildingID fromTour:(NSInteger)tourID;
- (void)addMember:(NSString *)memberID toTour:(NSInteger)tourID;
- (void)loadCreatedTours;
- (void)loadInvitedTours;
- (void)stopProcessing;

@end


