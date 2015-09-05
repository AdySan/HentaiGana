//
//  IntroViewController.m
//  HentaiGana
//
//  Created by Aditya Tannu on 11/2/14.
//  Copyright (c) 2014 Aditya Tannu. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:YES];
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

#pragma mark - Storyboard unwinding

/*
 Unwind segue action called to dismiss the Options and Drop view controllers and
 when the Slide, Bounce and Fold view controllers are dismissed with a single tap.
 
 Normally an unwind segue will pop/dismiss the view controller but this doesn't happen
 for custom modal transitions so we have to manually call dismiss.
 */
- (IBAction)unwindToIntroViewController:(UIStoryboardSegue *)sender
{
    NSLog(sender.identifier);
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
