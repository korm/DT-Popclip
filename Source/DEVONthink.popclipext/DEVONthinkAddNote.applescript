tell application id "com.devon-technologies.thinkpro2"
	try
		activate
		
		set theApp to "{popclip app name}"
		
		set theURL to "{popclip browser url}"
		
		if theURL = "" then
			set theURLText to ""
		else
			set theURLText to "URL: " & theURL
		end if
		
		set theHeader to "Clipped on " & ((current date) as string) & return & "From: " & theApp & return & theURLText & return
		
		set theText to theHeader & return & "{popclip text}" as string
		
		set theNotation to text returned of (display dialog theText default answer "" with title "Add a notation (optional)")
		
		if theNotation is not equal to "" then
			set theText to theText & return & return & "Notation: " & theNotation
		end if
		
		set theName to my truncateString("{popclip text}", 30)
		
		set theGroup to display group selector
		
		set theNote to create record with {name:theName, rich text:theText, type:rtf} in theGroup
		
	end try
	
	
	-- the following routine provided by Brett Terpstra
	-- http://brettterpstra.com/2011/01/22/quick-tip-applescript-application-toggle/
	
	set appName to "{popclip app name}"
	set startIt to false
	tell application "System Events"
		if not (exists process appName) then
			set startIt to true
		else if frontmost of process appName then
			set visible of process appName to false
		else
			set frontmost of process appName to true
		end if
	end tell
	if startIt then
		tell application appName to activate
	end if
	
end tell

on truncateString(txt, max)
	set txtLength to (length of txt)
	if txtLength > max then
		set txt to (text 1 thru (max - 1) of txt) & ".txt" as string
	end if
	return txt
end truncateString

