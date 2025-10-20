import re

#### Script to clean the MANUAL version of the updater

# Add strings to remove them from the file
unwanted_phrases = [
    # Static patterns

    r"Reading package lists...",
    r"Building dependency tree...",
    r"Reading state information...",

    r"\s*We strongly recommend moving to the latest stable version of the Platform and SDK\s*com.obsproject.Studio\s*",
    r"We strongly recommend moving to the latest Qt 5.15-based stable version of the Platform and SDK\s*org.cubocore.CoreKeyboard\s*",
    r"The GNOME 45 runtime is no longer supported as of September 18, 2024. Please ask your application developer to migrate to a supported platform.\s*",
    r"com.github.eneshecan.WhatsAppForLinux, org.x.Warpinator\s*",
    r"org.freedesktop.Platform 22.08 is no longer receiving fixes and security updates. Please update to a supported runtime version.\s*",
    r"org.cubocore.CoreKeyboard\s*",
    r"org.freedesktop.Platform 22.08 is no longer receiving fixes and security updates. Please update to a supported runtime version.\s*",
    r"org.cubocore.CoreKeyboard\s*",
    r"This application has been delisted.\s*",
    r"com.github.eneshecan.WhatsAppForLinux\s*",
    r"This application has been delisted\s*",
    r"We strongly recommend moving to the latest stable version of the Platform and SDK\s*",
    r"com.obsproject.Studio\s*",
    r"We strongly recommend moving to the latest Qt 5.15-based stable version of the Platform and SDK\s*",
    r"Use 'sudo apt autoremove' to remove them.",
    r"The following packages will be REMOVED:",
    r"The following packages will be upgraded:",
    r"Calculating upgrade...",
    r"Looking for updates…",
    r"Use 'sudo apt autoremove' to remove it.",

    # deletes ALL matches *%
    r"\(Reading database \.\.\. .*%",
    r"\(Reading database \.\.\.",

    r"Updating[\s\S]*",
    
    r"Installing[\s\S]*",

    r"Processing triggers[\s\S]*",

    r"Setting up[\s\S]*",

    r"Unpacking[\s\S]*",

    r"Preparing to unpack[\s\S]*",

    r"Fetched[\s\S]*",

    r"debconf[\s\S]*",

    r"De-configuring[\s\S]*",

    r"Selecting previously unselected package[\s\S]*",

    # r"Found initrd image[\s\S]*",
    # r"Found linux image[\s\S]*",
    
    # r"Removing linux-tools[\s\S]*",
    # r"Removing linux-modules[\s\S]*",
    # r"Warning: Removing magic mime rule from exports",

    r"   The GNOME[\s\S]*",

    r"WARNING: apt does not have a stable CLI interface. Use with caution in scripts.",


    r"After this operation, 0 B of additional disk space will be used.",
    r"After this operation, 0 B of additional disk space will be freed.",

    r"WARNING: icon cache generation failed",
    r"gtk-update-icon-cache: No theme index file.",
    r"Removing /usr/bin/evince symbolic link.",
    r"/usr/bin/evince not found, providing symlink.",
    r"   net.christianbeier.Gromit-MPX"



]





# Define input and output file paths
input_log_file = "/home/federico/Nextcloud/Linux/log/manual_updater.txt" 


#### Overwrite
#output_log_file ='/home/federico/Nextcloud/Linux/log/startup_updater_test.txt'  
output_log_file = input_log_file  





#######################################################################
#######################################################################
#######################################################################


# Regex patterns for matching lines that start with "Hit:", "Get:", or "Ign:, or Info:"
dynamic_patterns = [re.compile(r'^(Hit:|Get:|Ign:|Info:)')]

# Function to dynamically add "Hit:", "Get:", "Ign: and Info:" lines to unwanted_phrases
def add_dynamic_lines_to_unwanted(input_file):
    with open(input_file, 'r') as file:
        lines = file.readlines()

    # Add lines starting with "Hit:", "Get:", "Ign: or Info:" to unwanted_phrases
    global unwanted_phrases
    for line in lines:
        if any(pattern.match(line) for pattern in dynamic_patterns):
            unwanted_phrases.append(re.escape(line.strip()))

# Function to clean the log file
def clean_log_file(input_file, output_file):
    # Read the original file
    with open(input_file, 'r') as file:
        lines = file.readlines()

    # Compile regex pattern for matching unwanted lines
    pattern = re.compile('|'.join(unwanted_phrases))

    # Filter out unwanted lines
    filtered_lines = [line for line in lines if not pattern.search(line)]


    # Combine lines into a single string
    content = ''.join(filtered_lines)
    
    # Replace multiple newlines with a single newline
    cleaned_content = re.sub(r'\n+', '\n', content)
    #cleaned_content = content 


    # Write the cleaned content to the output file
    with open(output_file, 'w') as file:
        
        ## retain new lines
        #file.writelines(filtered_lines)
        
        ## replace multi new lines with just one
        file.write(cleaned_content)

# Add dynamic lines ("Hit:", "Get:", "Ign:") to unwanted_phrases
add_dynamic_lines_to_unwanted(input_log_file)

# Clean the log file
clean_log_file(input_log_file, output_log_file)

# Uncomment to debug the cleaned log file path
# print(f"Cleaned log file saved to: {output_log_file}")
