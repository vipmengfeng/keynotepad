//
//  tableViewController.m
//  FeiFeikey
//
//  Created by meng on 13-12-6.
//  Copyright (c) 2013年 meng. All rights reserved.
//

#import "tableViewController.h"
@interface tableViewController ()

@end

@implementation tableViewController
//@synthesize list=_list;
NSArray *list;
NSArray * searchResults;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    list = [[NSArray alloc] initWithObjects:@"223", @"bb",@"111", @"2222", @"dd", @"ddd",nil];
    
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@", searchText];
    
    searchResults = [list filteredArrayUsingPredicate:resultPredicate];
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];

    return YES;
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        
        return [list count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:TableSampleIdentifier];
        
        UILabel *Datalabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 320, 44)];
        [Datalabel setTag:100];
        Datalabel.autoresizingMask =UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:Datalabel];
    }
    
    
    if (tableView ==self.searchDisplayController.searchResultsTableView){
        cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
        
    } else {
        NSUInteger row = [indexPath row];
        cell.textLabel.text = [list objectAtIndex:row];
        
        UIImage *image = [UIImage imageNamed:@"qq"];
        cell.imageView.image = image;
        UIImage *highLighedImage = [UIImage imageNamed:@"youdao"];
        cell.imageView.highlightedImage = highLighedImage;
        cell.detailTextLabel.text = @"fffff";
        
        UILabel *Datalabel = (UILabel *)[cell.contentView viewWithTag:100];
        [Datalabel setFont:[UIFont boldSystemFontOfSize:18]];
        Datalabel.text = @"ccccccc";
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [list objectAtIndex:indexPath.row];
    }
    
    
	return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *rowString = [list objectAtIndex:[indexPath row]];
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"选中的行信息" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
