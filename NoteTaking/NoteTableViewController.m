//
//  NoteTableViewController.m
//  NoteTaking
//
//  Created by imac2708 on 25/11/14.
//  Copyright (c) 2014 VTC PEAK. All rights reserved.
//

#import "NoteTableViewController.h"
// p46 (1/2)
#import "EditViewController.h"


@interface NoteTableViewController ()

@end

@implementation NoteTableViewController

// p46 (2/2)
int rowSelected = -1;
bool firstRunFlag = true;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // p47 (1/2)
    self.items      = [[NSMutableArray alloc] init];
    self.content    = [[NSMutableArray alloc] init];
    self.timeStamp  = [[NSMutableArray alloc] init];
    self.my_flag    =  [[NSMutableArray alloc] init];
    
    self.savePath = [self pathByCopyingFile:@"note.plist"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // p47 (2/2)
    if(!firstRunFlag){
        NSMutableDictionary *data   = [[NSMutableDictionary alloc] initWithContentsOfFile:self.savePath];
        self.items                  = [data objectForKey:@"items"];
        self.content                = [data objectForKey:@"content"];
        self.timeStamp              = [data objectForKey:@"timeStamp"];
        self.my_flag                = [data objectForKey:@"my_flag"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    // p48 (1/2)
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    // p48 (2/2)
    return self.items.count;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/
// p49
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"noteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    if( cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
//    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
        // My script
        if ( [[self.items objectAtIndex:indexPath.row] isEqualToString:@""] ){
            cell.textLabel.text = @"(Untitled)";    // Show "untitled" if blank title
        }else{
            cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
        }
    
    
    cell.detailTextLabel.text = [self.timeStamp objectAtIndex:indexPath.row];
    
    return cell;
}

// p50 (1/2)
- (IBAction)addNote:(UIBarButtonItem *)sender {
    NSString *newNote = @"New Note";
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY.MM.dd hh:mm:ss"];
    NSString *newTime = [dateFormatter stringFromDate: currentTime];
    NSString *newContent = @"";
    [self.items addObject:newNote];
    [self.timeStamp addObject:newTime];
    [self.content addObject:newContent];
    [self.tableView reloadData];
}

// p50 (2/2)
- (IBAction)editTable:(UIBarButtonItem*)sender{
    if( self.editing == NO ){
        sender.title = @"Done";
        self.editing = YES;
    }else{
        sender.title = @"Edit";
        self.editing = NO;
    }
    [self saveNote];
}

// p51 (1/2)
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// p51 (2/2)
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.tableView beginUpdates];
        [self.items removeObjectAtIndex:indexPath.row];
        [self.content removeObjectAtIndex:indexPath.row];
        [self.timeStamp removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

// p52 (1/2)
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSLog(@"%@", self.items);
    NSString *tempItem      = self.items[fromIndexPath.row];
    NSString *tempContent   = self.content[fromIndexPath.row];
    NSString *tempTimeStamp = self.timeStamp[fromIndexPath.row];
    [self.items removeObjectAtIndex:fromIndexPath.row];
    [self.items insertObject:tempItem atIndex:toIndexPath.row];
    [self.content removeObjectAtIndex:fromIndexPath.row];
    [self.content insertObject:tempContent atIndex:toIndexPath.row];
    [self.timeStamp removeObjectAtIndex:fromIndexPath.row];
    [self.timeStamp insertObject:tempTimeStamp atIndex:toIndexPath.row];
    NSLog(@"%@", self.items);
}


// p52 (2/2)
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


// p53
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath  = [self.tableView indexPathForSelectedRow];
    rowSelected             = indexPath.row;
    EditViewController *evc = segue.destinationViewController;
    evc.titleText           = [self.items objectAtIndex:indexPath.row];
    evc.contentText         = [self.content objectAtIndex:indexPath.row];
    evc.noteIndex           = [NSString stringWithFormat:@"%d", rowSelected];
}

// p54
- (IBAction)unwindToHome:(UIStoryboardSegue *)unwindSegue{
    NSLog(@"Segue has unwond to here...");
    EditViewController *evc         = unwindSegue.sourceViewController;
    NSString *title                 = evc.titleText;
    NSString *content               = evc.contentText;
    NSString *noteIndex             = evc.noteIndex;
    NSDate *currentTime             = [NSDate date];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY.MM.dd hh:mm:ss"];
    NSString *newTime               = [dateFormatter stringFromDate: currentTime];
    NSLog(@"title: %@", title);
          [self.items replaceObjectAtIndex:[noteIndex intValue] withObject:title];
          [self.content replaceObjectAtIndex:[noteIndex intValue] withObject:content];
          [self.timeStamp replaceObjectAtIndex:[noteIndex intValue] withObject:newTime];
          [self.tableView reloadData];
          [self saveNote];
}


// p55
- (NSString *)pathByCopyingFile:(NSString *)fileName {
    NSArray *comp               = [fileName componentsSeparatedByString: @"."];
    NSBundle *bundle            = [NSBundle mainBundle];
    NSString *srcPath           = [bundle pathForResource:comp[0] ofType:comp[1]];
    
    NSFileManager *fileManager  = [NSFileManager defaultManager];
    NSArray *paths              = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents         = [paths objectAtIndex:0];
    NSString *path              = [documents stringByAppendingPathComponent:fileName];

    if( ![fileManager fileExistsAtPath:path] && srcPath != nil){
        NSError *error;
        [fileManager copyItemAtPath:srcPath toPath:path error:&error];
    }else{
        firstRunFlag = false;
    }
    
    return path;
}

// p56
- (void) saveNote{
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setValue:self.items forKey:@"items"];
    [data setValue:self.content forKey:@"content"];
    [data setValue:self.timeStamp forKey:@"timeStamp"];
    [data writeToFile:self.savePath atomically:YES];
}



@end
