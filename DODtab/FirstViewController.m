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

#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#define PORT 1234


@implementation FirstViewController
@synthesize UiTextDelay1;
@synthesize UiTextDelay2;
@synthesize UiTextDelay3;
@synthesize UiTextOpenTime1;
@synthesize UiTextOpenTime2;
@synthesize UiTextOpenTime3;
@synthesize choosenValveOutlet1;
@synthesize choosenValveOutlet2;
@synthesize choosenValveOutlet3;
@synthesize UiFlashDelay;



//Bei Enter wird die Tastatur ausgeblendet------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.UiTextDelay1 resignFirstResponder];
    [self.UiTextDelay2 resignFirstResponder];
    [self.UiTextDelay3 resignFirstResponder];
    [self.UiTextOpenTime1 resignFirstResponder];
    [self.UiTextOpenTime2 resignFirstResponder];
    [self.UiTextOpenTime3 resignFirstResponder];
    [self.UiFlashDelay resignFirstResponder];
    
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
    [self setUiFlashDelay:nil];
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
    [self.UiFlashDelay resignFirstResponder];
    
}

- (IBAction)Start:(id)sender {
    
    Shot *shot1 = [Shot shotWithValveId:choosenValveOutlet1.selectedSegmentIndex+1 valveDelay:[self.UiTextDelay1.text intValue] valveOpenTime:[self.UiTextOpenTime1.text intValue]];
    Shot *shot2 = [Shot shotWithValveId:choosenValveOutlet2.selectedSegmentIndex+1 valveDelay:[self.UiTextDelay2.text intValue] valveOpenTime:[self.UiTextOpenTime2.text intValue]];
    Shot *shot3 = [Shot shotWithValveId:choosenValveOutlet3.selectedSegmentIndex+1 valveDelay:[self.UiTextDelay3.text intValue] valveOpenTime:[self.UiTextOpenTime3.text intValue]];
    
    //NSLog(@"Es wird Ventil%i ausgelöst nach %ims Ventil%i, dann Ventil%i", shot1.valveId ,shot1.valveDelay , shot2.valveId, shot3.valveId);
    /*
    NSLog(@"%i", shot1.uebergabeWert);
    NSLog(@"%i", shot2.uebergabeWert);
    NSLog(@"%i", shot3.uebergabeWert);
    */
     
    NSString *transmit = [NSString stringWithFormat:@"%i %i %i %i %i %i %i %i %i %i",shot1.valveId, shot1.valveDelay, shot1.valveOpenTime, shot2.valveId, shot2.valveDelay,shot2.valveOpenTime, shot3.valveId, shot3.valveDelay,shot3.valveOpenTime,[self.UiFlashDelay.text intValue]];
    
    NSLog(@"%@", transmit);
    
    /*/ ------------- Daten Senden durch Socket "s" ----------    
    
    int s;
    struct sockaddr_in cli;
    struct hostent *server;
    char str [2048];    // puffer probleme durch gesamtsring?
    server = gethostbyname("192.168.7.30");
    bzero(&cli, sizeof(cli));
    cli.sin_family = AF_INET;
    cli.sin_addr.s_addr = htonl(INADDR_ANY);
    cli.sin_addr.s_addr = ((struct in_addr *) \
                           (server->h_addr))->s_addr;
    cli.sin_port = htons(PORT);
    s = socket(AF_INET, SOCK_STREAM, 0);
    connect(s, (void *)&cli, sizeof(cli));
    strcpy(str, [transmit UTF8String]);
    strcat(str, "\n");
    NSLog (@"%@",transmit);
    write(s, str, strlen(str));
    
    
    //--------------- Daten empfangen durch Socket "s" -------------    
    
    char buff[2048];   // puffer probleme durch gesamtsring?
    unsigned int count; 
    int recvVar1, recvVar2, recvVar3, recvVar4, recvVar5;  //recvVar5 wird von iPhone immer 1 sein, da es auf Arduino Seite als Start der Anlage dient, und danach auf Arduinoseite wieder auf 0 gesetzt wird.
    listen(s, 5);
    count = recv(s, buff, sizeof(buff)-1, 0);   
    NSLog (@"%i",count);
    NSString *stringEmpfangen = [NSString stringWithUTF8String:buff];
    NSLog (@"%@",stringEmpfangen);
    sscanf(buff, "%d %d %d %d %d", &recvVar1, &recvVar2, &recvVar3, &recvVar4, &recvVar5);
    NSLog (@"gesetzter Wert 1: %i", recvVar1);
    NSLog (@"gesetzter Wert 2: %i", recvVar2);
    NSLog (@"gesetzter Wert 3: %i", recvVar3);
    NSLog (@"gesetzter Wert 4: %i", recvVar4);
    NSLog (@"gesetzter Wert 5: %i", recvVar5);
    
    /
    self.tropfenAnzahlAusgabe.text = [NSString stringWithFormat:@"arVar 1: %i", recvVar1];
    self.tropfenZeitAusgabe.text = [NSString stringWithFormat:@"arVar 2: %i", recvVar2];
    self.tropfenGroesseAusgabe.text = [NSString stringWithFormat:@"arVar 3: %i", recvVar3];
    self.blitzZeitAusgabe.text = [NSString stringWithFormat:@"arVar 4: %i", recvVar4];
    
    close(s);  
    
    */
    

}

@end
