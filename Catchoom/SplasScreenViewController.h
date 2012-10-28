//
// © Catchoom Technologies S.L.
// Licensed under the MIT license.
// https://github.com/Catchoom/ios-crc/blob/master/LICENSE
//
//  SplasScreenViewController.h
//  

#import <UIKit/UIKit.h>
#import <CRSMobile/CRSMobile.h>


@interface SplasScreenViewController : UIViewController
<CatchoomServiceProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


@end
