Vim�UnDo� �t��^�8t�i(��4/TjF�Y.�d�I�2�   �   set OPENCV_LOG_LEVEL ERROR   q         C       C   C   C    _�Ē    _�                     N        ����                                                                                                                                                                                                                                                                                                                                                             _�~0     �   N   S   c       �   N   P   b    5�_�                    P        ����                                                                                                                                                                                                                                                                                                                                                             _�~2     �   R   U   i       �   S   T   i    �   P   T   g       �   Q   R   g    �   O   R   f       5�_�                    R        ����                                                                                                                                                                                                                                                                                                                                                             _�~q     �   R   T   k       �   S   T   k    �   R   T   j    5�_�                    T        ����                                                                                                                                                                                                                                                                                                                            T          U          V       _�~s     �   S   T          set -Ux PYENV_ROOT $HOME/.pyenv   8set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths5�_�                    S        ����                                                                                                                                                                                                                                                                                                                            T          T          V       _�~t     �   R   T   i    5�_�                    T        ����                                                                                                                                                                                                                                                                                                                            U          U          V       _�~~     �   T   V   k       �   T   V   j    5�_�                    S        ����                                                                                                                                                                                                                                                                                                                            V          V          V       _�~�     �   R   S           5�_�      	              W        ����                                                                                                                                                                                                                                                                                                                            W           \           V        _�~�     �   V   W           export PYENV_ROOT="$HOME/.pyenv"   #export PATH="$PYENV_ROOT/bin:$PATH"   *if command -v pyenv 1>/dev/null 2>&1; then     eval "$(pyenv init -)"   fi   !eval "$(pyenv virtualenv-init -)"5�_�      
           	   V        ����                                                                                                                                                                                                                                                                                                                            W           W           V        _�~�     �   U   V           5�_�   	              
   V        ����                                                                                                                                                                                                                                                                                                                            V           V           V        _�~�     �   U   V           5�_�   
                 O        ����                                                                                                                                                                                                                                                                                                                            O           P                   _�~�     �   N   Q   b           5�_�                    O        ����                                                                                                                                                                                                                                                                                                                            O           P                   _�~�     �   N   O           5�_�                    O        ����                                                                                                                                                                                                                                                                                                                            O           O                   _�~�    �   N   O           5�_�                    ]        ����                                                                                                                                                                                                                                                                                                                                                             _�~�    �   \   ^          colorscript random5�_�                    ]        ����                                                                                                                                                                                                                                                                                                                                                             _�~�    �   \   ^          # colorscript random5�_�                    N        ����                                                                                                                                                                                                                                                                                                                            N           R           V        _� �     �   M   N          ### configure pyenv path   set -Ux PYENV_ROOT $HOME/.pyenv   8set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths   pyenv init - | source    pyenv virtualenv-init - | source5�_�                    [        ����                                                                                                                                                                                                                                                                                                                            N           N           V        _� �     �   [            �   [            5�_�                    \        ����                                                                                                                                                                                                                                                                                                                            N           N           V        _� �    �   [   ^   a       �   [   ]   `    5�_�                    _        ����                                                                                                                                                                                                                                                                                                                            b           _           V        _�    �   a   c           pyenv virtualenv-init - | source�   `   b          pyenv init - | source�   _   a          8set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths�   ^   `          set -Ux PYENV_ROOT $HOME/.pyenv5�_�                            ����                                                                                                                                                                                                                                                                                                                            H                      V        _�e    �   G   I          end�   F   H              end�   E   G                  command cp $argv�   D   F              else�   C   E                  command cp -r $from $to�   B   D          	set to (echo $argv[2])�   A   C          (	set from (echo $argv[1] | trim-right /)�   @   B          0    if test "$count" = 2; and test -d "$argv[1]"�   ?   A          &    set count (count $argv | tr -d \n)�   >   @          function copy�   =   ?          7# result: copies the directory and all of its contents.�   <   >          # ex: copy DIRNAME LOCATIONS�   ;   =          ?# Function for copying files and directories, even recursively.�   :   <           �   9   ;          end�   8   :              cp $filename $filename.bak�   7   9          #function backup --argument filename�   6   8          %# result: copies file as file.txt.bak�   5   7          # ex: backup file.txt�   4   6          %# Function for creating a backup file�   3   5           �   2   4          end�   1   3          .  bind '$' __history_previous_comman_arguments�   0   2          #  bind ! __history_previous_command�   /   1          else�   .   0          8  bind -Minsert '$' __history_previous_command_arguments�   -   /          ,  bind -Minsert ! __history_previous_command�   ,   .          1if [ $fish_key_bindings = fish_vi_key_bindings ];�   +   -          # The bindings for !! and !$�   *   ,          end�   )   +            end�   (   *              commandline -i '$'�   '   )          
  case "*"�   &   (          0    commandline -f history-token-search-backward�   %   '              commandline -t ""�   $   &          
  case "!"�   #   %            switch (commandline -t)�   "   $          -function __history_previous_command_arguments�   !   #           �       "          end�      !            end�                     commandline -i !�                
  case "*"�                6    commandline -t $history[1]; commandline -f repaint�                
  case "!"�                  switch (commandline -t)�                #function __history_previous_command5�_�                    _        ����                                                                                                                                                                                                                                                                                                                            _           `           V        _�]    �   _   a          :# set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths�   ^   `          !# set -Ux PYENV_ROOT $HOME/.pyenv5�_�                    a        ����                                                                                                                                                                                                                                                                                                                                                             _��    �   `   b          # pyenv init - | source5�_�                    b        ����                                                                                                                                                                                                                                                                                                                                                             _��   	 �   a   c          "# pyenv virtualenv-init - | source5�_�                    a        ����                                                                                                                                                                                                                                                                                                                                                             _�   
 �   `   b          pyenv init - | source5�_�                    b        ����                                                                                                                                                                                                                                                                                                                                                             _��    �   a   c           pyenv virtualenv-init - | source5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       _�Ľ     �                set fish_color_param brcyan�                set fish_color_error '#ff6c6b'�                set fish_color_command brcyan�                'set fish_color_autosuggestion '#7d7d7d'�                set fish_color_normal brcyan5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       _�ľ     �      1   c       �         c    �         b    5�_�                           ����                                                                                                                                                                                                                                                                                                                            0                            _���    �      1   }      $ set -L   !$ set -U fish_color_normal normal   "$ set -U fish_color_command c397d8    $ set -U fish_color_quote b9ca4a   &$ set -U fish_color_redirection 70c0b1   $ set -U fish_color_end c397d8    $ set -U fish_color_error d54e53    $ set -U fish_color_param 7aa6da   ?$ set -U fish_color_selection white --bold --background=brblack   >$ set -U fish_color_search_match bryellow --background=brblack   *$ set -U fish_color_history_current --bold   #$ set -U fish_color_operator 00a6b2   !$ set -U fish_color_escape 00a6b2   $ set -U fish_color_cwd green    $ set -U fish_color_cwd_root red   *$ set -U fish_color_valid_path --underline   )$ set -U fish_color_autosuggestion 969896    $ set -U fish_color_user brgreen   $ set -U fish_color_host normal   $ set -U fish_color_cancel -r   +$ set -U fish_pager_color_completion normal   3$ set -U fish_pager_color_description B3A06D yellow   9$ set -U fish_pager_color_prefix white --bold --underline   <$ set -U fish_pager_color_progress brwhite --background=cyan   -$ set -U fish_color_match --background=brblue   "$ set -U fish_color_comment e7c547   !$ set -U fish_color_normal normal5�_�                            ����                                                                                                                                                                                                                                                                                                                            0                            _���    �                set -L5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             _�Ɩ    �                ?set TERM "xterm-256color"              # Sets the terminal type5�_�      !                       ����                                                                                                                                                                                                                                                                                                                                                             _���     �                A# set TERM "xterm-256color"              # Sets the terminal type5�_�       #           !           ����                                                                                                                                                                                                                                                                                                                                                             _���    �                ?set TERM "xterm-256color"              # Sets the terminal type5�_�   !   $   "       #           ����                                                                                                                                                                                                                                                                                                                                                             _�ȧ     �      
   ~       �      	   }    5�_�   #   %           $   	       ����                                                                                                                                                                                                                                                                                                                                                             _�ȹ    �      
         set -U LX_COLOR�   	   
       5�_�   $   &           %   	        ����                                                                                                                                                                                                                                                                                                                                                             _���     �      	          eset -U LX_COLOR 'di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'5�_�   %   '           &   	        ����                                                                                                                                                                                                                                                                                                                                                             _���    �      	           5�_�   &   (           '   z        ����                                                                                                                                                                                                                                                                                                                            {   7       {           v        _�2�     �   y   {          set -Ux PYENV_ROOT $HOME/.pyenv5�_�   '   *           (   {        ����                                                                                                                                                                                                                                                                                                                                                             _�2�    �   z   |          8set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths5�_�   (   +   )       *   z        ����                                                                                                                                                                                                                                                                                                                            {   7       {           v        _�3X     �   z   |   }    �   z   {   }    5�_�   *   ,           +   |        ����                                                                                                                                                                                                                                                                                                                            |   7       |           v        _�3Y     �   |   ~   ~    �   |   }   ~    5�_�   +   -           ,   {        ����                                                                                                                                                                                                                                                                                                                            |   7       |           v        _�3[     �   z   {          !# set -Ux PYENV_ROOT $HOME/.pyenv5�_�   ,   .           -   {        ����                                                                                                                                                                                                                                                                                                                            {   7       {           v        _�3\     �   {   }   ~    �   {   |   ~    5�_�   -   /           .   |        ����                                                                                                                                                                                                                                                                                                                            {   7       {           v        _�3^     �   {   }          !# set -Ux PYENV_ROOT $HOME/.pyenv5�_�   .   0           /   }        ����                                                                                                                                                                                                                                                                                                                            {   7       {           v        _�3_     �   |   ~          :# set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths5�_�   /   1           0   |       ����                                                                                                                                                                                                                                                                                                                            {   7       {           v        _�3b     �   {   }         set -Ux PYENV_ROOT $HOME/.pyenv5�_�   0   2           1   }       ����                                                                                                                                                                                                                                                                                                                            {   7       {           v        _�3m     �   |   ~         8set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths5�_�   1   3           2   }       ����                                                                                                                                                                                                                                                                                                                            {   7       {           v        _�3r     �   |   ~         4set fish_user_paths $PYENV_ROOT/bin $fish_user_paths5�_�   2   4           3   }   )    ����                                                                                                                                                                                                                                                                                                                            {   7       {           v        _�3y     �   |   ~         )set PATH $PYENV_ROOT/bin $fish_user_paths5�_�   3   5           4           ����                                                                                                                                                                                                                                                                                                                            {   7       {           v        _�3�     �                Kset -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths5�_�   4   6           5           ����                                                                                                                                                                                                                                                                                                                            {   7       {           v        _�3�     �             �             5�_�   5   7           6           ����                                                                                                                                                                                                                                                                                                                            |   7       |           v        _�3�     �                M# set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths5�_�   6   8           7      K    ����                                                                                                                                                                                                                                                                                                                            |   7       |           v        _�3�     �         �      Kset -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths5�_�   7   9           8          ����                                                                                                                                                                                                                                                                                                                            |   7       |           v        _�3�     �         �      Aset -U fish_user_paths $HOME/.local/bin $HOME/Applications $PATHS5�_�   8   :           9      2    ����                                                                                                                                                                                                                                                                                                                            |   7       |           v        _�3�    �         �      2set ATH $HOME/.local/bin $HOME/Applications $PATHS5�_�   9   ;           :          ����                                                                                                                                                                                                                                                                                                                                                             _�3�    �         �      1set ATH $HOME/.local/bin $HOME/Applications $PATH5�_�   :   <           ;   q        ����                                                                                                                                                                                                                                                                                                                            q           q          v       _�5�     �   p   r   �      export OPENCV_LOG_LEVEL=ERROR5�_�   ;   =           <   q       ����                                                                                                                                                                                                                                                                                                                            q           q          v       _�5�     �   p   r   �      set OPENCV_LOG_LEVEL=ERROR5�_�   <   >           =   q       ����                                                                                                                                                                                                                                                                                                                            q           q          v       _�5�    �   p   r   �      set OPENCV_LOG_LEVELERROR5�_�   =   ?           >          ����                                                                                                                                                                                                                                                                                                                                                             _�6w     �         �      2set PATH $HOME/.local/bin $HOME/Applications $PATH5�_�   >   @           ?   }       ����                                                                                                                                                                                                                                                                                                                                                             _�6{     �   |   ~   �      set PYENV_ROOT $HOME/.pyenv5�_�   ?   A           @   ~       ����                                                                                                                                                                                                                                                                                                                                                             _�6}    �   }      �      set PATH $PYENV_ROOT/bin $PATH5�_�   @   B           A   5        ����                                                                                                                                                                                                                                                                                                                            5           V          v       _�O�    �   U   W          # end�   T   V           #     cp $filename $filename.bak�   S   U          %# function backup --argument filename�   R   T          '# # result: copies file as file.txt.bak�   Q   S          # # ex: backup file.txt�   P   R          '# # Function for creating a backup file�   O   Q           �   N   P          # end�   M   O          0#   bind '$' __history_previous_comman_arguments�   L   N          %#   bind ! __history_previous_command�   K   M          # else�   J   L          :#   bind -Minsert '$' __history_previous_command_arguments�   I   K          .#   bind -Minsert ! __history_previous_command�   H   J          3# if [ $fish_key_bindings = fish_vi_key_bindings ];�   G   I          # # The bindings for !! and !$�   F   H          # end�   E   G          #   end�   D   F          #     commandline -i '$'�   C   E          #   case "*"�   B   D          2#     commandline -f history-token-search-backward�   A   C          #     commandline -t ""�   @   B          #   case "!"�   ?   A          #   switch (commandline -t)�   >   @          /# function __history_previous_command_arguments�   =   ?           �   <   >          # end�   ;   =          #   end�   :   <          #     commandline -i !�   9   ;          #   case "*"�   8   :          8#     commandline -t $history[1]; commandline -f repaint�   7   9          #   case "!"�   6   8          #   switch (commandline -t)�   5   7          %# function __history_previous_command�   4   6           # Functions needed for !! and !$5�_�   A   C           B   5        ����                                                                                                                                                                                                                                                                                                                                                             _�R�    �   4   6          Functions needed for !! and !$5�_�   B               C   q       ����                                                                                                                                                                                                                                                                                                                                                             _�đ    �   p   r   �      set OPENCV_LOG_LEVEL ERROR5�_�   (           *   )          ����                                                                                                                                                                                                                                                                                                                                                             _�3O     �         }      Mset PATH fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths5�_�   !           #   "           ����                                                                                                                                                                                                                                                                                                                                                             _��     �                I# set fish_greeting                      # Supresses fish's intro message5�_�                    0        ����                                                                                                                                                                                                                                                                                                                            0           0           V        _���     �   0   1   }    �   /   1   }      	$$ set -L   !$ set -U fish_color_normal normal   "$ set -U fish_color_command c397d8    $ set -U fish_color_quote b9ca4a   &$ set -U fish_color_redirection 70c0b1   $ set -U fish_color_end c397d8    $ set -U fish_color_error d54e53    $ set -U fish_color_param 7aa6da   ?$ set -U fish_color_selection white --bold --background=brblack   >$ set -U fish_color_search_match bryellow --background=brblack   *$ set -U fish_color_history_current --bold   #$ set -U fish_color_operator 00a6b2   !$ set -U fish_color_escape 00a6b2   $ set -U fish_color_cwd green    $ set -U fish_color_cwd_root red   *$ set -U fish_color_valid_path --underline   )$ set -U fish_color_autosuggestion 969896    $ set -U fish_color_user brgreen   $ set -U fish_color_host normal   $ set -U fish_color_cancel -r   +$ set -U fish_pager_color_completion normal   3$ set -U fish_pager_color_description B3A06D yellow   9$ set -U fish_pager_color_prefix white --bold --underline   <$ set -U fish_pager_color_progress brwhite --background=cyan   -$ set -U fish_color_match --background=brblue   "$ set -U fish_color_comment e7c547   A$ set -U fish_color_normal normal set -U fish_color_normal normal5��