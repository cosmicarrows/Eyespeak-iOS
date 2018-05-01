//
//  TESyncController.h
//  TenEight
//
//  Created by Brad Wiederholt on 10/1/12.
//  Copyright (c) 2012 Kennedy Kok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEBuildingProxy.h"
#import "TEPhotoProxy.h"
#import "TEPreferencesProxy.h"
#import "TEDocumentProxy.h"

@protocol TESyncControllerDelegate <NSObject>
@optional
- (void)didFinishTourDownload;
- (void)didFinishPreferenceSync;
- (void)didErrorOutSync;
- (void)newStatusMessage:(NSString *)statusMessage;
@end

@interface TESyncController : NSObject <TEBuildingProxyDelegate, TEPhotoProxyDelegate, TEDocumentProxyDelegate, TEMembersProxyDelegate, TEPreferencesProxyDelegate, TETourProxyDelegate, RKObjectLoaderDelegate>

@property (nonatomic, strong) TEBuildingProxy *buildingProxy;
@property (nonatomic, strong) TEPhotoProxy *photoProxy;
@property (nonatomic, strong) TEDocumentProxy *documentProxy;
@property (nonatomic, strong) TEMembersProxy *membersProxy;
@property (nonatomic, strong) TEPreferencesProxy *preferencesProxy;
@property (nonatomic, strong) TETourProxy *tourProxy;
@property (nonatomic) NSInteger tourID;
@property (nonatomic) BOOL processingMember;
@property (nonatomic, strong) NSString *memberEmail;

@property (nonatomic) NSInteger errorCount;
@property (nonatomic) NSInteger preferencesRemaining;
@property (nonatomic) NSInteger toursRemaining;
@property (nonatomic) NSInteger buildingsRemaining;
@property (nonatomic) NSInteger membersRemaining;
@property (nonatomic) NSInteger photosRemaining;
@property (nonatomic) NSInteger documentsRemaining;
@property (nonatomic) NSInteger buildingRentalInfoRemaining;
@property (nonatomic) NSInteger ratingUploadsRemaining;
@property (nonatomic) BOOL  allComplete;
@property (nonatomic) BOOL  uploadPreferencesComplete;
@property (nonatomic) BOOL  downloadPreferencesComplete;
@property (nonatomic) BOOL  tourComplete;
@property (nonatomic) BOOL  membersComplete;
@property (nonatomic) BOOL  buildingsComplete;
@property (nonatomic) BOOL  buildingDetailsComplete;
@property (nonatomic) BOOL  buildingRentalInfoComplete;
@property (nonatomic) BOOL  prefOnly;

@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) NSMutableArray *membersEmailList;
@property (nonatomic) BOOL stopIssued;

@property (nonatomic, weak) id <TESyncControllerDelegate> delegate;

- (void) startSyncForTour:(NSInteger)tourID;
- (void) uploadDownloadPreferencesOnly;
- (void) stopProcessing;

@end

