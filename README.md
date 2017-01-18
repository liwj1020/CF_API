##Synopsis
A number of sample programs supplied by Carsten Flensburg which demonstrate how to use various API's. These are all code
samples originally posted to iProdeveloper as part of the Using API's articles. Some of the samples are a collection of commands
and programs which require a special build file for them to be created, the setup script will call the cbx---m.clp if found in the 
directory.

##Purpose
Provide a number of code examples which can be used as utilities on IBM i. The code demonstrates the use of a number of API's.

## Utilities
* 100 - Sample of QDBRTVFD
* ... - More utilities/samples
* 930 - PRTPGMADPS Print Programs which adopt special Authorities.
* 931 - CHGOBJAUT Change Object Authority
* 932 - PRTSAVINF Print Save Information
* 933 - SJLIB Start Journaling for object in a library. Note: STRJRNLIB is now IBM command so rename required. 
* 934 - EJLIB End Journaling for objects in a library. Note: ENDJRNLIB is now IBM command so rename required.
* 935 - RUNJOBCMD Run job Command
* 936 - ANZUSRPRF Analyse User Profiles
* 937 - PRTPTFLVL Print PTF Cum Level
* 938 - PRTJRNRCV Print Journal Receiver Information
* 939 - RTVSYSDTA Retrieve System Data
* 940 - CHKCRPSPT Check cryptographic support
* 943 - PRTJRNRPT Print Journal Report. Note: cbx943.clp submits itself as a job, when its run its calls cbx9432.rpgle
* 944 - PRCOBJLCK Process Object Locks
* 945 - CHGPRFEXIT Change Profile Exit Program
* 946 - Enhanced System Request Menu. NOTE: CBX946S service programs needs setup script to be called with additional parm 'QSRVPGM'
* 947 - CHKPTFSTS Check PTF Status
* 948 - ANZPRFUSG Analyze User Profile Usage
* 949 - PRTREGEXIT Print Registered Exit Programs
* 950 - DSPJOBIFSL Display Job IFS Locks
* 951 - ADDPRNSEED Add Pseudo Random Number Seed
* 952 - PRTJOBRUNA Print Job Run Attributes
* 953 - ADDGRPPRF Add Group Profile
* 954 - RMVGRPPRF Remove Group Profile
* 955 - SCAN Scan string
* 956 - PRTUSRAUTL Print User Authorization list
* 957 - CHGNETUSR Change Netserver Users
* 958 - WRKNETUSR Work with Netserver Users
* 959 - RMVJRNRCV Remove Journal Receivers
* 960 - ADDSVRSHR Add Server Share
* 961 - RMVSVRSHR Remove Server Share
* 962 - CHGSVRSHR Change Server Share
* 963 - DSPSVRSHR Display Server Shares
* 964 - WRKSVRSHR Work Server Shares
* 965 - DSPUSRJOB Display User Job
* 966 - DSPSBSACT Display Subsystem Activity
* 967 - DSDSBSJOBQ Display Subsystem Job Queues
* 968 - DSPJOBQJOB Display Job Queue Jobs
* 969 - WRKJOB2 Work with Job
* 970 - WRKJRN2 Work with journals
* 971 - WRKOUTQAUT Work with Out Queue Authority
* 972 - WRKPRFSECA Work with Profile Security Attributes
* 973 - SETDFTJRN Set Default journal 
* 974 - WRKDFTJRN Work with Default Journal
* 975 - RUNJOBCMD Run Job Command setup and programs
* 976 - RTVJOBITPS,CHGJOBITPS Retrieve/Change Job Interrupt Status
* 977 - WRKJOBS Work with Jobs
* 978 - RTVCMDINF Retrieve Command Information
* 979 - Query Govenor Exit program. Note: Requires CBX980 Service Program.
* 980 - CBX980 Service program used in xxxUSRQRYA command processing programs.
* 982 - Work with User Query Attributes. Note: requires Service Program CBX980 to be built.
* 983 - SETUSRQRYA Set User Query Attributes. Note: menu CMDUSRQRYA requires additional utilities to be built. 
* 984 - UIM Menu CMDSFWAGR. Note: Requires CHKSFWAGR,ACPSFWAGR and ALCLICSPC commands to be built.
* 985 - RMVPNDJOBL Remove Pending Job Log
* 986 - WRKSVRSSN Work with Server Session
* 987 - ENDSVRSSN End Server Session
* 988 - PRTPWDAUD Print Password Audit Report
* 989 - RTVQRYA Retrieve Query Attributes
* 990 - UPDUSRAUD Update User Auditing
* 991 - ADDUSRAUD,RMVUSRAUD Add/Remove User Auditing
* 993 - SETQRYPRFO Set Query Profile Options
* 994 - WRKQRYPRFO Work with Query Profile Opts
* 998 - WRKSBSE Work with Subsystem Entries
* 999 - WRKRMTOUTQ Work with Remote OUTQ's
* 9411 - RTVDIRSMTP Retrieve Directory Entry SMTP Address
* 9412 - DSPDIRSMTP Display Directory Entry SMTP Address
* 9413 - Break message handler, send message to email.
* 9421 - RTVDEVIP Retrieve Device IP
* 9422 - DSPDEVIP Display Device IP
* 9562 - Display User Objects
* 9563 - DSPIDXECNT Display Index Entry Count
* 9811 - ADDUSRQRYA Add User Query Attributes
* 9812 - CHGUSRQRYA Change User Query Attributes
* 9813 - RMVUSRQRYA Remove User Query Attributes
* 9841 - CHKSFWAGR Check Software Agreement
* 9842 - ACPSFWAGR Accept Software Agreement
* 9843 - ALCLICSPC Allocate License Space
* 9951 - WRKRTGE Work with Routing Entries
* 9952 - WRKJOBQE Work job Queue Entries
* 9953 - WRKJOBQJOB Work with Job Queue jobs
* 9961 - WRKPJE Work with Prestart Job Entries
* 9962 - WRKAJE Work with Autostart job Entries
* 9963 - SBMJOBDJOB Submit Job Description Job
* 9971 - WRKCMNE Work with Communication Entries
* 9972 - WRKWSE Work with Workstation Entries
* 9973 - Work with Workstation entries.
* 99A - Query Governor Exit Program Setup

##Build
run the shell script setup in QP2TERM ./cf_api/setup 'api_Number(see above)'. Note: Some of the utilities require additional
utilities to be built to run correctly.

##Documentation
See [IBM Knowledge Center](http://www.ibm.com/support/knowledgecenter/ssw_ibm_i) for details of the API's used.

## Important Notes
* The code should compile using the setup script provided but is based on a naming convention which could be compromised.
* The content has been slimmed down in some cases where the same program is provided in multiple versions.
* Support of the code contained in the samples is not provided by the contributors, you can raise an issue via the github repository requesting help.
* The code has been built over a number of years and may need some adjustment to run on the later OS levels. It is supplied as is with no guarantee to work.
* All of the source in its original state is available from Carsten's website.

##Contributors
* Original code by Carsten Flensburg. [Website](https://spaces.hightail.com/space/00SJA)
* updates and formatting for OSSILE Chris Hird. [Website](http://www.shieldadvanced.com)
   
##Copyright
Copyright (c) OSSILE 2016 Made available under the terms of the license of the containing project   