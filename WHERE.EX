-- search the PATH for all occurrences of a file
-- usage:  where filename
-- auto trims trailing slash if you have that in your path var
-- added interactive mode, by double clicking the where program
-- fenir feay 2024 stardust
include file.e

constant TRUE = 1
constant SCREEN = 1, ERROR = 2
constant ext_list = {"", ".com", ".cmd", ".bat",".exe"}
integer g
 g=0
integer x
integer separator, SLASH

if platform() = LINUX then
    SLASH='/'
    separator = ':'
else
    SLASH='\\'
    separator = ';'
end if

sequence path
integer p



function next_dir()
-- get the next directory name from the path sequence   
    sequence dir
    
    if p > length(path) then
	return -1
    end if
    dir = ""
    while p <= length(path) do
	if path[p] = separator then
	    p += 1
	    exit
	end if
	dir &= path[p]
	p += 1
    end while
    if length(dir) = 0 then
	return -1
    end if
    return dir
end function


procedure search_path()
-- main routine
    sequence file, cmd, full_path
    object dir_name, dir_info
    
    cmd = command_line()
	
    if length(cmd) < 3 then
	puts(ERROR, "usage from console: where file\n")	
	puts(1, "What is your query?\n")
	file = gets(0)  -- read standard input (keyboard)
	file = file[1..length(file)-1] -- get rid of \n character at ends
	puts(1, '\n')   -- necessary
	if length(file)<1 then
	abort(1)	
	end if
	g = 2 --used as boolean
	else 
	file = cmd[3]
    end if
    
    path = getenv("PATH")
	
    if atom(path) then
	puts(ERROR, "NO PATH?\n")
	abort(1)
    end if

    if platform() != LINUX then
	path = ".;" & path -- check current directory first
    end if
    
    
	puts(2, "Input:" & file)
	puts(2,  "\n")
	puts(2,  "date time size path file\n")
	x=5
	while x > 0 do
		p = 1
		while TRUE do
		dir_name = next_dir()
		if atom(dir_name) then
			exit
		end if
	
		full_path = dir_name & SLASH & file & ext_list[x]
		dir_info = dir(full_path) 
		if sequence(dir_info) then
			-- file or directory exists
			if length(dir_info) = 1 then
			-- must be a file
			printf(SCREEN, "%4d-%02d-%02d %2d:%02d",dir_info[1][D_YEAR..D_MINUTE])
			printf(SCREEN, "  %d", {dir_info[1][D_SIZE] })
		
			-- fix %path% if had an trailing slash, $ means lenght, and gets lenght of, euphoria is not 0 index so len == last element
				if equal ( {dir_name[$]}, "\\") then 
			-- SLASH keyword does not work here, possibly an atom '\' instead  of object string "\\"
				printf(SCREEN, " %s", {dir_name[1..$-1] }) 
			-- get from frist element to .. last element minus one
				else
				printf(SCREEN, " %s", {dir_name })
				end if
		
			printf(SCREEN, "\\%s\n", {file & ext_list[x]})
			end if
		end if
		end while
	x = x - 1
	end while
end procedure

search_path()
if(g) then --only pause at the end of interactive mode by not using the console
	    if getc(0) then --cause a halt and wait for keyboard input
    end if
	end if