:: Данный батник конвертирует все видеозаписи из текущей папки и подпапок в файлы с небольшим битрейтом
:: Внимание! Расположите указанный файл в папке с видео. Рядом расположите папку ffmpeg. Запустите данный файл.
:: ffmpeg -hide_banner -h encoder=h264_nvenc | xclip -sel clip
mkdir "progress"
mkdir "ready"
mkdir "source"
FOR /F "usebackq delims==" %%i IN (`dir /B /A-D /OS`) DO move %%i "progress" && ffmpeg -y -i "progress\%%i" -b:v 256k -maxrate 512k -b:a 128k -s 426x240 -r 25 -c:v h264_nvenc -pix_fmt yuv420p -c:a copy "ready\%%i_240p.mp4" && move "ready\%%i_240p.mp4" "Z:\Video"  &&  move "progress\%%i" "source"
pause