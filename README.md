# BASIC-splitViewController
This is a barebones split view controller which enables the following:
1.  Different content in the Master view controller by swapping out different table view controllers.
2.  Different detail content by swapping out child viewControllers within the detail view controller.
3.  It uses a simplified REDUX model for managing state.
4.  Effective and safe alternatives to a navigation controller in the master view is either a tab bar controller or change content by swapping out datasource/delegates.

A crucial lesson in this app is that you NEVER... ever... manage either the master or detail views ouside of the split view controller. Those two views are fixed and permanent. You can swap content out within them, but never use the navigation controllers to change content.
