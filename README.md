# fslogix
Tools und Scripte zu FSLogix
  
Just configure the value  
https://docs.microsoft.com/en-us/fslogix/profile-container-configuration-reference#redirxmlsourcefolder
  
Instructions on how to configure this can be found here:  
https://social.msdn.microsoft.com/Forums/windows/en-US/029e130e-5892-4d1f-88a7-f8046d78f3b0/using-redirectionsxml-to-configure-what-to-copy-to-a-profile-with-fslogix

0 = No files copied in or out. (Note: the copy tag may be left out entirely and the action will be the same as setting to 0.  
Only the folder(s) are created on the local_<user_name> directory.  
  
1 = Copy files to base  
Any existing file in an excluded folder will be copied to base.  
  
2 = Copy files back to virtual profile  
Any modified file in base will be copied back to profile on user logout.  
  
3 = Files are copied from/to base.  
Combinations options 1 and 2.  
