//
//  FirstViewController.m
//  DODtab
//
//  Created by Tobias Friedenauer on 31.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "Shot.h"


@implementation FirstViewController
@synthesize scroller;
@synthesize menuView;
@synthesize UiTextDelay1;
@synthesize UiTextDelay2;
@synthesize UiTextDelay3;
@synthesize UiTextOpenTime1;
@synthesize UiTextOpenTime2;
@synthesize UiTextOpenTime3;
@synthesize choosenValveOutlet1;
@synthesize choosenValveOutlet2;
@synthesize choosenValveOutlet3;


//Bei Enter wird die Tastatur ausgeblendet------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.UiTextDelay1 resignFirstResponder];
    [self.UiTextDelay2 resignFirstResponder];
    [self.UiTextDelay3 resignFirstResponder];
    [self.UiTextOpenTime1 resignFirstResponder];
    [self.UiTextOpenTime2 resignFirstResponder];
    [self.UiTextOpenTime3 resignFirstResponder];
    return YES;
}
//----------------------------------------------------------------

//Beim verlassen eines Textfeldes
- (void)textFieldDidEndEditing:(UITextField *)textField
{
}
//-------------------------------


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 1100)];
}

- (void)viewDidUnload
{
    [self setUiTextDelay1:nil];
    [self setUiTextDelay2:nil];
    [self setUiTextDelay3:nil];
    [self setChoosenValveOutlet1:nil];
    [self setChoosenValveOutlet2:nil];
    [self setChoosenValveOutlet3:nil];
    [self setUiTextOpenTime1:nil];
    [self setUiTextOpenTime2:nil];
    [self setUiTextOpenTime3:nil];
    [self setMenuView:nil];
    [self setScroller:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


//Beim Tippen auf den Hintergrund wird die Tastatur ausgeblendet--------------
- (IBAction)backButton:(id)sender 
{
    [self.UiTextDelay1 resignFirstResponder];
    [self.UiTextDelay2 resignFirstResponder];
    [self.UiTextDelay3 resignFirstResponder]; 
    [self.UiTextOpenTime1 resignFirstResponder];
    [self.UiTextOpenTime2 resignFirstResponder];
    [self.UiTextOpenTime3 resignFirstResponder];
    
}

- (IBAction)Start:(id)sender {
    
    Shot *shot1 = [Shot shotWithValveId:choosenValveOutlet1.selectedSegmentIndex+1 valveDelay:[self.UiTextDelay1.text intValue] valveOpenTime:[self.UiTextOpenTime1.text intValue]];
    Shot *shot2 = [Shot shotWithValveId:choosenValveOutlet2.selectedSegmentIndex+1 valveDelay:[self.UiTextDelay2.text intValue] valveOpenTime:[self.UiTextOpenTime2.text intValue]];
    Shot *shot3 = [Shot shotWithValveId:choosenValveOutlet3.selectedSegmentIndex+1 valveDelay:[self.UiTextDelay3.text intValue] valveOpenTime:[self.UiTextOpenTime3.text intValue]];
    
    //NSLog(@"Es wird Ventil%i ausgelöst nach %ims Ventil%i, dann Ventil%i", shot1.valveId ,shot1.valveDelay , shot2.valveId, shot3.valveId);
    NSLog(@"%i", shot1.uebergabeWert);
    NSLog(@"%i", shot2.uebergabeWert);
    NSLog(@"%i", shot3.uebergabeWert);
}

@end
