//
// © Catchoom Technologies S.L.
// Licensed under the MIT license.
// https://github.com/Catchoom/ios-crc/blob/master/LICENSE
//
//
//  UIStoryboardPushNoAnimation.m
//  

#import "UIStoryboardPushNoAnimation.h"

@implementation UIStoryboardPushNoAnimation
-(void) perform{
    UIViewController *source = self.sourceViewController;
    UIViewController *destination = self.destinationViewController;
    

    [source.navigationController pushViewController:destination animated:NO];
}
@end
