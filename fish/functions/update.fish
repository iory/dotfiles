function update -d "Updates all software"
    switch (uname)
        Linux
            sudo apt-get -y update
            sudo apt-get -y upgrade
    end
    brewup
    omf install
end
