@REM **Устанавливаем кодировку UTF-8**
chcp 65001

@REM **Устанавливаем рабочую базу**
call packman set-database /Fc:\tools\deploy\packman

@REM **Подключаемся к хранилищу и загружаем во временную базу packman**
call packman load-storage c:\tools\deploy\storage -storage-user Разработчик -storage-pwd 123 -storage-v %1

@REM **Генерим файл поставки**
call packman make-cf

@REM **Обновляем рабочую базу файлом поставки**
call vrunner update --src .packman\1cv8.cf --settings deploy-test-env.json

@REM **Далее только при наличии сервера 1С**
@REM **Подключаем ras**
@REM call "C:\Program Files\1cv8\8.3.18.1334\bin\ras.exe" cluster --port-1545 localhost:1540

@REM **Блокировка работы пользователей**
@REM call vrunner session lock --ras localhost:1545 --lockmessage "Обновление 1.0.0.%1" --db test --settings deploy-test-env.json --uccode 1234

@REM **Блокировка работы регламентных заданий**
@REM call vrunner sheduledjobs lock --ras localhost:1545 --db test --settings deploy-test-env.json --uccode 1234

@REM **Отключение сеансов пользователей**
@REM call vrunner session kill --ras localhost:1545 --db test --uccode 1234 


@REM **Обновление рабочей ИБ**
call vrunner updatedb --settings deploy-test-env.json --uccode 1234

@REM **Запускаем обработчики обновления рабочей ИБ**
call vrunner run --command "ЗапуститьОбновлениеИнформационнойБазы;ЗавершитьРаботуСистемы;" --execute $runnerRoot\epf\ЗакрытьПредприятие.epf --settings deploy-test-env.json --uccode 1234 

@REM **Далее только при наличии сервера 1С**
@REM **Разблокировка работы пользователей**
@REM call vrunner session unlock --ras localhost:1545 --db test --settings deploy-test-env.json --uccode 1234

@REM **Разблокировка работы регламентных заданий**
@REM call vrunner sheduledjobs unlock --ras localhost:1545 --db test --settings deploy-test-env.json --uccode 1234










