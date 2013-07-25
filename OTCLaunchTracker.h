//
//  OTCLaunchTracker.h
//  Created by Oliver Cameron on 7/25/13.
//

#import <Foundation/Foundation.h>

@interface OTCLaunchTracker : NSObject

@property (nonatomic, assign) NSInteger numberOfLaunchesBeforeActivating;
@property (nonatomic, assign) NSInteger numberOfDaysBeforeActivating;

// Check this after setting the integers to see if either conditions are met
- (BOOL)isActivated;

// Should you want to reset the stored values and start from scratch
- (void)reset;

@end
