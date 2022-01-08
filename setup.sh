#!/bin/bash

rename_cwd() {
  cd . || return
  new_dir=${PWD%/*}/$1
  mv -- "$PWD" "$new_dir" &&
    cd -- "$new_dir"
}


if grep -R -l rename lib > /dev/null; then
  echo ""
else
  read -p "You've already renamed this app. Are you sure you want to rename it
  again? Y/n " -n 1 -r

  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    exit 1
  fi
fi

read -p "Need to install tool 'rename' in order to globally rename files in this project. Is that ok? Y/n " -n 1 -r

echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  brew install rename
else
  echo "Aborting"
  exit 1
fi

echo "What module name would you like to give this app? \n\nExample: MyApp would create MyApp and MyAppWeb module prefixes"
read module_name

snake_name=$(echo $module_name | sed 's/[[:upper:]]/_&/g;s/^_//' | tr '[:upper:]' '[:lower:]')

echo "Renaming all instances of ReplaceMe with $module_name and replace_me with
$snake_name in project..."
LC_ALL=C find lib config test assets priv -type f -name '*' -exec sed -i '' s/RenameMe/$module_name/g {} +
LC_ALL=C find lib config test assets priv -type f -name '*' -exec sed -i '' s/rename_me/$snake_name/g {} +

sed -I '' "s/RenameMe/$module_name/g" mix.exs
sed -I '' "s/rename_me/$snake_name/g" mix.exs


# Rename all folders/files using rename 
find . -execdir rename -f 's/rename_me/\Q$ENV{snake_name}\E/' '{}' \+ &> /dev/null

echo "Heads up! Also renaming the current working directory to $snake_name..."
rename_cwd $snake_name

cat << EOF
 ______     __  __     ______     ______     ______     ______     ______    
/\  ___\   /\ \/\ \   /\  ___\   /\  ___\   /\  ___\   /\  ___\   /\  ___\   
\ \___  \  \ \ \_\ \  \ \ \____  \ \ \____  \ \  __\   \ \___  \  \ \___  \  
 \/\_____\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \/\_____\  \/\_____\ 
  \/_____/   \/_____/   \/_____/   \/_____/   \/_____/   \/_____/   \/_____/ 
EOF
echo 
echo "✅ Done! your app is renamed to $snake_name / $module_name."
echo 
                                                                             
read -p "Do you want to compile & run the app? (ensure that you have postgres running
first) Y/n " -n 1 -r

echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  mix deps.get && mix ecto.create && mix ecto.migrate && mix phx.server
else
  echo "Aborting, not attempting to run the app"
  exit 1
fi
