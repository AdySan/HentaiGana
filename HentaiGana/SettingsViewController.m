//
//  SettingsViewController.m
//  HentaiGana
//
//  Created by Aditya Tannu on 10/19/14.
//  Copyright (c) 2014 Aditya Tannu. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (strong, nonatomic) NSArray *KanaList;
@property (strong, nonatomic) NSArray *KanjiList;
@property (strong, nonatomic) NSArray *HentaiGanaList;
@property (strong, nonatomic) NSArray *ShutokuList;


@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Path to the plist (in the application bundle)
    NSString *KanaPath = [[NSBundle mainBundle] pathForResource:@"Kana" ofType:@"plist"];
    NSString *KanjiPath = [[NSBundle mainBundle] pathForResource:@"Kanji" ofType:@"plist"];
    NSString *HentaiGanaPath = [[NSBundle mainBundle] pathForResource:@"HentaiGana" ofType:@"plist"];
    NSString *ShutokuPath = [[NSBundle mainBundle] pathForResource:@"Shutoku" ofType:@"plist"];

    
    // Build the array from the plist
   self.KanaList = [[NSMutableArray alloc] initWithContentsOfFile:KanaPath];
   self.KanjiList = [[NSMutableArray alloc] initWithContentsOfFile:KanjiPath];
   self.HentaiGanaList = [[NSMutableArray alloc] initWithContentsOfFile:HentaiGanaPath];
   self.ShutokuList = [[NSMutableArray alloc] initWithContentsOfFile:ShutokuPath];
    
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

#pragma TableView methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        return [self.searchResultsArray count];
//    }
//    else {

    NSLog(@"Number of Characters = %d",[self.KanaList count]);

    return [self.HentaiGanaList count];
    

//    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        cell.textLabel.text = [self.searchResultsArray objectAtIndex:indexPath.row];
//        
//        NSUInteger originalIndex = [self.wordsArray indexOfObject:cell.textLabel.text];
//        cell.detailTextLabel.text = [self.meaningsArray objectAtIndex:originalIndex];
//        
//        
//    }
//    else{
//      cell.detailTextLabel.text = [self.ShutokuList objectAtIndex: indexPath.row];
    
    
    //      cell.detailTextLabel.text = [NSString stringWithFormat:@"%i",[self.ShutokuList objectAtIndex: indexPath.row]];
    cell.detailTextLabel.text = [[NSNumber numberWithInt:[self.ShutokuList objectAtIndex: indexPath.row]] stringValue];
    NSLog(@"blah = %i",[NSNumber numberWithInt:[self.ShutokuList objectAtIndex: indexPath.row]] );

    cell.imageView.image = [UIImage imageNamed:[self.HentaiGanaList objectAtIndex: indexPath.row]];
    
//        cell.detailTextLabel.text = [self.meaningsArray objectAtIndex:indexPath.row];
//    }
    return cell;
}



@end
