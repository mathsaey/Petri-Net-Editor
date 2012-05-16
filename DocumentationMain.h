//
//  DocumentationMain.h
//  Petri Net Editor
//
//  Created by Mathijs Saey on 26/04/12.
//  Copyright (c) 2012 Vrije Universiteit Brussel. All rights reserved.
//

/**
@mainpage
@section Introduction
 This is the main Documentation page of the Petri Net Editor. This documentation was made to make it easier for any developer to understand and expand the Petri Net Editor. The original code of this project was written by Mathijs Saey as part of his 3rd bachelor project at the VUB. This code was based on the kernel provided by Nicolas Cardozo. This project strives to provide the user with a visual representation of context oriented systems at runtime. This visual representation is based on general Petri Nets with inhibitor arcs. 
 The documentation of this project is made by doxygen and thus all documentation comments are made according to the doxygen standard.
 The full project can be found on github at: https://github.com/mathsaey/Petri-Net-Editor 
 
 
@section Overview
 The main point of this documentation is to provide an overview of all the classes in the system. All the classes can be found in the Classes section. The kernel classes are only partly documented by Nicolas Cardozo but are not omitted so that a user of this documentation can still view the public methods and members as well as their inheritance graphs.
 
 The constants that are used throughout the code can be found in the PNEConstants module found in the modules section. These constants don't influence the working of the code but can be used to fine tune the behaviour of the Petri Net drawing.
 
 Somebody new to the code could start by looking at the PNEView class. The PNENodeView class and it's subclasses should be your next focus. Knowing these 4 classes should be enough to get a basic sense of the inner workings of the product.
 
 The general idea is that the PNEView is responsible for the link between the UI and the PNManager. It contains all the PNEViewElement instances and it's responsible for the positioning and creation of those elements. Input that comes from the options bar generally goes through the PNEViewController, although these generally just call some PNEView method. Every PNEViewElement is responsible for drawing itself during the view cycle and for keeping track of the element that it's part off. User interaction with the elements is kept at the PNEViewElement level although some events (that can potentialy affect the entire PNEView) are passed along to the PNEView.
 
 @section Updates
 When updating the kernel a few things should be checked. Obviously the drawing classes should be adjusted depending on the changes to the kernel. Furthermore the PNPlace subclasses copy methods should always return a self pointer by using \code return [self retain] \endcode
 This way the dictionaries that store the arcs in the PNTransition class store an actual reference to the place to connect rather then a copy of that place. The shame should be done for the copy method of the PNArcInscription. This ensures that PNEArcView is drawn correctly.
 
 If new types are added then the PNEView::loadKernel function should also be adjusted accordingly.
 Further adjustments to the drawing code will probably be needed, but this depends on the kernel. Somebody with sufficient knowledge of the code (which can be obtained with the help of this documentation) shouldn't have too much trouble adjusting the code.
  
 @section Todo
 @todo Fix folder browsing in PNEFileViewController
 @todo Add Context wise displaying
 @todo Move strings to constants
 @todo Further transition firing testing
 @todo fix arcs usage in kernel
*/