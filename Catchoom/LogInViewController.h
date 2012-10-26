//
//© Catchoom Technologies S.L.
//Licensed under the MIT license.
//http://github.com/Catchoom/ios-crc/blob/master/LICENSE.md
//
//
//  LogInViewController.h
//  Catchoom
//
//  Created by Crisredfi on 9/12/12.
//  Copyright (c) 2012 Catchoom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CRSMobile/CRSMobile.h>

@interface LogInViewController : UIViewController <UITextFieldDelegate,
UIScrollViewDelegate, CatchoomServiceProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bubbleImageView;
@property (weak, nonatomic) IBOutlet UITextField *collectionTextView;
@property (weak, nonatomic) IBOutlet UITextField *tokenTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end
