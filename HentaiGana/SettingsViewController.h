//
//  SettingsViewController.h
//  HentaiGana
//
//  Created by Aditya Tannu on 10/19/14.
//  Copyright (c) 2014 Aditya Tannu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *Nokori;
@property (strong, nonatomic) IBOutlet UILabel *ShutokuKaisu;

@end
