function update -d "Updates all software"
    switch (uname)
        case Linux
            sudo apt-get -y update
            sudo apt-get -y upgrade
    end
    brewup
    omf install
end
