# OTCLaunchTracker

OTCLaunchTracker is a super simple way to track launches in your iOS app. One use case is to alert the user to review your app if they have launched it a specific number of times. Alternatively, you can specify a number of days before activation. OTCLaunchTracker has been tested on iOS 6 and requires ARC.

## Usage

```obj-c
OTCLaunchTracker *launchTracker = [[OTCLaunchTracker alloc] init];
launchTracker.numberOfLaunchesBeforeActivating = 10;
launchTracker.numberOfDaysBeforeActivating = 7;
if ([launchTracker isActivated] == YES) {
	// One or both of the conditions is true
}
```