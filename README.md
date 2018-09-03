# vagrant-windows

Fully automatic windows vagrant box build and setup script

## Usage:

1. Download a Windows ISO for the Windows version you'd like to build the image for
2. Place it into the correct folder (Windows 7 ISO => `win7`, Windows 10 ISO => `win10`)
3. Run `bash install.sh winV` where V is either 7 for Windows 7 or 10 for Windows 10
4. Wait...
5. If everything worked you should now have a `winV.box` file that can be imported into Vagrant

## FAQ

Q: Why can't I download this from the registry?
A: Uploading it there isn't allowed under Microsofts EULA

Q: Isn't that illegal?
A: As long as you use it for personal use only it's not

Q: Is Windows licensed?
A: No, the images are by default not activated. But they aren't supposed to be used for long-term anyways.
