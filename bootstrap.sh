# #!/usr/bin/env bash
#
# ##
# # allow writing to usr/local
# echo ""
# echo "------------------------------"
# echo "Allow access to /usr/local for symlinking"
# echo "------------------------------"
# echo ""
# if sudo chown -R `whoami` /usr/local; then
#     echo "Successfully 'sudo chown -R `whoami` /usr/local'! "
# fi
# ##
#
# #cd "$(dirname "${BASH_SOURCE}")";
#
# function setupGithubSSH() {
#     echo ""
#     echo "------------------------------"
#     echo "Setting up git to install everything else"
#     echo "------------------------------"
#     echo ""
#     echo "insalling git"
#     git clone https://github.com/git/git
#     echo "set git globals"
#
#     echo "--> Lists the files in your .ssh directory, if they exist"
#     ls -al ~/.ssh
#     echo "--> Creates a new ssh key, using the provided email as a label"
#     ssh-keygen -t rsa -b 4096 -C "thomasahervey@gmail.com"
#     echo "--> start the ssh-agent in the background"
#     eval "$(ssh-agent -s)"
#     echo "--> Adding your SSH key to the ssh-agent"
#     ssh-add ~/.ssh/id_rsa
#     echo "Copying the contents of the id_rsa.pub file to your clipboard"
#     pbcopy < ~/.ssh/id_rsa.pub
#     echo "Go ahead and add the copied key to Github. To do this... "
#     echo "
#     In the top right corner of any page, click your profile photo, then click SETTINGS.
#     In the user settings sidebar, click SSH keys. Click Add SSH key.
#     In the Title field, add a descriptive label for the new key. ie.'Thomas' MacBook Pro' .
#     Paste your key into the 'Key' field. Click Add key."
#     read -p "When you're finished type: 'Y' " -n 1;
#     echo "";
# }
#
# function initialPull() {
#     echo "Attempting to ssh to GitHub"
#     ssh -T git@github.com
#     read -p "Hopefully there weren't any warnings. Does everything above look okay? When you're finished type: 'Y' " -n 1;
#     if [[ $REPLY =~ ^[Yy]$ ]]; then
#
#         # make .dotfiles folder
#         echo "--> Making ~/Projects/dotfiles folder"
#         mkdir ~/Projects
#         mkdir ~/Projects/dotfiles
#         mkdir ~/Projects/dotfiles/dev-setup && cd ~/Projects/dotfiles/dev-setup
#
#         # intialize git repository
#         echo "--> git init & git remote add origin git@github.com:tomtom92/dev-setup.git"
#         git init && git remote add origin git@github.com:tomtom92/dev-setup.git
#
#         # #initial github grab
# #         echo "--> curl"
# #         curl -#L https://github.com/tomtom92/dev-setup.git
#
#
#         # github pull
#         echo "-->git fetch origin | it pull origin master"
#         git fetch origin;
#         git pull origin master;
#     else
#         echo "--> You selected that there was an error. We have skipped making Projects/dotfiles/dev-setup folder & git init, remote add, cirl, pull.
#         I'd suggest clarifying these details then rerunning."
#     fi;
# }
#
# function pullUpdates() {
#     echo "PULLING UPDATES"
#     git pull
#     # rsync --exclude ".git/" --exclude ".DS_Store" \
#     #     --exclude "README.md" --exclude "LICENSE" -avh --no-perms . ~;
#     source .bash_profile;
# }
#
# if [ "$1" == "--force" -o "$1" == "-f" ]; then
#     pullUpdates;
# else
#     read -p "BOOTSTRAP: This may overwrite existing files in your /Projects/dotfiles directory. Are you sure? (y/n) " -n 1;
#     echo "";
#     if [[ $REPLY =~ ^[Yy]$ ]]; then
#         # if .dotfiles install directory exists, pull updates
#         if [ -d ~/Projects/dotfiles/dev-setup ]; then
#             pullUpdates;
#         # otherwise create directory, and begin setup
#         else
#             read -p "The Projects/dotfiles/dev-setup folder is empty. Is this the first time installing from this repo? (y/n) " -n 1;
#             if [[ $REPLY =~ ^[Yy]$ ]]; then
#
#               read -p "Would you like to set up git & github now? (y/n) " -n 1;
#               if [[ $REPLY =~ ^[Yy]$ ]]; then
#                 #setup intial git ssh keys
#                 setupGithubSSH;
#                 initialPull;
#                 pullUpdates;
#                 cd ~/Projects/dotfiles/dev-setup;
#                 pwd;
#             else
#               echo "doing initial pull and updates without git step."
#                 initialPull;
#                 pullUpdates;
#             fi;
#         fi;
#     fi;
# fi;
# unset pullUpdates;
