# Folder Organiser

This is a Bash script that tidies any folder by sorting its files into sub-folders by type.

## Problem Statement

Folders like Downloads fill up with photos, PDFs, installers, ZIP files and
CVs, all mixed together, and finding anything takes time. `organise.sh`
cleans a folder in seconds by moving each file into the right category
folder, without ever overwriting anything.

## Project Goals

- Sort files by extension into clear category folders
- Never lose or overwrite a file
- Leave existing sub-folders untouched
- Give clear errors when the input is wrong

## Tech Stack

- Bash
- Git and GitHub (feature branch and pull request workflow)
- Ubuntu terminal, VS Code

## Features

- Takes a folder as an argument, or uses the current folder if none is given
- Case-insensitive matching, so `.JPG` counts as an image
- Creates a category folder only when a file is going into it
- Moves top-level files only and never touches existing sub-folders
- Handles file names that contain spaces
- Never overwrites: a clash becomes `photo(1).jpg`, then `photo(2).jpg`, and so on
- Prints every move and a final summary with the number of files moved
- Prints an error on stderr and exits with status 1 if the folder does not exist

## Categories

 Folder       Extensions                                         
 `Images`     jpg, jpeg, png, gif, webp                          
 `Documents`  pdf, doc, docx, txt, xlsx, pptx                    
 `Audio`      mp3, wav, m4a                                      
 `Video`      mp4, mkv, mov                                      
 `Archives`   zip, rar, tar, gz                                  
 `Other`      everything else, including files with no extension 

## Installation and Usage

Clone the repository and make the script executable:

```bash
git clone https://github.com/Nteinpraises/bash-06-folder-organiser.git
cd bash-06-folder-organiser
chmod +x organise.sh
```

Run it on a folder:

```bash
./organise.sh ~/Downloads
```


## How to Test It Safely

Do not test on a real folder. Build a test folder outside the repository,
copy it, and run the script on the copy:

```bash
mkdir ~/test-original
touch ~/test-original/"My CV.PDF" ~/test-original/photo.JPG ~/test-original/notes
mkdir ~/test-original/old-stuff

cp -r ~/test-original ~/test-run
./organise.sh ~/test-run

find ~/test-original -type f | wc -l
find ~/test-run -type f | wc -l
```

1. The two file counts must be the same, which shows nothing was lost.
2. `old-stuff` must still be there, untouched.
3. A second run must say `Done: 0 files moved`.
4. To test a clash, run `touch ~/test-run/photo.JPG`, run the script again,
   then `ls ~/test-run/Images`. You should see both `photo.JPG` and `photo(1).JPG`.

Reset between tests with `rm -rf ~/test-run && cp -r ~/test-original ~/test-run`.

## Challenges Faced

- **Running it in the wrong folder.** I ran the script with no argument inside
  my own project and it moved `organise.sh` and `README.md` into `Other/`.
  That taught me to always test on a separate copy.
- **Files with no extension.** For a name like `notes`, the extension trick
  returns the whole name, so I first check that the name contains a dot.

## What I Learned

- How arguments and default values work (`${1:-.}`)
- Looping over files and testing them with `[[ -f ]]` and `[[ -d ]]`
- Cutting names apart with `${name##*.}` and `${name%.*}`
- Using `case` to match several patterns at once
- Sending errors to stderr and using exit codes(like 0 and 1)

## Notes and Limits

- Hidden files (names starting with a dot) are left where they are.
- Only the listed extensions are sorted. For example `.webm` goes to `Other`.

## Author

Ntein Praises, Full Stack Engineer and AI Automation Architect