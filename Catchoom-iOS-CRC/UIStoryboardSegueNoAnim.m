//
// © Catchoom Technologies S.L.
// Licensed under the MIT license.
// https://github.com/Catchoom/ios-crc/blob/master/LICENSE
//
//
//  UIStoryboardSegueNoAnim.m
//  

#import "UIStoryboardSegueNoAnim.h"

@implementation UIStoryboardSegueNoAnim

-(void) perform{
    [self.sourceViewController presentModalViewController:self.destinationViewController animated:NO];
}

@end
