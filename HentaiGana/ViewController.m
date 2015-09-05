//
//  ViewController.m
//  HentaiGana
//
//  Created by Aditya Tannu on 10/10/14.
//  Copyright (c) 2014 Aditya Tannu. All rights reserved.
//

#import "ViewController.h"
#import "OptionsTransitionAnimator.h"
#import "OptionsViewController.h"

static NSString * const kSegueOptionsDismiss = @"optionsDismiss";
static NSString * const kSegueDropDismiss    = @"dropDismiss";
static NSString * const kSegueOptionsModal   = @"optionsModal";

@interface ViewController ()

@property (strong, nonatomic) NSArray *HentaiGanaList;

@end

@implementation ViewController


#define NO_OF_WORDS 12

BOOL gameOver = NO;
BOOL SAW_KANA = NO;

int randomIndex;

-(void)viewDidLoad {
    [super viewDidLoad];
    
        [self.navigationController setNavigationBarHidden:NO];
    
    [self checkAndCreateScores];
    
    NSString *HentaiGanaPath = [[NSBundle mainBundle] pathForResource:@"HentaiGana" ofType:@"plist"];
    self.HentaiGanaList = [[NSMutableArray alloc] initWithContentsOfFile:HentaiGanaPath];

    ShutokuView.image = [UIImage imageNamed:@"check.png"];
    ShutokuView.hidden = YES;
    
    [self NextKana:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showKana:(id)sender {
    

    // Path to the plist (in the application bundle)
    NSString *KanaPath = [[NSBundle mainBundle] pathForResource:@"Kana" ofType:@"plist"];
    NSString *KanjiPath = [[NSBundle mainBundle] pathForResource:@"Kanji" ofType:@"plist"];
    
    // Build the array from the plist
    NSMutableArray *KanaList = [[NSMutableArray alloc] initWithContentsOfFile:KanaPath];
    NSMutableArray *KanjiList = [[NSMutableArray alloc] initWithContentsOfFile:KanjiPath];
    
    // Generate random index
    // randomIndex = arc4random() % 12;
    
    // Lookup word and meaning
    NSString *kanaFilename = [KanaList objectAtIndex:randomIndex];
    NSString *kanjiFilename = [KanjiList objectAtIndex:randomIndex];
    
    // Populate card with word and meaning
//    [KanaView setImage:[UIImage imageNamed:kanaFilename]];
//    [KanjiView setImage:[UIImage imageNamed:kanjiFilename]];
    
    
    [UIImageView transitionWithView:KanaView
                           duration:0.5
                            options:UIViewAnimationOptionTransitionFlipFromRight
                         animations:^{
                             //  Set the new image
                             //  Since its done in animation block, the change will be animated
                             KanaView.image = [UIImage imageNamed:kanaFilename];
                         } completion:^(BOOL finished) {
                             //  Do whatever when the animation is finished
                         }];
//    [UIImageView transitionWithView:KanjiView
//                           duration:1.4
//                            options:UIViewAnimationOptionTransitionCrossDissolve
//                         animations:^{
//                             //  Set the new image
//                             //  Since its done in animation block, the change will be animated
//                             KanjiView.image = [UIImage imageNamed:kanjiFilename];
//                         } completion:^(BOOL finished) {
//                             //  Do whatever when the animation is finished
//                         }];
    
    
    [UIImageView transitionWithView:HentaiGanaView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        //  Set the new image
                        //  Since its done in animation block, the change will be animated
                        HentaiGanaView.image = [UIImage imageNamed:kanjiFilename];
                    } completion:^(BOOL finished) {
                        //  Do whatever when the animation is finished
                    }];
    
    [self markAsIDontKnowThisOne];
    SAW_KANA = YES;
}

-(IBAction)NextKana:(id)sender {
    
    

    
    if(self.DoIKnowAllWords == YES)
    {
//        [HentaiGanaView setText:[[NSString alloc] initWithFormat:@"Game Over" ] ];
        HentaiGanaView.image = [UIImage imageNamed:@"hanko.png"];
//        [meaningView setText:[[NSString alloc] initWithFormat:@""]];
        gameOver = YES;
    }
    else
    {
    
        // Generate random index
        randomIndex = arc4random() % 12;
    
        // Lookup word and meaning
        NSString *hentaiganaFilename = [self.HentaiGanaList objectAtIndex:randomIndex];
    
        // Populate card with word and meaning
        //    [HentaiGanaView setImage:[UIImage imageNamed:hentaiganaFilename]];

//        CATransition *animation1 = [CATransition animation];
//        animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCATransitionFade];
//        animation1.type = kCATransitionFade;
//        animation1.duration = 0.25;
//        [ShutokuView.layer addAnimation:animation1 forKey:@"kCATransitionMoveIn"];

        
        
        
        CATransition *animation = [CATransition animation];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionMoveIn;
        animation.duration = 0.25;
        [HentaiGanaView.layer addAnimation:animation forKey:@"kCATransitionMoveIn"];
        HentaiGanaView.image = [UIImage imageNamed:hentaiganaFilename];
    
        [self markAsIKnowThisOne];
    
        KanaView.image = nil;
        //KanjiView.image = nil;
    }
}

#pragma Shuutoku

-(IBAction)popupImage:(id)sender{

    if(SAW_KANA != YES)
    {
        ShutokuView.hidden = NO;
        ShutokuView.alpha = 1.0f;
        // Then fades it away after 2 seconds (the cross-fade animation will take 0.5s)
        [UIView animateWithDuration:0.3 delay:0.1 options:0 animations:^{
            // Animate the alpha value of your imageView from 1.0 to 0.0 here
            ShutokuView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
            ShutokuView.hidden = YES;
        }];
    }
    [self NextKana:nil];
    SAW_KANA = NO;
    
}

-(void) checkAndCreateScores{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath= [documentsDirectory stringByAppendingPathComponent:@"Shutoku.plist"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success){
        NSLog(@"Score plist exists");
        return;
    }
    
    NSLog(@"Scores plist does not exist, so making one");
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Shutoku.plist"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

-(IBAction)markAsIKnowThisOne{
    
    // Save state
    //    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath= [documentsDirectory stringByAppendingPathComponent:@"Shutoku.plist"];
    NSMutableArray *DoneArray = [[NSMutableArray alloc] initWithContentsOfFile:writableDBPath];
    [DoneArray replaceObjectAtIndex:randomIndex withObject:[NSNumber numberWithInteger:1]];
    [DoneArray writeToFile:writableDBPath atomically:YES];
}

-(IBAction)markAsIDontKnowThisOne{
    
    // Save state
    //    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath= [documentsDirectory stringByAppendingPathComponent:@"Shutoku.plist"];
    NSMutableArray *DoneArray = [[NSMutableArray alloc] initWithContentsOfFile:writableDBPath];
    [DoneArray replaceObjectAtIndex:randomIndex withObject:[NSNumber numberWithInteger:2]];
    [DoneArray writeToFile:writableDBPath atomically:YES];
}


-(BOOL) DoIKnowThisWord{
    // Check if it's already learnt
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath= [documentsDirectory stringByAppendingPathComponent:@"Shutoku.plist"];
    NSMutableArray *DoneArray = [[NSMutableArray alloc] initWithContentsOfFile:writableDBPath];
    
    int occurrences = 0;
    for(NSNumber *whatcha in DoneArray){
        occurrences += ([whatcha isEqualToNumber:[NSNumber numberWithInt:2]]?1:0);
    }
    NSLog(@"Remainging Words = %d",occurrences);
//    RemainingWords.text = [NSString stringWithFormat:@"剩余:%d",occurrences];
    
    if ([DoneArray objectAtIndexedSubscript:randomIndex] == [NSNumber numberWithInteger:1]) {
        NSLog(@"Stumbled on word I knowe already, reshuffle");
        return YES;
    }
    else{
        NSLog(@"Found new word!");
        return NO;
    }
}

-(BOOL) DoIKnowAllWords{
    // Check if it's already learnt
    NSFileManager *fileManager2 = [NSFileManager defaultManager];
    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory2 = [paths2 objectAtIndex:0];
    NSString *writableDBPath2= [documentsDirectory2 stringByAppendingPathComponent:@"Shutoku.plist"];
    NSMutableArray *DoneArray2 = [[NSMutableArray alloc] initWithContentsOfFile:writableDBPath2];
    
    for (int i=0; i<NO_OF_WORDS; i++)
    {
        if ([DoneArray2 objectAtIndexedSubscript:i ] == [NSNumber numberWithInteger:2])
        {
            return NO;
        }
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Options - modal
    if ([segue.identifier isEqualToString:kSegueOptionsModal]) {
        UIViewController *toVC = segue.destinationViewController;
        toVC.modalPresentationStyle = UIModalPresentationCustom;
        toVC.transitioningDelegate = self;
    }
}


#pragma mark - UIViewControllerTransitioningDelegate

/*
 Called when presenting a view controller that has a transitioningDelegate
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    id<UIViewControllerAnimatedTransitioning> animationController;
    
    // Options
    if ([presented isKindOfClass:[UINavigationController class]] &&
        [((UINavigationController *)presented).topViewController isKindOfClass:[OptionsViewController class]]) {
        OptionsTransitionAnimator *animator = [[OptionsTransitionAnimator alloc] init];
        animator.appearing = YES;
        animator.duration = 0.35;
        animationController = animator;
    }
    return animationController;
}

/*
 Called when dismissing a view controller that has a transitioningDelegate
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    id<UIViewControllerAnimatedTransitioning> animationController;
    
    // Options
    if ([dismissed isKindOfClass:[UINavigationController class]] &&
        [((UINavigationController *)dismissed).topViewController isKindOfClass:[OptionsViewController class]]) {
        OptionsTransitionAnimator *animator = [[OptionsTransitionAnimator alloc] init];
        animator.appearing = NO;
        animator.duration = 0.35;
        animationController = animator;
    }
    return animationController;
}


#pragma mark - Storyboard unwinding

/*
 Unwind segue action called to dismiss the Options and Drop view controllers and
 when the Slide, Bounce and Fold view controllers are dismissed with a single tap.
 
 Normally an unwind segue will pop/dismiss the view controller but this doesn't happen
 for custom modal transitions so we have to manually call dismiss.
 */
- (IBAction)unwindToViewController:(UIStoryboardSegue *)sender
{
    NSLog(sender.identifier);
    
    if ([sender.identifier isEqualToString:kSegueOptionsDismiss] || [sender.identifier isEqualToString:kSegueDropDismiss]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end


