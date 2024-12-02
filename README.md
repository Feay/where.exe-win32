# where.exe-win32

the classic where command with better output plus interactive mode!
compiled? as win32, works on 98 thru win10+ made with euphoria 3.
tested with winXP and win10
((Note that to my expierance with win10 I had to use the windows folder which gets checked before system32, if you already have where that sucks and can't be bothered to side load files into system32)) You could or should put it anywhere that is in your path enviroment varabiles, as seen in control panel > system > adavanced > enviroment varables

SMAPLE USEAGE FROM COMMAND PROMPT:
F:\EUPHORIA\BIN>where where
Input:where
date time size path file
2024-12-02  7:35  70666 .\where.exe
2024-11-08  2:16  70666 C:\WINDOWS\where.exe

SAMPLE USAGE AS A POPUP WHEN CLICKIG THE PROGRAM:
usage from console: where file
What is your query?
where
Input:where
date time size path file
2024-12-02  7:35  70666 .\where.exe
2019-12-07  2:10  33280 C:\WINDOWS\system32\where.exe
2024-11-08  2:16  70666 C:\WINDOWS\where.exe

how to build this??
i have put the important files in this repo, place them into your euphoria\bin folder, and make sure that
euphoria is a envrioment varible and in your path var.
next it's convoluted but frist you bind the .ex script that makes an exe but it doesn't work for the console, so next you open the console in the bin folder and spacificly type makecon.exe filename.exe of the ex file you just used bind on (asssuming bind exw), this then makes a third file in addition to the ex and exe files, with a filename.c.exe name, now you have a working windows and windows console mode program. I made makecon my self makecon or mkc.ex does the same thing as euphoria's stock file that makes ewx.exe into ewxc.exe but now it takes any file as input.
this is using euphoria 3.0 unzipped into a folder on my root of my drive. 
good luck.

