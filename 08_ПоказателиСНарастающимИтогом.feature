﻿#language: ru

@tree

Функционал: 08. Расчет показателей нарастающим итогом

Как Администратор я хочу
Проверить различные способы расчета показателей нарастающим итогом 

Контекст: 

	И я подключаю TestClient 'УХ - Бюджетирование' логин "Администратор" пароль ''
	И я закрыл все окна клиентского приложения

Сценарий: 08.00 Определение типа приложения

	Пусть Инициализация переменных

Сценарий: 08.01 Создание группы отчетов 'ВА - Нарастающий итог (группа)'

	И Я создаю группу видов отчетов с именем 'ВА - Нарастающий итог (группа)' и родителем 'ВА - Группа отчетов'

Сценарий: 08.02 Создание вида отчета 'ВА - Нарастающий итог (источник)'

	И Я создаю вид отчета с именем 'ВА - Нарастающий итог (источник)' и родителем 'ВА - Нарастающий итог (группа)'

	И Я открываю вид отчета с именем 'ВА - Нарастающий итог (источник)'
	И я устанавливаю флаг с именем 'РазделениеПоПроектам'		
	И я перехожу к закладке с именем 'АналитикиОтчета'
	И из выпадающего списка с именем 'ВидАналитики1' я выбираю по строке 'ВА0СтатДДС'				
	И я нажимаю на кнопку с именем 'ФормаКнопкаЗаписать'
	Когда открылось окно "Реструктуризация данных"
	И я нажимаю на кнопку с именем 'ФормаОК'

	И я нажимаю на кнопку с именем 'РедактироватьДерево'
	Когда открылось окно "Конструктор отчета"
	И Я в конструкторе отчета добавляю строку с именем 'Товары'	
	И Я в конструкторе отчета добавляю колонку с именем 'Количество'		
	И Я в конструкторе отчета добавляю аналитику с кодом 'ВА0Номенкл' в ячейку 'R2C3'
		
	И Я Для вида отчета 'ВА - Нарастающий итог (источник)' я создаю бланк по умолчанию
	И Я Для вида отчета 'ВА - Нарастающий итог (источник)' в бланке для группы раскрытия с адресом 'R8C1' задаю сортировку 'Номенклатура.Артикул'

Сценарий: 08.03 Создание экземпляра отчета - 'ВА - Нарастающий итог (источник)' 

	И Я создаю экземпляр отчета для вида отчета 'ВА - Нарастающий итог (источник)' сценарий 'ВА - Основной сценарий' период '01.01.2021' '31.03.2021' периодичность "Месяц" организация 'Меркурий ООО' проект 'ВА - Основной проект' аналитики 'Реализация программных продуктов' '' '' '' '' '' 

	* Документ должен быть пустой
		Тогда табличный документ 'ПолеТабличногоДокументаМакет' равен:
			| 'ВА - Нарастающий итог (источник)' | ''               | ''                | ''             | ''           |
			| ''                                 | ''               | ''                | ''             | ''           |
			| ''                                 | "Январь 2021 г." | "Февраль 2021 г." | "Март 2021 г." | 'ИТОГО'      |
			| ''                                 | 'Количество'     | 'Количество'      | 'Количество'   | 'Количество' |
			| 'Товары'                           | '0'              | '0'               | '0'            | '0'          |

	* Вводим значения показателей
		Когда открылось окно '$ЗаголовокОкна$'		
		И Я добавляю значения с раскрытием показателей в ячейку 'R6C2'
				| 'ВА0Номенкл'                                                     | 'Значение' |
				| '1С:Предприятие 8.3 КОРП. Лицензия на сервер (x86-64)'           | '10,00000' |
				| '1С:Предприятие 8 КОРП. Клиентская лицензия на 100 рабочих мест' | '10,00000' |
				| '1С:Управление холдингом 8'                                      | '10,00000' |
				| '1С:Корпорация'                                                  | '10,00000' |
				| '1С:ERP. Управление холдингом'                                   | '10,00000' |

	* Копируем значения показателей
		Когда открылось окно '$ЗаголовокОкна$'
		И в табличном документе 'ПолеТабличногоДокументаМакет' я перехожу к ячейке 'R6C2:R11C2'
		И я нажимаю на кнопку с именем 'КопироватьВБуферОбмена'
		И в табличном документе 'ПолеТабличногоДокументаМакет' я перехожу к ячейке 'R6C3:R11C3'
		И Я вставляю из буфера обмена в макете
		И Я изменяю значение на '100,00000' процентов в ячейке 'R6C3:R11C3'
		Когда открылось окно '$ЗаголовокОкна$'
		И в табличном документе 'ПолеТабличногоДокументаМакет' я перехожу к ячейке 'R6C3:R11C3'
		И я нажимаю на кнопку с именем 'ПолеТабличногоДокументаМакетСкопироватьДанныеПоСтроке'
		И Я изменяю значение на '10,00000' в ячейке 'R7C4:R11C4'

	* Сравниваем итоговый документ
		Тогда табличный документ 'ПолеТабличногоДокументаМакет' равен:
			| 'ВА - Нарастающий итог (источник)'                                | ''               | ''                | ''             | ''           |
			| ''                                                                | ''               | ''                | ''             | ''           |
			| ''                                                                | "Январь 2021 г." | "Февраль 2021 г." | "Март 2021 г." | 'ИТОГО'      |
			| ''                                                                | 'Количество'     | 'Количество'      | 'Количество'   | 'Количество' |
			| 'Товары'                                                          | '50'             | '100'             | '150'          | '300'        |
			| '1С:Управление холдингом 8 '                                      | '10'             | '20'              | '30'           | '60'         |
			| '1С:Корпорация '                                                  | '10'             | '20'              | '30'           | '60'         |
			| '1С:Предприятие 8.3 КОРП. Лицензия на сервер (x86-64) '           | '10'             | '20'              | '30'           | '60'         |
			| '1С:ERP. Управление холдингом '                                   | '10'             | '20'              | '30'           | '60'         |
			| '1С:Предприятие 8 КОРП. Клиентская лицензия на 100 рабочих мест ' | '10'             | '20'              | '30'           | '60'         |

	* Записываем документ	
		Когда открылось окно '$ЗаголовокОкна$'
		И я нажимаю на кнопку с именем 'ЗаписатьИЗакрыть'
		И я жду закрытия окна '$ЗаголовокОкна$' в течение 20 секунд			

Сценарий: 08.04 Создание вида отчета 'ВА - Нарастающий итог (приемник)'

	И Я создаю вид отчета с именем 'ВА - Нарастающий итог (приемник)' и родителем 'ВА - Нарастающий итог (группа)'

	И Я открываю вид отчета с именем 'ВА - Нарастающий итог (приемник)'
	И я устанавливаю флаг с именем 'РазделениеПоПроектам'		
	И я перехожу к закладке с именем 'АналитикиОтчета'
	И из выпадающего списка с именем 'ВидАналитики1' я выбираю по строке 'ВА0СтатДДС'				
	И я нажимаю на кнопку с именем 'ФормаКнопкаЗаписать'
	Когда открылось окно "Реструктуризация данных"
	И я нажимаю на кнопку с именем 'ФормаОК'

	И я нажимаю на кнопку с именем 'РедактироватьДерево'
	Когда открылось окно "Конструктор отчета"
	
	И Я в конструкторе отчета добавляю строку с именем 'ДанныеИсточника'	
	И Я в конструкторе отчета добавляю строку с именем 'ИзИсточникаДоВычисления'
	И Я в конструкторе отчета добавляю строку с именем 'ИзИсточникаДоВычисленияХ2'
	И Я в конструкторе отчета добавляю строку с именем 'ИзИсточникаПослеВычисления'
	И Я в конструкторе отчета добавляю строку с именем 'ИзИсточникаОтборПоПериоду'
	И Я в конструкторе отчета добавляю строку с именем 'ИзПриемникаОтборПоПериоду'
	И Я в конструкторе отчета добавляю строку с именем 'ИзПриемникаСдвигПериода'
	И Я в конструкторе отчета добавляю строку с именем 'ИзИсточникаПроизвольныйКод'
		
	И Я в конструкторе отчета добавляю колонку с именем 'Количество'		
	
	И Я в конструкторе отчета добавляю аналитику с кодом 'ВА0Номенкл' в ячейку 'R2C3'
	Когда открылось окно "Конструктор отчета"
	И я нажимаю на кнопку с именем 'СкопироватьСоСмещениемВниз1'
	И в табличном документе 'ПолеТабличногоДокументаМакет' я перехожу к ячейке 'R5C3'
	И я нажимаю на кнопку с именем 'УдалитьАналитику'
	И в табличном документе 'ПолеТабличногоДокументаМакет' я перехожу к ячейке 'R9C3'
	И я нажимаю на кнопку с именем 'УдалитьАналитику'						

	* Добавляем формулы расчета
		* ДанныеИсточника
			Когда открылось окно "Конструктор отчета"
			И из выпадающего списка с именем 'РежимРаботы' я выбираю точное значение "Формулы расчета показателей"
			И в табличном документе 'ПолеТабличногоДокументаМакет' я перехожу к ячейке 'R2C2'
			И в табличном документе 'ПолеТабличногоДокументаМакет' я делаю двойной клик на текущей ячейке
			И я нажимаю на кнопку с именем 'СсылкаНаПоказатель1'
			И Я выбираю показатель с кодом 'Товары_Количество' вида отчета 'ВА - Нарастающий итог (источник)'
			Тогда открылось окно "Конструктор отчета *"
			И я нажимаю на кнопку с именем 'ЗаписатьИСвернуть'
		* ИзИсточникаДоВычисленияХ2	
			Тогда открылось окно "Конструктор отчета"
			И в табличном документе 'ПолеТабличногоДокументаМакет' я перехожу к ячейке 'R4C2'
			И в табличном документе 'ПолеТабличногоДокументаМакет' я делаю двойной клик на текущей ячейке
			И в табличном документе 'ПолеТабличногоДокументаМакет' я перехожу к ячейке 'R3C2'
			И в табличном документе 'ПолеТабличногоДокументаМакет' я делаю двойной клик на текущей ячейке
			И я нажимаю на кнопку с именем 'ЗаписатьФормулу'
			Тогда открылось окно "Конструктор отчета"			
			И я нажимаю на кнопку с именем 'ДобавитьОперанд1'
			Тогда открылось окно "Источники данных"
			И я нажимаю на кнопку с именем 'ФормаСоздать'
			Тогда открылось окно "Источник данных (создание)"
			И из выпадающего списка с именем 'СпособПолучения' я выбираю точное значение "Произвольный запрос к текущей ИБ"
			И я снимаю флаг с именем 'ИспользоватьМногопериодныйКонтекст'
			И в поле с именем 'ТекстЗапросаФорма' я ввожу текст 'ВЫБРАТЬ 2 КАК Значение'
			И я нажимаю на кнопку с именем 'РедактироватьТекстЗапроса'
			И я перехожу к закладке с именем 'СоответствиеАналитик'
			И в таблице 'ТаблицаСоответствия' я активизирую поле с именем 'ТаблицаСоответствияСпособЗаполнения'
			И в таблице 'ТаблицаСоответствия' я выбираю текущую строку
			И в таблице 'ТаблицаСоответствия' из выпадающего списка с именем 'ТаблицаСоответствияСпособЗаполнения' я выбираю точное значение "Поле другого источника"
			И в таблице 'ТаблицаСоответствия' я завершаю редактирование строки
			И в таблице 'ТаблицаСоответствия' я активизирую поле с именем 'ТаблицаСоответствияПсевдонимБД'
			И в таблице 'ТаблицаСоответствия' я выбираю текущую строку
			Тогда открылось окно "Источники данных"
			И в таблице 'Список' я выбираю текущую строку
			Тогда открылось окно "Источник данных (создание) *"
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна "Источник данных (создание) *" в течение 20 секунд
			Тогда открылось окно "Источники данных"
			И в таблице 'Список' я выбираю текущую строку
			Тогда открылось окно "Конструктор отчета *"
			И я нажимаю на кнопку с именем 'КнопкаУмножить'
			И я нажимаю на кнопку с именем 'ЗаписатьИСвернуть'
		* ИзИсточникаОтборПоПериоду
			Когда открылось окно "Конструктор отчета"
			И в табличном документе 'ПолеТабличногоДокументаМакет' я перехожу к ячейке 'R6C2'
			И в табличном документе 'ПолеТабличногоДокументаМакет' я делаю двойной клик на текущей ячейке
			И я нажимаю на кнопку с именем 'ДобавитьОперанд1'
			Тогда открылось окно "Источники данных"
			И я нажимаю на кнопку с именем 'ФормаСоздать'
			Тогда открылось окно "Источник данных (создание)"
			И из выпадающего списка с именем 'СпособПолучения' я выбираю точное значение "Показатель отчета текущей ИБ"
			И из выпадающего списка с именем 'ВидОтчетаОтбор' я выбираю по строке 'ВА - Нарастающий итог (источник)'
			И я нажимаю кнопку выбора у поля с именем 'ПоказательОтбор'
			И Я выбираю показатель с кодом 'Товары_Количество'
			Тогда открылось окно "Источник данных (создание) *"
			И я перехожу к закладке с именем 'СтраницаОтборы'
			И в таблице 'ДеревоПараметровОтбораБД' я перехожу к строке:
				| "Отбор"         | "Поле"            |
				| "Период отчета" | "[Период отчета]" |
			И в таблице 'ДеревоПараметровОтбораБД' я активизирую поле с именем 'СпособВычисленияПараметра'
			И в таблице 'ДеревоПараметровОтбораБД' я выбираю текущую строку
			И в таблице 'ДеревоПараметровОтбораБД' из выпадающего списка с именем 'СпособВычисленияПараметра' я выбираю точное значение "Список значений (функция на встроенном языке)"
			И в таблице 'ДеревоПараметровОтбораБД' я активизирую поле с именем 'УточнениеСпособаОпределения'
			И в таблице 'ДеревоПараметровОтбораБД' я нажимаю кнопку выбора у реквизита с именем 'УточнениеСпособаОпределения'
			Когда открылось окно 'ВА - Нарастающий итог (приемник), : РасчетЗначенияПараметра'
			И в поле с именем 'ПолеТекстовогоДокументаПроцедура' я ввожу текст 
				|'// Получаем все периоды до текущего'|
				|'Результат = Новый СписокЗначений;'|
				|'For Сч = 0 To ОбъектРасчета.МассивПериодов.Найти(ОбъектРасчета.ПериодОтчета) Do'|
				|' Результат.Добавить(ОбъектРасчета.МассивПериодов.Получить(Сч));'|
				|'EndDo;'|
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			Тогда открылось окно "1С:Предприятие"
			И я нажимаю на кнопку с именем 'Button0'
			И я активизирую окно "Источник данных (создание) *"
			Тогда открылось окно "Источник данных (создание) *"
			И в таблице 'ДеревоПараметровОтбораБД' я завершаю редактирование строки
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна "Источник данных (создание) *" в течение 20 секунд
			Тогда открылось окно "Источники данных"
			И в таблице 'Список' я выбираю текущую строку
			Тогда открылось окно "Конструктор отчета *"
			И я нажимаю на кнопку с именем 'ЗаписатьИСвернуть'
		* ИзПриемникаОтборПоПериоду
			Когда открылось окно "Конструктор отчета"
			И в табличном документе 'ПолеТабличногоДокументаМакет' я перехожу к ячейке 'R7C2'
			И в табличном документе 'ПолеТабличногоДокументаМакет' я делаю двойной клик на текущей ячейке
			И я нажимаю на кнопку с именем 'ДобавитьОперанд1'
			Тогда открылось окно "Источники данных"
			И я нажимаю на кнопку с именем 'ФормаСоздать'
			Тогда открылось окно "Источник данных (создание)"
			И из выпадающего списка с именем 'СпособПолучения' я выбираю точное значение "Показатель отчета текущей ИБ"
			И из выпадающего списка с именем 'ВидОтчетаОтбор' я выбираю по строке 'ВА - Нарастающий итог (приемник)'
			И я нажимаю кнопку выбора у поля с именем 'ПоказательОтбор'
			И Я выбираю показатель с кодом 'ДанныеИсточника_Количество'
			Тогда открылось окно "Источник данных (создание) *"
			И я перехожу к закладке с именем 'СтраницаОтборы'
			И в таблице 'ДеревоПараметровОтбораБД' я перехожу к строке:
				| "Отбор"         | "Поле"            |
				| "Период отчета" | "[Период отчета]" |
			И в таблице 'ДеревоПараметровОтбораБД' я активизирую поле с именем 'СпособВычисленияПараметра'
			И в таблице 'ДеревоПараметровОтбораБД' я выбираю текущую строку
			И в таблице 'ДеревоПараметровОтбораБД' из выпадающего списка с именем 'СпособВычисленияПараметра' я выбираю точное значение "Список значений (функция на встроенном языке)"
			И в таблице 'ДеревоПараметровОтбораБД' я активизирую поле с именем 'УточнениеСпособаОпределения'
			И в таблице 'ДеревоПараметровОтбораБД' я нажимаю кнопку выбора у реквизита с именем 'УточнениеСпособаОпределения'
			Тогда открылось окно 'ВА - Нарастающий итог (приемник), : РасчетЗначенияПараметра'
			И в поле с именем 'ПолеТекстовогоДокументаПроцедура' я ввожу текст 
				|'// Получаем все периоды до текущего'|
				|'Результат = Новый СписокЗначений;'|
				|'For Сч = 0 To ОбъектРасчета.МассивПериодов.Найти(ОбъектРасчета.ПериодОтчета) Do'|
				|' Результат.Добавить(ОбъектРасчета.МассивПериодов.Получить(Сч));'|
				|'EndDo;'|
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			Тогда открылось окно "1С:Предприятие"
			И я нажимаю на кнопку с именем 'Button0'
			И я активизирую окно "Источник данных (создание) *"
			Тогда открылось окно "Источник данных (создание) *"
			И в таблице 'ДеревоПараметровОтбораБД' я завершаю редактирование строки
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна "Источник данных (создание) *" в течение 20 секунд
			Тогда открылось окно "Источники данных"
			И в таблице 'Список' я выбираю текущую строку
			Тогда открылось окно "Конструктор отчета *"
			И я нажимаю на кнопку с именем 'ЗаписатьИСвернуть'
		* ИзПриемникаСдвигПериода
			Когда открылось окно "Конструктор отчета"
			И в табличном документе 'ПолеТабличногоДокументаМакет' я перехожу к ячейке 'R8C2'
			И в табличном документе 'ПолеТабличногоДокументаМакет' я делаю двойной клик на текущей ячейке
			И я нажимаю на кнопку с именем 'ДобавитьОперанд1'
			Тогда открылось окно "Источники данных"
			И я нажимаю на кнопку с именем 'ФормаСоздать'
			Тогда открылось окно "Источник данных (создание)"
			И из выпадающего списка с именем 'ВидОтчетаОтбор' я выбираю по строке 'ВА - Нарастающий итог (приемник)'
			И я нажимаю кнопку выбора у поля с именем 'ПоказательОтбор'
			И Я выбираю показатель с кодом 'ИзПриемникаСдвигПери_Количество'
			Тогда открылось окно "Источник данных (создание) *"
			И я перехожу к закладке с именем 'СтраницаОтборы'
			И в таблице 'ДеревоПараметровОтбораБД' я перехожу к строке:
				| "Отбор"         | "Поле"            |
				| "Период отчета" | "[Период отчета]" |
			И в таблице 'ДеревоПараметровОтбораБД' я активизирую поле с именем 'СпособВычисленияПараметра'
			И в таблице 'ДеревоПараметровОтбораБД' я выбираю текущую строку
			И в таблице 'ДеревоПараметровОтбораБД' из выпадающего списка с именем 'СпособВычисленияПараметра' я выбираю точное значение "Период отчета со сдвигом"
			И в таблице 'ДеревоПараметровОтбораБД' я активизирую поле с именем 'УточнениеСпособаОпределения'
			И в таблице 'ДеревоПараметровОтбораБД' в поле с именем 'УточнениеСпособаОпределения' я ввожу текст '-1'
			И в таблице 'ДеревоПараметровОтбораБД' я завершаю редактирование строки
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна "Источник данных (создание) *" в течение 20 секунд
			Тогда открылось окно "Источники данных"
			И в таблице 'Список' я выбираю текущую строку
			Тогда открылось окно "Конструктор отчета *"
			И я нажимаю на кнопку с именем 'КнопкаПлюс'
			И в табличном документе 'ПолеТабличногоДокументаМакет' я перехожу к ячейке 'R2C2'
			И в табличном документе 'ПолеТабличногоДокументаМакет' я делаю двойной клик на текущей ячейке
			И я нажимаю на кнопку с именем 'ЗаписатьИСвернуть'
		* ИзИсточникаПроизвольныйКод
			Когда открылось окно "Конструктор отчета"
			И в табличном документе 'ПолеТабличногоДокументаМакет' я перехожу к ячейке 'R9C2'
			И в табличном документе 'ПолеТабличногоДокументаМакет' я делаю двойной клик на текущей ячейке
			И я нажимаю на кнопку с именем 'ПроизвольныйКод'
			И я нажимаю на кнопку с именем 'РедактироватьПроцедуру'
			Тогда открылось окно 'ВА - Нарастающий итог (приемник), : ФормулаВычисления'
			И в поле с именем 'ПолеТекстовогоДокументаПроцедура' я ввожу текст
				|'// Получим ссылки на нужные показатели'|
				|'ПоказательИсточник = Справочники.ПоказателиОтчетов.НайтиПоКоду("Товары_Количество",,,Справочники.ВидыОтчетов.НайтиПоКоду("ВАНарастающийИтогИсточник"));'|
				|''|
				|'// Получаем массив периодов'|
				|'тПериодыОтчета = Новый Массив;'|
				|'For Сч = 0 To ОбъектРасчета.МассивПериодов.Найти(ОбъектРасчета.ПериодОтчета) Do'|
				|' тПериодыОтчета.Добавить(ОбъектРасчета.МассивПериодов.Получить(Сч));'|
				|'EndDo;'|
				|''|
				|'СтруктураПараметровОтбора = Новый Структура("ПоказательОтчета,Валюта,ПериодОтчета,Сценарий,Организация", ПоказательИсточник,ОбъектРасчета.ОсновнаяВалюта,тПериодыОтчета,ОбъектРасчета.Сценарий,ОбъектРасчета.Организация);'|
				|'ДополнительныеПараметры = Новый Структура("ОбщийИтог",Перечисления.ВидыИтоговПоказателя.Сумма);'|
				|'тЗначенияПоказателей = ПолучитьЗначениеПоказателей(СтруктураПараметровОтбора,,ДополнительныеПараметры);'|
				|''|
				|' // Получаем сумму значений показателей'|
				|' Если тЗначенияПоказателей.Количество() Тогда'|
				|'  Результат = тЗначенияПоказателей.Получить(0).Значение;'|
				|' Иначе'|
				|'  Результат = 0; '|
				|' КонецЕсли; '|
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			Тогда открылось окно "1С:Предприятие"
			И я нажимаю на кнопку с именем 'Button0'
			Тогда открылось окно "Конструктор отчета"
			И я нажимаю на кнопку с именем 'ЗаписатьИСвернуть'						

	* Добавляем процедуры в правило обработки		
		* Процедура До вычисления
			Когда открылось окно "Конструктор отчета"
			И я нажимаю на кнопку открытия поля с именем 'ПравилоОбработки'
			Когда Открылась правило расчета для вида отчета 'ВА - Нарастающий итог (приемник)'
			И я нажимаю на кнопку с именем 'ФормаПроцедураВычисления'
			Когда открылось окно 'ВА - Нарастающий итог (приемник), ВА - Нарастающий итог (приемник): ПроцедураВычисления'
			И в поле с именем 'ПолеТекстовогоДокументаПроцедура' я ввожу текст 
				|'// Получим ссылки на нужные показатели'|
				|'ПоказательИсточник = Справочники.ПоказателиОтчетов.НайтиПоКоду("Товары_Количество",,,Справочники.ВидыОтчетов.НайтиПоКоду("ВАНарастающийИтогИсточник"));'|
				|'ПоказательПриемник = Справочники.ПоказателиОтчетов.НайтиПоКоду("ИзИсточникаДоВычисле_Количество",,,ОбъектРасчета.ВидОтчета);'|
				|''|
				|'// Цикл по периодам отчета'|
				|'For СчОбщий = 0 To ОбъектРасчета.МассивПериодов.Количество()-1 Do'|
				|''|
				|' // Получаем значение показателей всех предыдущих и текущего периодов'|
				|' тПериодыОтчета = Новый Массив;'|
				|' For СчПериоды = 0 To СчОбщий Do'|
				|'  тПериодыОтчета.Добавить(ОбъектРасчета.МассивПериодов.Получить(СчПериоды));'|
				|' EndDo;'|
				|' '|
				|' РаскрываемыеАналитики = Новый Структура("Аналитика2");'|
				|''|
				|' СтруктураПараметровОтбора = Новый Структура("ПоказательОтчета,Валюта,ПериодОтчета,Сценарий,Организация",'|
				|'  ПоказательИсточник,ОбъектРасчета.ОсновнаяВалюта,тПериодыОтчета,ОбъектРасчета.Сценарий,ОбъектРасчета.Организация);'|
				|''|
				|' тЗначенияПоказателей = ПолучитьЗначениеПоказателей(СтруктураПараметровОтбора,РаскрываемыеАналитики);'|
				|' тЗначенияПоказателей.Свернуть("Аналитика2","Значение");'|
				|' '|
				|' For Each СтрЗначенияПоказателей In тЗначенияПоказателей Do'|
				|'  УстановитьЗначениеПоказателя('|
				|'   ПоказательПриемник,  '|
				|'   СтрЗначенияПоказателей.Значение,   '|
				|'   ОбъектРасчета.МассивПериодов.Получить(СчОбщий),,'|
				|'   СтрЗначенияПоказателей.Аналитика2);'|
				|' EndDo;'|
				|'  '|
				|'EndDo;'|
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			Тогда открылось окно "1С:Предприятие"
			И я нажимаю на кнопку с именем 'Button0'
		* Процедура После вычисления
			Когда Открылась правило расчета для вида отчета 'ВА - Нарастающий итог (приемник)'
			И я нажимаю на кнопку с именем 'ФормаПроцедураПослеВычисления'
			Когда открылось окно 'ВА - Нарастающий итог (приемник), ВА - Нарастающий итог (приемник): ПроцедураПослеВычисления'
			И в поле с именем 'ПолеТекстовогоДокументаПроцедура' я ввожу текст 
				|'// Получим ссылки на нужные показатели'|
				|'ПоказательИсточник = Справочники.ПоказателиОтчетов.НайтиПоКоду("Товары_Количество",,,Справочники.ВидыОтчетов.НайтиПоКоду("ВАНарастающийИтогИсточник"));'|
				|'ПоказательПриемник = Справочники.ПоказателиОтчетов.НайтиПоКоду("ИзИсточникаПослеВычи_Количество",,,ОбъектРасчета.ВидОтчета);'|
				|''|
				|'// Цикл по периодам отчета'|
				|'For СчОбщий = 0 To ОбъектРасчета.МассивПериодов.Количество()-1 Do'|
				|''|
				|' // Получаем значение показателей всех предыдущих и текущего периодов'|
				|' тПериодыОтчета = Новый Массив;'|
				|' For СчПериоды = 0 To СчОбщий Do'|
				|'  тПериодыОтчета.Добавить(ОбъектРасчета.МассивПериодов.Получить(СчПериоды));'|
				|' EndDo;'|
				|''|
				|' СтруктураПараметровОтбора = Новый Структура("ПоказательОтчета,Валюта,ПериодОтчета,Сценарий,Организация",'|
				|'  ПоказательИсточник,ОбъектРасчета.ОсновнаяВалюта,тПериодыОтчета,ОбъектРасчета.Сценарий,ОбъектРасчета.Организация);'|
				|'  '|
				|' ДополнительныеПараметры = Новый Структура("ОбщийИтог",Перечисления.ВидыИтоговПоказателя.Сумма); '|
				|''|
				|' тЗначенияПоказателей = ПолучитьЗначениеПоказателей(СтруктураПараметровОтбора,,ДополнительныеПараметры);'|
				|' '|
				|' // Получаем сумму значений показателей'|
				|' Если тЗначенияПоказателей.Количество() Тогда'|
				|'  Значение = тЗначенияПоказателей.Получить(0).Значение;'|
				|' Иначе'|
				|'  Значение = 0; '|
				|' КонецЕсли;'|
				|''|
				|' // Устанавливаем значение показателя'|
				|' УстановитьЗначениеПоказателя('|
				|'  ПоказательПриемник,  '|
				|'  Значение,   '|
				|'  ОбъектРасчета.МассивПериодов.Получить(СчОбщий));'|
				|'  '|
				|'EndDo;'|
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			Тогда открылось окно "1С:Предприятие"
			И я нажимаю на кнопку с именем 'Button0'
			Тогда Открылась правило расчета для вида отчета 'ВА - Нарастающий итог (приемник)'
			И я запоминаю заголовок формы в переменную "ЗаголовокОкна"			
			И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
			И я жду закрытия окна '$ЗаголовокОкна$' в течение 20 секунд
			Когда открылось окно "Конструктор отчета"
			И Я закрываю окно "Конструктор отчета"														
	
	И Я Для вида отчета 'ВА - Нарастающий итог (приемник)' я создаю бланк по умолчанию
	И Я Для вида отчета 'ВА - Нарастающий итог (приемник)' в бланке для группы раскрытия с адресом 'R8C1' задаю сортировку 'Номенклатура.Артикул'
	И Я Для вида отчета 'ВА - Нарастающий итог (приемник)' в бланке для группы раскрытия с адресом 'R10C1' задаю сортировку 'Номенклатура.Артикул'
	И Я Для вида отчета 'ВА - Нарастающий итог (приемник)' в бланке для группы раскрытия с адресом 'R12C1' задаю сортировку 'Номенклатура.Артикул'
	И Я Для вида отчета 'ВА - Нарастающий итог (приемник)' в бланке для группы раскрытия с адресом 'R15C1' задаю сортировку 'Номенклатура.Артикул'
	И Я Для вида отчета 'ВА - Нарастающий итог (приемник)' в бланке для группы раскрытия с адресом 'R17C1' задаю сортировку 'Номенклатура.Артикул'
	И Я Для вида отчета 'ВА - Нарастающий итог (приемник)' в бланке для группы раскрытия с адресом 'R19C1' задаю сортировку 'Номенклатура.Артикул'

Сценарий: 08.05 Создание экземпляра отчета - 'ВА - Нарастающий итог (приемник)' 

	И Я создаю экземпляр отчета для вида отчета 'ВА - Нарастающий итог (приемник)' сценарий 'ВА - Основной сценарий' период '01.01.2021' '31.03.2021' периодичность "Месяц" организация 'Меркурий ООО' проект 'ВА - Основной проект' аналитики 'Реализация программных продуктов' '' '' '' '' '' 

	* Рассчитываем и сверяем документ
		И я нажимаю на кнопку с именем 'ФормаЗаполнитьПоУмолчанию'
		Тогда табличный документ 'ПолеТабличногоДокументаМакет' равен макету 'Макеты\ВА_НарастающийИтог.mxl'

	* Еще раз расчитаем документ, убедимся, что ничего не поменялось
		Когда открылось окно '$ЗаголовокОкна$'	
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИПродолжить'
		Тогда Открылся экземпляр отчета для вида отчета 'ВА - Нарастающий итог (приемник)' валюта 'RUB' организация 'Меркурий ООО' сценарий 'ВА - Основной сценарий' периодичность "Месяц" проект 'ВА - Основной проект' аналитики 'Реализация программных продуктов' '' '' '' '' '' 
		И я нажимаю на кнопку с именем 'ФормаЗаполнитьПоУмолчанию'
		Тогда табличный документ 'ПолеТабличногоДокументаМакет' равен макету 'Макеты\ВА_НарастающийИтог.mxl'					

	* Смотрим движения
		Когда открылось окно '$ЗаголовокОкна$ *'
		И я нажимаю на кнопку с именем 'ФормаОткрытьДвиженияДокументаПлоскаяТаблица'
		Тогда открылось окно "1С:Предприятие"
		И я нажимаю на кнопку с именем 'Button0'
		Тогда открылось окно "Плоская таблица значений показателей"
		И я жду когда в табличном документе 'ОтчетТабличныйДокумент' заполнится ячейка 'R2C1' в течение 30 секунд
		Когда Я задаю параметры чтения области макета 'R1C1:R452C20'
		Дано Табличный документ 'ОтчетТабличныйДокумент' равен макету 'Макеты\ВА_НарастающийИтог_Движения.mxl' по шаблону

	* Закроем отчет и документ
		Когда открылось окно "Плоская таблица значений показателей"
		И Я закрываю окно "Плоская таблица значений показателей"
		Тогда открылось окно '$ЗаголовокОкна$'
		И я нажимаю на кнопку с именем 'ЗаписатьИЗакрыть'
		И я жду закрытия окна '$ЗаголовокОкна$' в течение 20 секунд