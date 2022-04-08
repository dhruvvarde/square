//
//  CSAnalogInterface_Protected.h
//  CoreSwipe
//
//  Created by Martin Mroz on 5/20/13.
//  Copyright (c) 2013 Square, Inc. All rights reserved.
//

#import <cardreader/cr_comms_types.h>
#import <SquareCore/SquareCore.h>
#import <SquareReader/CSAnalogInterface.h>


typedef NS_ENUM(NSUInteger, CSAnalogInterfaceDataOutputMode) {
    CSAnalogInterfaceDataOutputModeNone = 0,
    CSAnalogInterfaceDataOutputModeOneshot,
    CSAnalogInterfaceDataOutputModeLooping
};


@interface CSAnalogInterface ()

@property (nonatomic, assign) CSAnalogInterfaceDataOutputMode outputMode;
@property (nonatomic, strong) NSMutableData *outputData;
@property (nonatomic, assign) NSUInteger outputLoopIndex;

- (void)waitForBackgroundSignalDecodeOperationsToFinish;

/// Acts on a "legacy" swipe event generated by LCR in response to a signal LCR was unable to understand.
- (void)consumeLegacySwipeEvent:(cr_comms_event_t)event data:(cr_comms_event_data_t *)dataPtr SQ_NONNULL(2);

@end