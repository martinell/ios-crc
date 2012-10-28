//
// © Catchoom Technologies S.L.
// Licensed under the MIT license.
// https://github.com/Catchoom/ios-crc/blob/master/LICENSE
//
//
//  DetailViewController.m
//  

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface DetailViewController ()
{
    UIView *_activityIndicatorView;
}
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation DetailViewController
@synthesize webView = _webView;
@synthesize url = _url;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.webView.delegate = self;

   
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        return (interfaceOrientation == UIInterfaceOrientationLandscapeRight );
    }else{
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }

}

- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        return UIInterfaceOrientationMaskLandscapeRight;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
        [self performSelector:@selector(executeRequest) withObject:nil afterDelay:0.2f];
    }
}







#pragma mark -
#pragma mark - webView

- (void)loadWebViewWithContentUrl:(NSURL*)newURL {
    self.url = newURL;
}

- (void)executeRequest {
    [_activityIndicatorView removeFromSuperview];
    BOOL viewAdded = NO;
    for (UIWebView *web in self.view.subviews) {
        if (web == self.webView){
            viewAdded = YES;
            break;
        }
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    if(!viewAdded) {
        [self.view addSubview:self.webView];

    }
    [self.webView loadRequest:request];
    
}
#pragma mark -
#pragma mark - activity indicator

- (void)willShowActivityIndicatorInMasterView {
    _activityIndicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];

    //_activityIndicatorView.layer.cornerRadius = 5.0f;
    _activityIndicatorView.layer.borderWidth = 1.0;
    _activityIndicatorView.layer.borderColor = [UIColor blackColor].CGColor;
    _activityIndicatorView.backgroundColor = [UIColor blackColor];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 400, 34)];
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad){
        infoLabel.frame = CGRectMake(20,5,300,34);
    }
    infoLabel.text = NSLocalizedString(@"loading web view,  please wait ... ", @"");
    infoLabel.numberOfLines = 2;
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.textAlignment = UITextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
    [_activityIndicatorView addSubview:infoLabel];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.frame = CGRectMake(15,10,20,20);
    [activityIndicator startAnimating];
    
    
    self.title = [NSString stringWithFormat:@"%@", self.url];
    [_activityIndicatorView addSubview:activityIndicator];
    
    [self.webView addSubview:_activityIndicatorView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 15 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
            [_activityIndicatorView removeFromSuperview];
    
    });

}


#pragma mark -
#pragma mark -Web View delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_activityIndicatorView removeFromSuperview];

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_activityIndicatorView removeFromSuperview];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERROR", @"")
                                                    message:NSLocalizedString(@"Something went wrong while trying to load the web page, please try it again later", @"")
                                                   delegate:self cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles: nil];
    [alert show];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_activityIndicatorView removeFromSuperview];

    [self willShowActivityIndicatorInMasterView];

}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController
     willHideViewController:(UIViewController *)viewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)popoverController
{
    //this is in case we support portrait orientation in iPad.
    barButtonItem.title = NSLocalizedString(@"Back", @"Back");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController
     willShowViewController:(UIViewController *)viewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}



@end
