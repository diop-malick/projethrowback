# PHP info

file='phpinfo.php'
if [ ! -f "$file" ]; then
  echo -e "\n--- Creating  phpinfo script"
  echo '<?php phpinfo();' > "$file"
fi


# ADMINER

file='adminer.php'
if [ ! -f "$file" ]; then
  echo -e "\n--- Adding Adminer for Database management"
  wget -nv -O "$file" http://www.adminer.org/latest.php
  wget -nv https://raw.githubusercontent.com/vrana/adminer/master/designs/pepa-linha/adminer.css
fi
