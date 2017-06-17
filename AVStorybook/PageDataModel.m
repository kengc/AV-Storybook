//
//  PageDataModel.m
//  AVStorybook
//
//  Created by Kevin Cleathero on 2017-06-16.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

#import "PageDataModel.h"


@implementation PageDataModel

- (instancetype)initWithImage:(UIImage *)image andAudio:(AVAudioFile *)audio
{
    self = [super init];
    if (self) {
        _pageImage = image;
        _pageAudio = audio;
    }
    return self;
}

@end
