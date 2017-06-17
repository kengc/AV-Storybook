//
//  PageDataModel.h
//  AVStorybook
//
//  Created by Kevin Cleathero on 2017-06-16.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AvFoundation/AvFoundation.h>

@interface PageDataModel : NSObject

@property (nonatomic) UIImage *pageImage;
@property (nonatomic) AVAudioFile *pageAudio;

@end
