//
//  StoryPartViewController.m
//  AVStorybook
//
//  Created by Kevin Cleathero on 2017-06-16.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

#import "StoryPageViewController.h"
#import "SinglePageViewController.h"

@interface StoryPageViewController ()

@end

@implementation StoryPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SinglePageViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Single-AV-Page"]; // 1
    
    viewController.pageNumber = 1; // 2
    
    self.dataSource = self;
    
    [self setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil]; // 3
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    int previousPageNumber = ((SinglePageViewController *)viewController).pageNumber; // 1
    
    if(previousPageNumber < 5){
    
        SinglePageViewController *nextPageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Single-AV-Page"]; // 2
        
        nextPageViewController.pageNumber = previousPageNumber + 1; // 3
        
        return nextPageViewController; // 4
    }
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    int previousPageNumber = ((SinglePageViewController *)viewController).pageNumber; // 1
    
    if(previousPageNumber > 1){
    
        SinglePageViewController *nextPageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Single-AV-Page"]; // 2
        
        nextPageViewController.pageNumber = previousPageNumber-1; // 3
        
        return nextPageViewController; // 4
    }
    
    return nil;
}

@end
