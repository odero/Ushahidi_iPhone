/*****************************************************************************
 ** Copyright (c) 2010 Ushahidi Inc
 ** All rights reserved
 ** Contact: team@ushahidi.com
 ** Website: http://www.ushahidi.com
 **
 ** GNU Lesser General Public License Usage
 ** This file may be used under the terms of the GNU Lesser
 ** General Public License version 3 as published by the Free Software
 ** Foundation and appearing in the file LICENSE.LGPL included in the
 ** packaging of this file. Please review the following information to
 ** ensure the GNU Lesser General Public License version 3 requirements
 ** will be met: http://www.gnu.org/licenses/lgpl.html.
 **
 **
 ** If you have questions regarding the use of this file, please contact
 ** Ushahidi developers at team@ushahidi.com.
 **
 *****************************************************************************/

#import <UIKit/UIKit.h>
#import "TableViewController.h"
#import "Ushahidi.h"
#import "MapDialog.h"
#import "Locator.h"
#import "ItemPicker.h"

@interface DeploymentAddViewController : TableViewController<UshahidiDelegate, 
															 MapDialogDelegate, 
															 LocatorDelegate, 
															 ItemPickerDelegate> {
	
@public
	UIBarButtonItem *cancelButton;
	UIBarButtonItem *refreshButton;
	UISegmentedControl *tableSort;
	
@private
	NSString *name;
	NSString *url;
	MapDialog *mapDialog;
	ItemPicker *itemPicker;
	NSString *mapDistance;
}

@property(nonatomic, retain) IBOutlet UIBarButtonItem *cancelButton;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *refreshButton;
@property(nonatomic, retain) IBOutlet UISegmentedControl *tableSort;

- (IBAction) cancel:(id)sender;
- (IBAction) add:(id)sender;
- (IBAction) refresh:(id)sender event:(UIEvent*)event;
- (IBAction) tableSortChanged:(id)sender;

@end
