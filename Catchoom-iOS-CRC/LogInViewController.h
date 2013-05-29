//
// © Catchoom Technologies S.L.
// Licensed under the MIT license.
// https://github.com/Catchoom/ios-crc/blob/master/LICENSE
//
//
//  LogInViewController.h
//  

#import <UIKit/UIKit.h>
#import <Catchoom-iOS-SDK/Catchoom-iOS-SDK.h>

@interface LogInViewController : UIViewController <UITextFieldDelegate,
UIScrollViewDelegate, CatchoomServiceProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
//@property (weak, nonatomic) IBOutlet UIImageView *bubbleImageView;
@property (weak, nonatomic) IBOutlet UITextField *collectionTextView;
@property (weak, nonatomic) IBOutlet UITextField *tokenTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end
