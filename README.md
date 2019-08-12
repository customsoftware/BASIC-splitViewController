# BASIC-splitViewController
This is a barebones split view controller which enables the following:
1.  Different content in the Master view controller by swapping out Delegate and Data Source classes
2.  Different detail content by swapping out child viewControllers within the detail view controller.
3.  It uses a simplified REDUX model for managing state.
4.  The only area I might do something different on is to annimate the transition from master view to sub-master view.

A crucial lesson in this app is that you NEVER... ever... manage either the master or detail views ouside of the split view controller. Those two views are fixed and permanent. You can swap content out within them, but never change them using splitViewController.showDetail.... When you swap out either child or master views, this will cause display problems when you rotate a device which can have compact and regular views.
