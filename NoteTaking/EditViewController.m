//
//  EditViewController.m
//  NoteTaking
//
//  Created by imac2708 on 25/11/14.
//  Copyright (c) 2014 VTC PEAK. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

/* // p35
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // No title handle
    if ( [self.titleText isEqualToString:@"New Note"] ){
        self.titleField.text    = @""; // Blank title for new note
    }else{
         self.titleField.text   = self.titleText;
    }
    
    // Group
    self.my_groupField.text      = self.my_groupText;
    
    // Content
    self.contentField.text      = self.contentText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// p45 - Put UI data to string , fwd it to next view
- (void) viewWillDisappear:(BOOL)animated{
    self.titleText      = self.titleField.text;
    self.contentText    = self.contentField.text;
    self.my_groupText    = self.my_groupField.text;
    [self performSegueWithIdentifier:@"saveSegue" sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

