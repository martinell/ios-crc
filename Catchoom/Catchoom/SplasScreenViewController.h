//
//© Catchoom Technologies S.L.
//Licensed under the MIT license.
//http://github.com/Catchoom/ios-crc/blob/master/LICENSE.md
//
//  SplasScreenViewController.h
//  Catchoom
//
//  Created by Crisredfi on 9/29/12.
//  Copyright (c) 2012 Catchoom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CRSMobile/CRSMobile.h>


@interface SplasScreenViewController : UIViewController
<CatchoomServiceProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


@end
