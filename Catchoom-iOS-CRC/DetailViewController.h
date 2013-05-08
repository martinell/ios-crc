//
// © Catchoom Technologies S.L.
// Licensed under the MIT license.
// https://github.com/Catchoom/ios-crc/blob/master/LICENSE
//
//
//  DetailViewController.h
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UIWebViewDelegate>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURL *url;



- (void)executeRequest;
- (void)loadWebViewWithContentUrl:(NSURL*)url;

@end
