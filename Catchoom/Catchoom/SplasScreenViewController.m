//
//© Catchoom Technologies S.L.
//Licensed under the MIT license.
//http://github.com/Catchoom/ios-crc/blob/master/LICENSE.md
////
//  SplasScreenViewController.m
//  Catchoom
//
//  Created by Crisredfi on 9/29/12.
//  Copyright (c) 2012 Catchoom. All rights reserved.
//

#import "SplasScreenViewController.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface SplasScreenViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation SplasScreenViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    if( IS_IPHONE_5 )
    {
        self.backgroundImageView.image = [UIImage imageNamed:@"Default-568h@2x.png"];
    }
    [[CatchoomService sharedCatchoom] setDelegate: self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [[CatchoomService sharedCatchoom] connect:[defaults stringForKey:@"token"]];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        return (interfaceOrientation == UIInterfaceOrientationLandscapeRight );
    }else{
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
}
- (BOOL)shouldAutorotate{
    return YES;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationMaskLandscapeRight;
}
- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        return UIInterfaceOrientationMaskLandscapeRight;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setActivityIndicator:nil];
    [self setBackgroundImageView:nil];
    [super viewDidUnload];
}


- (void)didReceiveConnectResponse:(id)sender {
    
    RKResponse *response = sender;
    NSArray *parsedResponse = [response parsedBody:NULL];
                if([parsedResponse count] == 0){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERROR",@"")
                                                                    message:NSLocalizedString(@"there's been an error while trying to connect to the server", @"")
                                                                   delegate:self
                                                          cancelButtonTitle:NSLocalizedString(@"OK",@"")
                                                          otherButtonTitles: nil];
                    [alert show];
                }else{
                    if(response.statusCode == 200){
                        if([parsedResponse valueForKey:@"message"]){
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
                                [self performSegueWithIdentifier:@"ShowLogIn" sender:self];
    
                            });
    
                        }else{
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
                                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    
                                    [self dismissModalViewControllerAnimated:YES];
                                }else {
                                    [self performSegueWithIdentifier:@"showMainView" sender:self];
    
                                }
                            });
                        }
                    }else{
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
                            [self performSegueWithIdentifier:@"ShowLogIn" sender:self];
    
                        });
                    }
                }

}

- (void)didFailLoadWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERROR",@"")
                                                    message:NSLocalizedString(@"there's been an error while trying to connect to the server", @"")
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"OK",@"")
                                          otherButtonTitles: nil];
    [alert show];
}

@end
