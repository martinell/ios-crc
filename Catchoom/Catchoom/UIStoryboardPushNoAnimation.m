//
//© Catchoom Technologies S.L.
//Licensed under the MIT license.
//http://github.com/Catchoom/ios-crc/blob/master/LICENSE.md
//
//
//  UIStoryboardPushNoAnimation.m
//  Catchoom
//
//  Created by Crisredfi on 9/29/12.
//  Copyright (c) 2012 Catchoom. All rights reserved.
//

#import "UIStoryboardPushNoAnimation.h"

@implementation UIStoryboardPushNoAnimation
-(void) perform{
    UIViewController *source = self.sourceViewController;
    UIViewController *destination = self.destinationViewController;
    

    [source.navigationController pushViewController:destination animated:NO];
}
@end
