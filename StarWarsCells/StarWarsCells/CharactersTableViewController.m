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
@property (strong, nonatomic) NSMutableArray *sectionsArray;
@property (strong, nonatomic) NSMutableArray *affiliations;

- (void)loadCharacters;
- (void)animateTable;

@end

@implementation CharactersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.characters = [[NSMutableArray alloc] init];
    self.sectionsArray = [[NSMutableArray alloc] init];
    self.affiliations = [[NSMutableArray alloc] init];
    [self loadCharacters];
    [self animateTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)animateTable {
    NSArray *cells = self.tableView.visibleCells;
    CGFloat tableHeight = self.tableView.bounds.size.height;
    for (UITableViewCell *cell in cells) {
        cell.transform = CGAffineTransformMakeTranslation(0, tableHeight);
    }
    int index = 0;
    for (UITableViewCell *cell in cells) {
        [UIView animateWithDuration:1.5 delay:(0.05 * (double)index) usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            cell.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:nil];
        index += 1;
    }
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
        NSSortDescriptor *affiliationSort = [[NSSortDescriptor alloc] initWithKey:@"affiliation" ascending:YES];
        NSSortDescriptor *nameSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        self.characters = [[self.characters sortedArrayUsingDescriptors:@[affiliationSort, nameSort]] mutableCopy];
        
        NSMutableArray *placeholderArray = nil;
        for (Character *character in self.characters) {
            if (![self.affiliations containsObject:character.affiliation]) {
                [self.affiliations addObject:character.affiliation];
                if (placeholderArray != nil) {
                    NSDictionary *charactersDictionary = [NSDictionary dictionaryWithObject:placeholderArray forKey:@"data"];
                    [self.sectionsArray addObject:charactersDictionary];
                    placeholderArray = nil;
                }
                placeholderArray = [[NSMutableArray alloc] init];
            }
            [placeholderArray addObject:character];
        }
        if (placeholderArray != nil) {
            NSDictionary *charactersDictionary = [NSDictionary dictionaryWithObject:placeholderArray forKey:@"data"];
            [self.sectionsArray addObject:charactersDictionary];
        }
        
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.affiliations.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *charactersDictionary = [self.sectionsArray objectAtIndex:section];
    NSArray *charactersArray = [charactersDictionary objectForKey:@"data"];
    return charactersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *charactersDictionary = self.sectionsArray[indexPath.section];
    NSArray *charactersArray = [charactersDictionary objectForKey:@"data"];
    Character *aCharacter = charactersArray[indexPath.row];
    
    if ([aCharacter.affiliation isEqualToString:@"Resistance"]) {
        ResistanceTableViewCell *resistanceCell = (ResistanceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ResistanceCell" forIndexPath:indexPath];
        [resistanceCell configureCell:aCharacter];
        return resistanceCell;
        
    } else if ([aCharacter.affiliation isEqualToString:@"Jedi Order"]) {
        JediTableViewCell *jediCell = (JediTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"JediCell" forIndexPath:indexPath];
        [jediCell configureCell:aCharacter];
        return jediCell;
        
    } else if ([aCharacter.affiliation isEqualToString:@"New Order"]) {
        NewOrderTableViewCell *newOrderCell = (NewOrderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NewOrderCell" forIndexPath:indexPath];
        [newOrderCell configureCell:aCharacter];
        return newOrderCell;
        
    } else if ([aCharacter.affiliation isEqualToString:@"Galactic Empire"]) {
        EmpireTableViewCell *empireCell = (EmpireTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"EmpireCell" forIndexPath:indexPath];
        [empireCell configureCell:aCharacter];
        return empireCell;
        
    } else if ([aCharacter.affiliation isEqualToString:@"Bounty Hunter"]) {
        BountyHunterTableViewCell *bountyHunterCell = (BountyHunterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BountyHunterCell" forIndexPath:indexPath];
        [bountyHunterCell configureCell:aCharacter];
        return bountyHunterCell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell" forIndexPath:indexPath];
    cell.textLabel.text = aCharacter.name;
    cell.detailTextLabel.text = aCharacter.shortDescription;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.affiliations[section];
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
