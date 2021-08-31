function fish_pdf_crop
    set --local filename $argv[1]
    set --local extension (echo $argv[1] | awk -F. '{print $NF}')
    set --local filename (basename $argv[1] .$extension)
    pdfcrop $argv[1]
    mv "$filename-crop.pdf" "$filename.pdf"
end


function fish_pdfmin
    set --local filename $argv[1]
    set --local extension (echo $argv[1] | awk -F. '{print $NF}')
    set --local filename (basename $argv[1] .$extension)
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$filename-compress.pdf" $argv[1]
    mv "$filename-compress.pdf" "$filename.pdf"
end


function pdfdeploy
    switch (count $argv)
        case 0
            echo "pdfdeploy requires target pdf file."
            return 1
        case 1
            set --local filename $argv[1]
            set --local extension (echo $argv[1] | awk -F. '{print $NF}')
            set --local filename (basename $argv[1] .$extension)
            pdfseparate -f 1 -l 1 "$filename.pdf" "$filename-%d.pdf"
            mv "$filename-1.pdf" "$filename.pdf"
            fish_pdf_crop "$filename.pdf"
            fish_pdfmin "$filename.pdf"
        case '*'
            set --local filename $argv[1]
            set --local extension (echo $argv[1] | awk -F. '{print $NF}')
            set --local filename (basename $argv[1] .$extension)
            set --local pageindex $argv[2]
            pdfseparate -f $pageindex -l $pageindex "$filename.pdf" "$filename-%d.pdf"
            mv "$filename-$pageindex.pdf" "$filename.pdf"
            fish_pdf_crop "$filename.pdf"
            fish_pdfmin "$filename.pdf"
    end
end
