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

#import "TextViewTableCell.h"

@interface TextViewTableCell ()

@property (nonatomic, assign) id<TextViewTableCellDelegate>	delegate;

@end


@implementation TextViewTableCell

@synthesize delegate, textView, indexPath, limit;

- (id)initWithDelegate:(id<TextViewTableCellDelegate>)theDelegate reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
		self.delegate = theDelegate;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.textView = [[UITextView alloc] initWithFrame:CGRectInset(self.contentView.frame, 10, 10)];
		self.textView.delegate = self;
		self.textView.textAlignment = UITextAlignmentCenter;
		self.textView.autocorrectionType = UITextAutocorrectionTypeNo;
		self.textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
		self.textView.userInteractionEnabled = YES;
		self.textView.textAlignment = UITextAlignmentCenter;
		self.textView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		self.textView.autocorrectionType = UITextAutocorrectionTypeNo;
		self.textView.autocapitalizationType = UITextAutocapitalizationTypeSentences;
		self.textView.font = [UIFont boldSystemFontOfSize:18];
		self.textView.backgroundColor = self.contentView.backgroundColor;
		[self.contentView addSubview:self.textView];
	}
    return self;
}

- (void)dealloc {
	delegate = nil;
	[textView release];
	[indexPath release];
    [super dealloc];
}

- (void) showKeyboard {
	[self.textView becomeFirstResponder];
}

- (void) hideKeyboard {
	[self.textView resignFirstResponder];
}

- (void) setPlaceholder:(NSString *)placeholder {
	//TODO implement UITextView placeholder
}

- (void)textViewDidBeginEditing:(UITextView *)theTextView {
	[theTextView becomeFirstResponder];
	SEL selector = @selector(textViewFocussed:indexPath:);
	if (self.delegate != NULL && [self.delegate respondsToSelector:selector]) {
		[self.delegate textViewFocussed:self indexPath:self.indexPath];
	}
}

- (void)textViewDidEndEditing:(UITextView *)theTextView {
	[theTextView resignFirstResponder];
	SEL selector = @selector(textViewReturned:indexPath:text:);
	if (self.delegate != NULL && [self.delegate respondsToSelector:selector]) {
		[self.delegate textViewReturned:self indexPath:self.indexPath text:theTextView.text];
	}
}

- (BOOL)textView:(UITextView *)theTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)string {
	if ([string isEqualToString:@"\n"]) {
		[theTextView resignFirstResponder];
		return YES;
	}
	NSString *message = [theTextView.text stringByReplacingCharactersInRange:range withString:string];
	if (self.limit == 0 || self.limit >= [message length]) {
		SEL selector = @selector(textViewChanged:indexPath:text:);
		if (self.delegate != NULL && [self.delegate respondsToSelector:selector]) {
			[self.delegate textViewChanged:self indexPath:self.indexPath text:message];
		}
		return YES;	
	}
	else {
		return NO;
	}
}

- (void)textViewDidChange:(UITextView *)theTextView {
	SEL selector = @selector(textViewChanged:indexPath:text:);
	if (self.delegate != NULL && [self.delegate respondsToSelector:selector]) {
		[self.delegate textViewChanged:self indexPath:self.indexPath text:theTextView.text];
	}
}

- (void) setText:(NSString *)theText {
	self.textView.text = theText;
}

- (NSString *) getText {
	return self.textView.text;
}

@end