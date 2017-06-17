//
//  SinglePageViewController.m
//  AVStorybook
//
//  Created by Kevin Cleathero on 2017-06-16.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

#import "SinglePageViewController.h"
#import "PageDataModel.h"

@interface SinglePageViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *pageImageView;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;

@property (nonatomic,strong) AVAudioPlayer *audioPlayer;
@property (nonatomic,strong) AVAudioRecorder *AVAudioRecorder;

@property (weak, nonatomic) IBOutlet UIButton *recordButton;

@end

@implementation SinglePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PageDataModel *pageObject = [[PageDataModel alloc] init];
    
    self.pageLabel.text = [NSString stringWithFormat:@"Page: %i", self.pageNumber];
    
//    

    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    
    
    NSString *fileName = [NSString stringWithFormat:@"Page%isound.caf", self.pageNumber];
    NSString *soundFilePath = [documentsPath stringByAppendingPathComponent:fileName];//at this path your recorded audio will be saved
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    self.AVAudioRecorder = [[AVAudioRecorder alloc]initWithURL:soundFileURL settings:recordSettings error:&error];
    
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.AVAudioRecorder.url error:&error];
    
    if (error) { // 3
        // There was an error creating the audio player
        NSLog(@"Audio error: %@", error.localizedDescription);
    }
    
    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    
    [self.view addGestureRecognizer:TapGesture];
    
}

-(void)viewTap:(UITapGestureRecognizer *)sender{
    
    NSLog(@"Was Tapped");
    
    if ([self.audioPlayer isPlaying]) { // 1
        [self.audioPlayer stop]; // 2
    } else {
        [self.audioPlayer prepareToPlay]; // 3
        [self.audioPlayer play];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)PageLoadImage:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init]; // 1
    
    if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    //imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; // 2
    
    [self presentViewController:imagePicker animated:YES completion:nil]; // 3
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //[picker dismissViewControllerAnimated(true, completion: nil)];
    [picker dismissViewControllerAnimated:true completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
//    self.pageImageView.image = chosenImage;
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.pageImageView.image = selectedImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    
//    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//    self.pageImageView.image = selectedImage;
//}


- (IBAction)PageRecordAudio:(id)sender {
    
    NSLog(@"Record engaged");
    
    if(![self.AVAudioRecorder isRecording]){
    
        self.recordButton.titleLabel.text = @"Recording..";
        self.recordButton.titleLabel.backgroundColor = [UIColor redColor];
    
        [self.AVAudioRecorder prepareToRecord];
        [self.AVAudioRecorder record];//Mehod to Record Audio
        
    } else {
        
        self.recordButton.titleLabel.text = @"Record";
        self.recordButton.titleLabel.backgroundColor = [UIColor whiteColor];
        [self.AVAudioRecorder stop];
    }
    
}

@end
