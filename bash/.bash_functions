mkpresentation() {
    # 1. Define the target name from the first argument
    local folder_name=$1

    # Check if a name was actually provided
    if [ -z "$folder_name" ]; then
        echo "Error: Please provide a folder name."
        return 1
    fi

    # 2. Copy the template to the new folder name
    cp -r ~/Templates/beamer "./$folder_name"

    # 3. Change directory into the new folder
    cd "$folder_name" || return

    # 4. Open Neovim at the specific file
    nvim presentation.tex
}
