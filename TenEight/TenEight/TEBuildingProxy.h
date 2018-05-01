//
//  TEBuildingProxy.h
//  TenEight
//
//  Created by Brad Wiederholt on 9/21/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TEBuildingProxyDelegate <NSObject>
@optional
- (void)buildingsLoaded:(BOOL)success withMessage:(NSString *)message;
- (void)buildingDetailsLoaded:(BOOL)success withID:(NSInteger)buildingID withMessage:(NSString *)message;
- (void)buildingAdded:(BOOL)sucess withID:(NSInteger)buildingID withMessage:(NSString *)message;
- (void)buildingUpdated:(BOOL)sucess withID:(NSInteger)buildingID withMessage:(NSString *)message;
- (void)buildingRentalInfoEdited:(BOOL)success withMessage:(NSString *)message;
- (void)buildingRentalInfoLoaded:(BOOL)success withMessage:(NSString *)message;
- (void)buildingRated:(BOOL)success withID:(NSInteger)buildingID withMessage:(NSString *)message;
- (void)photoAddedToBuilding:(BOOL)sucess withMessage:(NSString *)message;
- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error;
@end


@interface TEBuildingProxy : TEProxyBase <RKObjectLoaderDelegate>

@property (nonatomic, weak) id<TEBuildingProxyDelegate> delegate;
@property (nonatomic, strong) NSArray *searchBuildings;

- (void)searchBuildingsWithString:(NSString *)searchString;
- (void)addBuildingNamed:(NSString *)buildingName withAddress:(NSString *)address withZip:(NSString *)zip;
- (void)updateBuildingWithID:(NSInteger)buildingID withName:(NSString *)buildingName withAddress:(NSString *)address withZip:(NSString *)zip;
- (void)editBuilding:(NSInteger)buildingID inTour:(NSInteger)tourID withRate:(NSString *)rate withRentable:(NSString *)rentable;
- (void)getRentalInfoForBuilding:(NSInteger)buildingID inTour:(NSInteger)tourID;
- (void)loadBuildingsInTour:(NSInteger)tourID;
- (void)loadBuildingDetails:(NSInteger)buildingID;
- (void)loadBuildingDetails:(NSInteger)buildingID inTour:(NSInteger)tourID;
- (void)rateBuilding:(NSInteger)buildingID forTour:(NSInteger)tourID withNotes:(NSString *)notes withRatings:(NSString *)ratings;
- (void)addPhoto:(NSInteger)photoID toBuilding:(NSInteger)buildingID;
- (void)stopProcessing;

@end
