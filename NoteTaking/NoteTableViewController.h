//
//  NoteTableViewController.h
//  NoteTaking
//
//  Created by imac2708 on 25/11/14.
//  Copyright (c) 2014 VTC PEAK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteTableViewController : UITableViewController

// p43
@property (nonatomic, retain) NSMutableArray *my_flag;      // My flag
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSMutableArray *my_group;      // My group
@property (nonatomic, retain) NSMutableArray *content;
@property (nonatomic, retain) NSMutableArray *timeStamp;

@property (nonatomic, retain) NSString *savePath;           // Save data whatever closed app

- (IBAction)addNote:(UIBarButtonItem*)sender;         // Trigger [+] btn
- (IBAction)editTable:(UIBarButtonItem*)sender;       // Table view to edit mode

@end
