:: Данный батник конвертирует все видеозаписи из текущей папки и подпапок в файлы с небольшим битрейтом
:: Внимание! Расположите указанный файл в папке с видео. Рядом расположите папку ffmpeg. Запустите данный файл.
:: ffmpeg -hide_banner -h encoder=h264_nvenc | xclip -sel clip
mkdir "progress"
mkdir "ready"
mkdir "source"

FOR /F "usebackq delims==" %%i IN (`dir /B /A-D /OS`) DO ( 
IF NOT "%%~xi"==".bat" (
move "%%i" "progress" && ^
ffmpeg -y -i "progress\%%i" -b:v 512k -maxrate 1024k -vf "scale=-1:'min(360,ih)'" -r 25 -c:v h264_nvenc -pix_fmt yuv420p -c:a copy "ready\%%~ni_360p.mp4" && ^ 
move "progress\%%i" "source"))
pause
