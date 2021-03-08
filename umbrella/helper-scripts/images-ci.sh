git_pull(){
    for D in ./*; do
        if [ -d "$D" ]; then
            cd "$D"
            echo "------------------------------"$D"--------------------------------"
                    git checkout develop  #request user for branch
            git pull
            cd ..
        fi
    done

}
                                             #make a docker login func!
build_image() {
    docker build -t yesodotaks/$1:latest .   #if you're not devops team u should change this repo tag
}

push_dockerhub() {
    docker push yesodotaks/$1:latest         #if you're not devops team u should change this repo tag   
}

read -p 'please enter your desired path: ' path   #make it repeat!
cd ~/$path
git_pull
for D in ./*; do                                  #If you want it to pull all new code thwn uncomment from here down
     if [ -d "$D" ]; then
         cd "$D"
        for file in ./*; do
            if [ $file == "./Dockerfile" ] || [ $file == "./dockerfile" ]; then
                CURRENT_PATH=`pwd`
                FILE_NAME=`basename "$CURRENT_PATH"`  #basename required.
                build_image "${FILE_NAME,,}"
                push_dockerhub "${FILE_NAME,,}"
                echo "------------------------------ "${FILE_NAME,,}" was build and push sucessfully :) --------------------------------"
            fi
        done
         cd ..
     fi
done