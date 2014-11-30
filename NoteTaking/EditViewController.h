//
//  EditViewController.h
//  NoteTaking
//
//  Created by imac2708 on 25/11/14.
//  Copyright (c) 2014 VTC PEAK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController

// p44
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *my_groupField;
@property (weak, nonatomic) IBOutlet UITextView *contentField;

@property (nonatomic, retain) NSString *noteIndex;
    @property (nonatomic, retain) NSString *titleText;
    @property (nonatomic, retain) NSString *my_groupText;
    @property (nonatomic, retain) NSString *contentText;


@end
