//
//  ViewController.h
//  HentaiGana
//
//  Created by Aditya Tannu on 10/10/14.
//  Copyright (c) 2014 Aditya Tannu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    IBOutlet UIImageView *HentaiGanaView;
    
    IBOutlet UIImageView *KanaView;
    
    IBOutlet UIImageView *ShutokuView;
//    IBOutlet UIImageView *KanjiView;
    
}

- (IBAction)NextKana:(id)sender;


@end

