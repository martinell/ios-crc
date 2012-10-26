//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2012 Catchoom Advertising Netwroks, S.L.
//
// Permission to use, copy, modify, and distribute this software and its documentation for any purpose and without fee is hereby
// granted, provided that the above copyright notice appear in all copies and that both that the copyright notice and this permission
// notice and warranty disclaimer appear in supporting documentation, and that the name of the author not be used in advertising or
// publicity pertaining to distribution of the software without specific, written prior permission.
//
// The author disclaim all warranties with regard to this software, including all implied warranties of merchantability and fitness.
// In no event shall the author be liable for any special, indirect or consequential damages or any damages whatsoever resulting from
// loss of use, data or profits, whether in an action of contract, negligence or other tortious action, arising out of or in connection
// with the use or performance of this software.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  ImageHandler.h
//  ImageHandler
//
//  Created by David Marimon Sanjuan on 1/6/12.
//  Copyright (c) 2012 Catchoom Advertising Network S.L. All rights reserved.
//  Licensed for use under the Evaluation License for Catchoom Visual Search Software and Service.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageHandler : NSObject

/* 
 * /brief This function converts the input image to gray scale and rescales it so that the largest side has 300 pixels.
 * /return data pointer to the JPEG converted image compressed at 0.8 ratio.
 */
+ (NSData *)prepareNSDataFromUIImage: (UIImage*)image;

@end
