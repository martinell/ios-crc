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
//  ImageTransformations.m
//
//  Created by David Marimon Sanjuan on 10/2/12.
//  Copyright (c) 2012 Catchoom Advertising Network S.L. All rights reserved.
//  Licensed for use under the Evaluation License for Catchoom Visual Search Software and Service.
//

#import "ImageTransformations.h"

@implementation ImageTransformations

+ (UIImage *)convertToGrayScale:(UIImage*)source {
	
	CGSize size = source.size;
	CGColorSpaceRef gray = CGColorSpaceCreateDeviceGray();
	CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, gray, kCGImageAlphaNone);
	
	/*  modified code */     
	CGContextScaleCTM(context, 1, -1);
	CGContextTranslateCTM(context, 0, -size.height);
	/* end modified code */
	
	CGColorSpaceRelease(gray);
	UIGraphicsPushContext(context);
	[source drawAtPoint:CGPointZero blendMode:kCGBlendModeCopy alpha:1.0];
	UIGraphicsPopContext();
	
	CGImageRef img = CGBitmapContextCreateImage(context);
	
	CGContextRelease(context);
	UIImage *newImage = [UIImage imageWithCGImage:img];
	
	CGImageRelease(img);
	
	return newImage;
	
}

+ (UIImage *)scaleImage:(UIImage *)image withFactor:(double)factor{ 
	
	CGSize size = image.size;
	
	CGRect rect = CGRectMake(0.0, 0.0, factor * size.width, factor * size.height);
	
	UIGraphicsBeginImageContext(rect.size);  
	[image drawInRect:rect];  
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();  
	UIGraphicsEndImageContext();  
	
	return newImage;  
}

+ (UIImage *)scaleImage:(UIImage *)image shortestSide:(GLuint)uiPixels
{
	
	CGSize size = image.size;
    
    GLuint uMinSide = MIN(size.height, size.width);
    
    float fScaleFactor = (float)uiPixels / (float)uMinSide;
	
	CGRect rect = CGRectMake(0.0, 0.0, fScaleFactor * size.width, fScaleFactor * size.height);
	
	UIGraphicsBeginImageContext(rect.size);  
	[image drawInRect:rect];  
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();  
	UIGraphicsEndImageContext();  
	
	return newImage;  
}
@end
