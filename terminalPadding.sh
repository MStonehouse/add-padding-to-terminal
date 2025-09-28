# If gtk.css doesn't exist then create it using the user supplied input as to how much padding they would like
if [ ! -f ~/.config/gtk-3.0/gtk.css ]; then
	echo "How much padding would you like to add?" 
	echo "14 pixels is the default."
	
	# Get user input for the amount of padding they would like to use 
	read -p "Enter a number between 0 and 30: " padding

	# Trim any leading or trailing whitespace from the input
    padding=$(echo "$padding" | xargs)

	# Check if input is all digits and check range is from 0 to 30
	if echo "$padding" | grep -q '^[0-9]\+$' && [ "$padding" -ge 0 ] && [ "$padding" -le 30 ]; then	
		
    	# .config should exist in every distro so just checking to see if the gtk-3.0 folder exists. If not then it will be created.
		if [ ! -d ~/.config/gtk-3.0 ]; then 
			echo "Folder gtk-3.0 doesn't exist."
			echo "Creating it now."
			mkdir -p ~/.config/gtk-3.0
		fi

    	# Write CSS using a heredoc
    	echo "Adding CSS to gtk-3.0 folder."
    	cat > ~/.config/gtk-3.0/gtk.css <<EOF
VteTerminal, TerminalScreen, vte-terminal {
    padding: ${padding}px ${padding}px ${padding}px ${padding}px; /* Top, Right, Bottom, Left padding */
    -VteTerminal-inner-border: ${padding}px ${padding}px ${padding}px ${padding}px; /* Alternative for older versions/specific cases */
}
EOF

		# Notify user changes have been made
    	echo "Changes have been made."
    	echo "ReBoot is necessary for changes to take place."
    else
    	# User input is inappropriate. Abort process
   		echo "Invalid input. \nProcess aborted."
   	fi
else
	echo "File already exists."
	echo "Process aborted."
	echo "You can add the CSS yourself to the gtk.css file at the path" 
	echo ""
	echo "~/.config/gtk-3.0/gtk.css"
	echo ""
	echo "The code should look something like this."
	echo ""
	echo "VteTerminal, TerminalScreen, vte-terminal {"
    echo "	padding: 14px 14px 14px 14px;"
    echo "	-VteTerminal-inner-border: 14px 14px 14px 14px;"
	echo "}"
	echo ""
	echo "adjust the pixel value to whatever suits you."
fi