//
//  PNParserConstants.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 10/05/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

// This file contains the parser constants

/**
 @defgroup PNParserConstants
 This group contains all the constants used in the parser code.
 These constants are grouped seperatly to make it easier to use
 the parser as a standalone application.
 This also makes it easier to change the parser syntax.
 What follows is an example of the current parser syntax.
 
 @code
 
 #This is a comment
 
 Contexts:  #This marks the start of the contexts section

 Context1  #This will add a context name context 1
 Context2
 Context3
 Context4
 Context5
 Context6
 Context7
 BoundedContext,5 #This will create a context named boundedcontext with capacity 5
 
 Links: #This marks the start of the links section
 
 Context1 -> Context2 #This creates a weak inclusion
 Context3 => Context4 #This creates a strong inclusion
 Context5 >< Context1 #This creates an exclusion
 Context6 =< Context7 #This creates a requirement relation
 
 END
 
 @endcode
 
 @{
 */

extern NSString *COMMENT_TOKEN; /**< Token used to mark comments. Anything on the same line behind this token will be ignored by the parser. */

extern NSString *END_INDICATOR; /**< Token used to indicate the end of the declaration, everything behind this will be ignored. */
extern NSString *CONTEXT_INDICATOR; /**< Token used to indiciate the start of the context declaration. */
extern NSString *LINK_INDICATOR; /**< Token used to indicate the start of the link section. */

extern NSString *WEAK_INCLUSION_TOKEN; /**< Token used to indicate a weak inclusion */
extern NSString *STRONG_INCLUSION_TOKEN; /**< Token used to indicate a strong inclusion */
extern NSString *EXCLUSION_TOKEN; /**< Token used to indicate an exclusion */
extern NSString *REQUIREMENT_TOKEN; /**< Token used to indicate a requirement relation */

extern NSString *CONTEXT_SEPERATOR; /**< Token used to seperate context name and capacity */

///@}