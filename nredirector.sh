#!bin/bash

# in inotifywait download is long MODIFY -> CLOSE_WRITE,CLOSE -> ATTRIB

# watch current directory
cwd=`pwd`
cd $cwd

echo $cwd

# setup
mkdir -p "${cwd}/html_and_css"
declare -a htmlAndCss=("html" "css")
mkdir -p "${cwd}/images"
declare -a images=("apng" "avif" "gif" "jpg" "jpeg" "jfif" "pjpeg" "pjp" "png" "svg" "webp" "bmp" "ico" "cur" "tif" "tiff")
mkdir -p "${cwd}/archive"
declare -a archives=("a" "ar" "cpio" "shar" "lbr" "iso" "mar" "sbx" "tar" "bz2" "gz" "lz" "lz4" "lzma" "lzo" "rz" "sfarksz" "xz" "z" "zst" "7z" "s7z" "ace" "afa" "alz" "apk" "arc" "ark" "cdx" "b1" "b6z" "ba" "bh" "cab" "car" "cfs" "cpt" "dar" "dd" "dgc" "dmg" "ear" "gca" "genozip" "ha" "hki" "ice" "jar" "kgb" "lzh" "lha" "lzx" "pak" "partimg" "paq6" "paq7" "paq8" "pea" "phar" "pim" "pit" "qda" "rar" "rk" "sda" "sea" "sen" "sfx" "shk" "sit" "sitx" "sqx" "tgz" "tlz" "tbz2" "txz" "uc" "uc0" "uc2" "ucn" "ur2" "ue2" "uca" "uha" "war" "wim" "xar" "xp3" "yz1" "zip" "zipx" "zoo" "zpaq" "zz" "ecc" "ecsbx" "par" "pa2" "rev")
mkdir -p "${cwd}/video"
declare -a videos=("webm" "mkv" "flv" "vob" "ogv" "ogg" "drc" "gifv" "mng" "avi" "mts" "m2ts" "mov" "wmv" "yuv" "rm" "rmvb" "viv" "asf" "amv" "mp4" "m4p" "m4v" "mpg" "mp2" "mpeg" "mpe" "mpv" "mpg" "mpeg" "m2v" "svi" "3gp" "3g2" "mxf" "roq" "nsv" "flv" "f4v" "f4p" "f4a" "f4b")
mkdir -p "${cwd}/spreadsheet"
declare -a spreadsheets=("xlsx" "xlsm" "xlsb" "xltx" "csv")
mkdir -p "${cwd}/docs"
declare -a docs=("docx" "rtf" "odt" "epub")
mkdir -p "${cwd}/music"
declare -a musics=("3gp" "aa" "aac" "aax" "act" "aiff" "alac" "amr" "ape" "au" "awb" "dss" "dvf" "flac" "gsm" "iklax" "ivs" "m4a" "m4b" "m4p" "mmf" "mp3" "mpc" "msv" "nmf" "ogg" "oga" "mogg" "opush" "ra" "rm" "raw" "rf64" "sln" "tta" "voc" "vox" "wav" "wma" "wv" "webm" "8svx" "cda")
mkdir -p "${cwd}/powerpoint"
declare -a powerpoints=("ppt" "pptx")
mkdir -p "${cwd}/torrent"
mkdir -p "${cwd}/pdf"
mkdir -p "${cwd}/ovpn"
mkdir -p "${cwd}/plain text and script"
mkdir -p "${cwd}/etc"

# https://stackoverflow.com/questions/3685970/check-if-a-bash-array-contains-a-value
containsElement () {
    local e match="$1"
    shift
    for e; do [[ "$e" == "$match" ]] && return 1; done
    return 0
}
# first movement
OIFS="$IFS"
IFS=$'\n'
yourfilenames=`find . -maxdepth 1`
for file in $yourfilenames
do
    echo $file
    containsElement "${file##*.}" "${htmlAndCss[@]}"
    if [[ $? == 1 ]]; then
        mv $file "./html_and_css"
        continue
    fi
    containsElement "${file##*.}" "${images[@]}"
    if [[ $? == 1 ]]; then
        mv $file "./images"
        continue
    fi
    containsElement "${file##*.}" "${archives[@]}"
    if [[ $? == 1 ]]; then
        mv $file "./archive"
        continue
    fi
    containsElement "${file##*.}" "${videos[@]}"
    if [[ $? == 1 ]]; then
        mv $file "./video"
        continue
    fi
    containsElement "${file##*.}" "${spreadsheets[@]}"
    if [[ $? == 1 ]]; then
        mv $file "./spreadsheet"
        continue
    fi
    containsElement "${file##*.}" "${docs[@]}"
    if [[ $? == 1 ]]; then
        mv $file "./docs"
        continue
    fi
    containsElement "${file##*.}" "${musics[@]}"
    if [[ $? == 1 ]]; then
        mv $file "./music"
        continue
    fi
    containsElement "${file##*.}" "${powerpoints[@]}"
    if [[ $? == 1 ]]; then
        mv $file "./powerpoint"
        continue
    fi
    echo "${file##*.}"
    if [[ "torrent" == "${file##*.}" ]]; then
        mv $file "./torrent"
    elif [[ "pdf" == "${file##*.}" ]]; then
        mv $file "./pdf"
    elif [[ "ovpn" == "${file##*.}" ]]; then
        mv $file "./ovpn"
    elif [[ "txt" == "${file##*.}" ]]; then
        mv $file "./plain text and script"
    fi
done

# in loop
inotifywait -m -e ATTRIB `pwd` |
    while read dir operation file;
    do
        # get extension
        # https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
        echo $dir $operation $file
        containsElement "${file##*.}" "${htmlAndCss[@]}"
        if [[ $? == 1 ]]; then
            mv $file "./html_and_css"
            continue
        fi
        containsElement "${file##*.}" "${images[@]}"
        if [[ $? == 1 ]]; then
            mv $file "./images"
            continue
        fi
        containsElement "${file##*.}" "${archives[@]}"
        if [[ $? == 1 ]]; then
            mv $file "./archive"
            continue
        fi
        containsElement "${file##*.}" "${videos[@]}"
        if [[ $? == 1 ]]; then
            mv $file "./video"
            continue
        fi
        containsElement "${file##*.}" "${spreadsheets[@]}"
        if [[ $? == 1 ]]; then
            mv $file "./spreadsheet"
            continue
        fi
        containsElement "${file##*.}" "${docs[@]}"
        if [[ $? == 1 ]]; then
            mv $file "./docs"
            continue
        fi
        containsElement "${file##*.}" "${musics[@]}"
        if [[ $? == 1 ]]; then
            mv $file "./music"
            continue
        fi
        if [[ "torrent" == "${file##*.}" ]]; then
            mv $file "./torrent"
        elif [[ "pdf" == "${file##*.}" ]]; then
            mv $file "./pdf"
        elif [[ "ovpn" == "${file##*.}" ]]; then
            mv $file "./ovpn"
        elif [[ "pptx" == "${file##*.}" ]]; then
            mv $file "./powerpoint"
        elif [[ "txt" == "${file##*.}" ]]; then
            mv $file "./plain text and script"
        fi
        
    done
