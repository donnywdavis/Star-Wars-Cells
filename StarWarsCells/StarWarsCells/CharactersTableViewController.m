//
//  CharactersTableViewController.m
//  StarWarsCells
//
//  Created by Donny Davis on 5/4/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "CharactersTableViewController.h"
#import "Character.h"
#import "ResistanceTableViewCell.h"
#import "JediTableViewCell.h"
#import "NewOrderTableViewCell.h"
#import "EmpireTableViewCell.h"
#import "BountyHunterTableViewCell.h"

@interface CharactersTableViewController ()

@property (strong, nonatomic) NSMutableArray *characters;

- (void)loadCharacters;

@end

@implementation CharactersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.characters = [[NSMutableArray alloc] init];
    [self loadCharacters];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load data

- (void)loadCharacters {
    // Let's load our data from our handy dandy json file
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"characters" ofType:@"json"];
    NSArray *charactersArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
    
    // Loop through the array to create Character objects and store in our array
    for (NSDictionary *character in charactersArray) {
        [self.characters addObject:[Character characterWithDictionary:character]];
    }
    
    if (charactersArray) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        self.characters = [[self.characters sortedArrayUsingDescriptors:@[sortDescriptor]] mutableCopy];
        
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.characters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Character *aCharacter = self.characters[indexPath.row];
    
    if ([aCharacter.affiliation isEqualToString:@"Resistance"]) {
        ResistanceTableViewCell *resistanceCell = (ResistanceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ResistanceCell" forIndexPath:indexPath];
        resistanceCell.nameLabel.text = aCharacter.name;
        resistanceCell.descriptionLabel.text = aCharacter.shortDescription;
        return resistanceCell;
        
    } else if ([aCharacter.affiliation isEqualToString:@"Jedi Order"]) {
        JediTableViewCell *jediCell = (JediTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"JediCell" forIndexPath:indexPath];
        jediCell.nameLabel.text = aCharacter.name;
        jediCell.descriptionLabel.text = aCharacter.shortDescription;
        return jediCell;
        
    } else if ([aCharacter.affiliation isEqualToString:@"New Order"]) {
        NewOrderTableViewCell *newOrderCell = (NewOrderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NewOrderCell" forIndexPath:indexPath];
        newOrderCell.nameLabel.text = aCharacter.name;
        newOrderCell.descriptionLabel.text = aCharacter.shortDescription;
        return newOrderCell;
        
    } else if ([aCharacter.affiliation isEqualToString:@"Galactic Empire"]) {
        EmpireTableViewCell *empireCell = (EmpireTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"EmpireCell" forIndexPath:indexPath];
        empireCell.nameLabel.text = aCharacter.name;
        empireCell.descriptionLabel.text = aCharacter.shortDescription;
        return empireCell;
        
    } else if ([aCharacter.affiliation isEqualToString:@"Bounty Hunter"]) {
        BountyHunterTableViewCell *bountyHunterCell = (BountyHunterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BountyHunterCell" forIndexPath:indexPath];
        bountyHunterCell.nameLabel.text = aCharacter.name;
        bountyHunterCell.descriptionLabel.text = aCharacter.shortDescription;
        return bountyHunterCell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell" forIndexPath:indexPath];
    cell.textLabel.text = aCharacter.name;
    cell.detailTextLabel.text = aCharacter.shortDescription;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
