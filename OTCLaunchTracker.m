//
//  OTCLaunchTracker.m
//  Created by Oliver Cameron on 7/25/13.
//

#import "OTCLaunchTracker.h"

static NSString * const OTCLaunchTrackerNumberOfLaunchesKey = @"OTCLaunchTrackerNumberOfLaunches";
static NSString * const OTCLaunchTrackerComparisonDateKey = @"OTCLaunchTrackerComparisonDate";

@implementation OTCLaunchTracker

- (BOOL)isActivated {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL numberOfLaunchesOnTarget = NO;
    BOOL numberOfDaysOnTarget = NO;
    
    // Grab the current number of launches
    // and increment by one for this launch
    NSInteger currentNumberOfLaunches = [userDefaults integerForKey:OTCLaunchTrackerNumberOfLaunchesKey];
    currentNumberOfLaunches += 1;
    
    // Check to see if the number of launches meets the criteria
    if (self.numberOfLaunchesBeforeActivating > 0) {
        numberOfLaunchesOnTarget = currentNumberOfLaunches == self.numberOfLaunchesBeforeActivating;
    }
    
    // This is the date we'll use to see
    // if we should activate if enough
    // days have passed
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    NSDate *comparisonDate = [userDefaults objectForKey:OTCLaunchTrackerComparisonDateKey];
    if (comparisonDate == nil) {
        // Happens on first launch
        comparisonDate = [NSDate date];
    }
    
    // Calculate the number of days that have elapsed
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&comparisonDate interval:NULL forDate:comparisonDate];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&currentDate interval:NULL forDate:currentDate];
    NSDateComponents *dateComponents = [calendar components:NSDayCalendarUnit fromDate:comparisonDate toDate:currentDate options:0];
    NSInteger numberOfDaysElapsed = [dateComponents day];
    
    // Does the number of days meet the criteria?
    if (self.numberOfDaysBeforeActivating > 0) {
        numberOfDaysOnTarget = numberOfDaysElapsed == self.numberOfDaysBeforeActivating;
    }
    
    // Save the changed comparisons
    [userDefaults setInteger:currentNumberOfLaunches forKey:OTCLaunchTrackerNumberOfLaunchesKey];
    [userDefaults setObject:comparisonDate forKey:OTCLaunchTrackerComparisonDateKey];
    [userDefaults synchronize];
    
    // Check to see if we should activate
    BOOL isActivated = numberOfLaunchesOnTarget == YES || numberOfDaysOnTarget == YES;
    return isActivated;
}

- (void)reset {
    // Remove objects so we can start from scratch in the next launch
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:OTCLaunchTrackerNumberOfLaunchesKey];
    [userDefaults removeObjectForKey:OTCLaunchTrackerComparisonDateKey];
    [userDefaults synchronize];
}

@end
