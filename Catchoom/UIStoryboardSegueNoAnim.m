//
//© Catchoom Technologies S.L.
//Licensed under the MIT license.
//http://github.com/Catchoom/ios-crc/blob/master/LICENSE.md
//
//
//  UIStoryboardSegueNoAnim.m
//  Catchoom
//
//  Created by Crisredfi on 9/16/12.
//  Copyright (c) 2012 Catchoom. All rights reserved.
//

#import "UIStoryboardSegueNoAnim.h"

@implementation UIStoryboardSegueNoAnim

-(void) perform{
    [self.sourceViewController presentModalViewController:self.destinationViewController animated:NO];
}

@end
