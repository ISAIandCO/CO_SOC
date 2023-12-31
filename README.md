# CO_SOC

## Содержание репозитория

### ПО

| Наименование | Тип | Описание |
| ------------ | --- | -------- |
| [Zircolite](Zircolite) | Analysis | Форк проекта [Zircolite](https://github.com/wagga40/Zircolite) с модифицированием схемы обновления (для доступа через proxy) и полуавтоматическим режимом |

### Скрипты

| Наименование | Тип | Описание |
| ------------ | --- | -------- |
| [GetEvent](Scripts/GetEvent.ps1) | IG | Массовая выгрузка журналов с функцией выбора отдельного промежутка |
| [SID-Name_Name-SID](Scripts/SID-Name_Name-SID.ps1) | IG | Получение информации из AD по сущностям при известном SID или SamAccountName |
| [DiskParse](Scripts/DiskParse.ps1) | IG | Получение содержимого всех подключенных дисков |
| [HASH_check](Scripts/HASH_check/HASH_check.ps1) | Analysis | Автоматизированний поиск хэшей файлов (Расположенных в папке "HASH_check" рядом со скриптом) в сети (VirusTotal, OpenTip) |
| [Eicar_Auto](Scripts/Eicar_Auto.ps1) | Tool | Скрипт проверки работы СЗИ - через определенные промежутки создает файл EICAR (детектируется антивирусом) и пингует хост "Hello_There" (Требутся правило в СЗИ) |
| [AV_Update](Scripts/AV_Update.ps1) | Tool | Скрипт поддержания в актуальном состоянии антивирусных утилит (CureIT, KVRT и тд.) |


## Полезные ресурсы и ПО

| Наименование | Тип | Описание |
| ------------ | --- | -------- |
|	[AbuseIPDB](https://abuseipdb.com)	|	TI	|	Определение легитимности IP и попадания его в базы сканеров. Также есть возможность таким образом проверять диапазоны.	|
|	[VirusTotal](https://virustotal.com)	|	TI	|	Проверка сущностей (URL, Хэшы, файлы и тд.) на попадание в базы антивирусов, а также подгрузка общедоступной информации о них.	|
|	[Kaspersky Threat Intelligence Portal](https://opentip.kaspersky.com)	|	TI	| Проверка сущностей (URL, Хэшы, файлы и тд.) на попадание в базу антивируса Касперского. |
|	[Suip.biz](https://suip.biz/ru)	|	OSINT	|	Комбайн для проверки адресов\сайтов и тд. По открытым источникам (OSINT)	|
|	[Censys](https://search.censys.io)	|	OSINT	|	Автоматизированный онлайн сканер уязвимостей. Сканирует узлы в сети интернет и систематизирует данные по ним.	|
|	[ANY.RUN](https://any.run)	|	Analysis	|	Онлайн песочница которая позволяет произвести поэтапный анализ хода выполнения ПО.	|
|	[ORKL](https://orkl.eu)	|	TI	|	Ресурс, агрегирующий в себе статьи\документы и тд. по обнаруженному вредоносному ПО с описанием его принципов работы с артефактами.	|
|	[Capa](https://github.com/mandiant/capa)	|	Analysis	|	ПО, производящее разбор исполняемых файлов по функционалу и соотносящее его с матрицей MITRE	|
|	[Wireshark](https://wireshark.org)	|	Analysis	|	Анализатор сетевого трафика	|
|	[EvtxECmd](https://github.com/EricZimmerman/evtx)	|	Tool	|	ПО, преобразующее журналы windows в табличный вид (по заранее заготовленным шаблонам)	|
|	[Sandboxie](https://github.com/sandboxie-plus)	|	Analysis	|	Песочница, которая позволяет локально произвести поэтапный анализ выполнения ПО.	|
|	[CyberChef](https://github.com/gchq/CyberChef)	|	Analysis	|	Анализатор текстовых данных	|
|	[TCPing](https://github.com/cloverstd/tcping)	|	Tool	|	Пинг по любому TCP порту (стандартный идет по ICMP)	|
|	[VirtualBox](https://virtualbox.org)	|	Tool	|	Опенсурсный гипервизор - кросплатформенный и функциональный	|
|	[SQLiteDatabaseBrowserPortable](https://sqlitebrowser.org)	|	Tool	|	ПО, позволяющее производить просмотр файлов баз данных	|
|	[Notepad++](https://notepad-plus-plus.org)	|	Tool	|	Продвинутый аналог стандартного блокнота с подстветкой синтаксиса, различных кодировок и плагинов.	|
|	[Process Explorer](https://learn.microsoft.com/ru-ru/sysinternals)	|	Tool	|	Аналог Диспетчера задач с дополнительным функционалом (проверка хэшей на virustotal и тд.)	|
|	[Process Monitor](https://learn.microsoft.com/ru-ru/sysinternals)	|	Analysis	|	ПО, собирающее данные о работе ПО и выводящее накопившиеся данные по требованию	|
|	[Malpedia](https://malpedia.caad.fkie.fraunhofer.de)	|	TI	|	Ресурс, агрегирующий в себе статьи\документы и тд. по обнаруженному вредоносному ПО с описанием его принципов работы с артефактами. Также приводит информацию по группировкам и предоставляет YARA правила для семейств вредоносов.	|
|	[FileScan.IO](https://filescan.io)	|	TI	|	Проверка сущностей (URL, Хэшы, файлы и тд.) на попадание в базы антивирусов, а также подгрузка общедоступной информации о них.	|
|	[Национальный мультисканер](https://virustest.gov.ru)	|	TI	|	Проверка сущностей (URL, Хэшы, файлы и тд.) на попадание в базы антивирусов, а также подгрузка общедоступной информации о них.	|
|	[Tor Metrics](https://metrics.torproject.org)	|	OSINT	|	Информация об активных тор-нодах	|
|	[Cuckoo](https://cuckoo.cert.ee)	|	Analysis	|	Sandbox	|
|	[Pulsedive](https://pulsedive.com)	|	TI	|	Проверка сущностей (URL, Хэшы, файлы и тд.) на попадание в базы антивирусов, а также подгрузка общедоступной информации о них.	|
|	[Zircolite](https://github.com/wagga40/Zircolite)	|	TI	|	Анализ журналов системы с момощью заранее подготовленных правил (SIGMA и MITRE) |
