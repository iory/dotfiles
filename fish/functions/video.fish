function video2png -d "Simple ffmpeg wrapper"
    set --local filename $argv[1]
    set --local extension (echo $argv[1] | awk -F. '{print $NF}')
    set --local filename (basename $argv[1] .$extension)
    mkdir -p $filename
    pushd $filename
    echo $filename
    ffmpeg  -i ../$argv[1] -r 5 -f image2 "$filename"_%06d.png -q:v 1
    popd
end
