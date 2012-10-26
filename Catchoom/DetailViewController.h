//
//© Catchoom Technologies S.L.
//Licensed under the MIT license.
//http://github.com/Catchoom/ios-crc/blob/master/LICENSE.md
//
//
//  DetailViewController.h
//  Cachoom
//
//  Created by Crisredfi on 9/15/12.
//  Copyright (c) 2012 Catchoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UIWebViewDelegate>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURL *url;



- (void)executeRequest;
- (void)loadWebViewWithContentUrl:(NSURL*)url;

@end
