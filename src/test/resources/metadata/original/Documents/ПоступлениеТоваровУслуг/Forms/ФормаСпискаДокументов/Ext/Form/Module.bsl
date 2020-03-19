﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ОбщегоНазначенияУТ.НастроитьПодключаемоеОборудование(ЭтаФорма);
	
	// Обработчик подсистемы "Внешние обработки"
	ДополнительныеОтчетыИОбработки.ПриСозданииНаСервере(ЭтаФорма);
	
	СтруктураБыстрогоОтбора = Неопределено;
	Параметры.Свойство("СтруктураБыстрогоОтбора", СтруктураБыстрогоОтбора);
	
	Если СтруктураБыстрогоОтбора <> Неопределено Тогда
		СтруктураБыстрогоОтбора.Свойство("Склад", Склад);
		СтруктураБыстрогоОтбора.Свойство("Организация", Организация);
		СтруктураБыстрогоОтбора.Свойство("СостояниеОрдера", СостояниеОрдера);
		СтруктураБыстрогоОтбора.Свойство("СостояниеПоступления", СостояниеПоступления);
	КонецЕсли;
	
	УстановитьТекущуюСтраницу();
	
	СписокРаспоряженияНаОформление.ТекстЗапроса = Документы.ПоступлениеТоваровУслуг.ТекстЗапросаЗаказыКОформлению();
	СписокРаспоряженияНаПриемку.ТекстЗапроса = Документы.ПоступлениеТоваровУслуг.ТекстЗапросаРаспоряженияНаПриемку();
	
	ЗаполнитьСпискиВыбораПоСостояниям();
	
	ОтборыСписковКлиентСервер.ОтборПоЗначениюСпискаПриСозданииНаСервере(СписокРаспоряженияНаОформление, "Организация", Организация, СтруктураБыстрогоОтбора);
	ОтборыСписковКлиентСервер.ОтборПоЗначениюСпискаПриСозданииНаСервере(СписокРаспоряженияНаПриемку, "Организация", Организация, СтруктураБыстрогоОтбора);
		
	ОтборыСписковКлиентСервер.ОтборПоЗначениюСпискаПриСозданииНаСервере(СписокРаспоряженияНаПриемку,
		"СостояниеОрдера", 
		?(ЗначениеЗаполнено(СостояниеОрдера), Число(СостояниеОрдера), СостояниеОрдера),
		СтруктураБыстрогоОтбора,,,
		Истина);
	ОтборыСписковКлиентСервер.ОтборПоЗначениюСпискаПриСозданииНаСервере(СписокРаспоряженияНаОформление,
		"СостояниеПоступления", 
		?(ЗначениеЗаполнено(СостояниеПоступления), Число(СостояниеПоступления), СостояниеПоступления),
		СтруктураБыстрогоОтбора,,,
		Истина);
	
	ИспользоватьПоступлениеПоНесколькимЗаказам = ПолучитьФункциональнуюОпцию("ИспользоватьПоступлениеПоНесколькимЗаказам");
	ИспользоватьЗаказыПоставщикам = ПолучитьФункциональнуюОпцию("ИспользоватьЗаказыПоставщикам");
	
	ПравоДобавлятьПоступление = ПравоДоступа("Добавление", Метаданные.Документы.ПоступлениеТоваровУслуг);
	
	Элементы.СписокРаспоряженияНаОформлениеСоздатьПоступлениеТоваровУслуг.Видимость = ПравоДобавлятьПоступление;
	Элементы.СписокРаспоряженияНаОформлениеВалюта.Видимость = ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВалют");
	
	Элементы.СписокРаспоряженияНаОформлениеОформитьАктОРасхождениях.Видимость
		= ПравоДоступа("Добавление", Метаданные.Документы.АктОРасхожденияхПослеПриемки);
		
	ПравоЧтениеСостояниеВыполненияДокументов = ПравоДоступа("Чтение", Метаданные.Отчеты.СостояниеВыполненияДокументов);
	Элементы.СписокРаспоряженияНаОформлениеСостояниеВыполнения.Видимость = ПравоЧтениеСостояниеВыполненияДокументов;
	Элементы.СписокРаспоряженияНаПриемкуСостояниеВыполненияПриемка.Видимость = ПравоЧтениеСостояниеВыполненияДокументов;
	
	НастроитьФормуПоСкладу();
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	МенеджерОборудованияКлиентПереопределяемый.НачатьПодключениеОборудованиеПриОткрытииФормы(ЭтаФорма, "СканерШтрихкода");
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	МенеджерОборудованияКлиентПереопределяемый.НачатьОтключениеОборудованиеПриЗакрытииФормы(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// ПодключаемоеОборудование
	Если Источник = "ПодключаемоеОборудование" И ВводДоступен() Тогда
		Если ИмяСобытия = "ScanData" И МенеджерОборудованияКлиентПереопределяемый.ЕстьНеобработанноеСобытие() Тогда
			ОбработатьШтрихкоды(ПодключаемоеОборудованиеУТКлиент.ПреобразоватьДанныеСоСканераВСтруктуру(Параметр));
		КонецЕсли;
	КонецЕсли;
	// Конец ПодключаемоеОборудование
	
	Если ИмяСобытия = "Запись_ПоступлениеТоваровУслуг" Или
		ИмяСобытия = "Запись_ЗаказПоставщику" Тогда
			Элементы.СписокРаспоряженияНаОформление.Обновить();
			Элементы.СписокРаспоряженияНаПриемку.Обновить();
	КонецЕсли;
	
	Если ИмяСобытия = "Запись_ПриходныйОрдерНаТовары" Тогда
		Элементы.СписокРаспоряженияНаПриемку.Обновить();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	Если СтруктураБыстрогоОтбора <> Неопределено Тогда
		СтруктураБыстрогоОтбора.Свойство("Склад", Склад);
		Настройки.Удалить("Склад");
		СтруктураБыстрогоОтбора.Свойство("Организация", Организация);
		Настройки.Удалить("Организация");
		СтруктураБыстрогоОтбора.Свойство("СостояниеОрдера", СостояниеОрдера);
		Настройки.Удалить("СостояниеОрдера");
		СтруктураБыстрогоОтбора.Свойство("СостояниеПоступления", СостояниеПоступления);
		Настройки.Удалить("СостояниеПоступления");
	Иначе
		Склад = Настройки.Получить("Склад");
		Организация = Настройки.Получить("Организация");
		СостояниеОрдера    = Настройки.Получить("СостояниеОрдера");
		СостояниеПоступления = Настройки.Получить("СостояниеПоступления");
	КонецЕсли;
	
	НастроитьФормуПоСкладу();
	
	МассивСписков = Новый Массив;
	МассивСписков.Добавить("СписокРаспоряженияНаПриемку");
	МассивСписков.Добавить("СписокРаспоряженияНаОформление");
	
	ПараметрыОтбора = Новый Структура;
	ПараметрыОтбора.Вставить("ФормаСписка", ЭтаФорма);
	ПараметрыОтбора.Вставить("МассивСписков", МассивСписков);
	ПараметрыОтбора.Вставить("ИмяКолонки", "Организация");
	ПараметрыОтбора.Вставить("Значение", Организация);
	ПараметрыОтбора.Вставить("Настройки", Настройки);
	
	ОтборыСписковКлиентСервер.УстановитьОтборыПоЗначениюСпискаПриЗагрузкеИзНастроек(ПараметрыОтбора, СтруктураБыстрогоОтбора);
	
	ОтборыСписковКлиентСервер.ОтборПоЗначениюСпискаПриЗагрузкеИзНастроек(СписокРаспоряженияНаПриемку,
		"СостояниеОрдера",
		?(ЗначениеЗаполнено(СостояниеОрдера), Число(СостояниеОрдера), СостояниеОрдера),
		СтруктураБыстрогоОтбора,
		Настройки,
		ЗначениеЗаполнено(СостояниеОрдера),
		,
		Истина);
		
	ОтборыСписковКлиентСервер.ОтборПоЗначениюСпискаПриЗагрузкеИзНастроек(СписокРаспоряженияНаОформление,
		"СостояниеПоступления",
		?(ЗначениеЗаполнено(СостояниеПоступления), Число(СостояниеПоступления), СостояниеПоступления),
		СтруктураБыстрогоОтбора,
		Настройки,
		ЗначениеЗаполнено(СостояниеПоступления),
		,
		Истина);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СкладПриИзменении(Элемент)
	
	НастроитьФормуПоСкладу();
	
КонецПроцедуры

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		СписокРаспоряженияНаОформление,
		"Организация",
		Организация,
		ВидСравненияКомпоновкиДанных.Равно,
		,
		ЗначениеЗаполнено(Организация));
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		СписокРаспоряженияНаПриемку,
		"Организация",
		Организация,
		ВидСравненияКомпоновкиДанных.Равно,
		,
		ЗначениеЗаполнено(Организация));
	
КонецПроцедуры

&НаКлиенте
Процедура СписокРаспоряженияНаОформлениеВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ПоказатьЗначение(Неопределено, Элемент.ТекущиеДанные.Ссылка);
КонецПроцедуры

&НаКлиенте
Процедура СостояниеОрдераПриИзменении(Элемент)
	Состояние = ?(ЗначениеЗаполнено(СостояниеОрдера), Число(СостояниеОрдера), 0);
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(СписокРаспоряженияНаПриемку,
		"СостояниеОрдера",
		Состояние,
		ВидСравненияКомпоновкиДанных.Равно,
		,
		ЗначениеЗаполнено(СостояниеОрдера));
КонецПроцедуры

&НаКлиенте
Процедура СостояниеПоступленияПриИзменении(Элемент)
	
	Состояние = ?(ЗначениеЗаполнено(СостояниеПоступления), Число(СостояниеПоступления), 0);
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(СписокРаспоряженияНаОформление,
		"СостояниеПоступления",
		Состояние,
		ВидСравненияКомпоновкиДанных.Равно,
		,
		ЗначениеЗаполнено(Состояние));
		
КонецПроцедуры

&НаКлиенте
Процедура ГиперссылкаЖурналЗакупкиОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОбщегоНазначенияУТКлиент.ОткрытьЖурнал(ПараметрыЖурнала("Накладные"));
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СоздатьПоступлениеТоваровУслуг(Команда)
	
	ТекущиеДанные = Элементы.СписокРаспоряженияНаОформление.ТекущиеДанные;
	Если Не ОбщегоНазначенияУТКЛиент.ВыбраныДокументыКОформлению(ТекущиеДанные,ПараметрыЖурнала("Накладные")) Тогда
		Возврат;
	КонецЕсли;
	
	ЗакупкиКлиент.СоздатьПоступлениеТоваровНаОснованииЗаказа(
		Элементы.СписокРаспоряженияНаОформление,
		ИспользоватьПоступлениеПоНесколькимЗаказам,
		Склад);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура ОформитьАктОРасхождениях(Команда)
	
	ТекущиеДанные = Элементы.СписокРаспоряженияНаПриемку.ТекущиеДанные;
	Если Не ОбщегоНазначенияУТКЛиент.ВыбраныДокументыКОформлению(ТекущиеДанные,ПараметрыЖурнала("АктОРасхожденияхПослеПриемки")) Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(ТекущиеДанные.Ссылка) <> Тип("ДокументСсылка.ПоступлениеТоваровУслуг") Тогда
		
		ТекстПредупреждения = НСтр("ru = 'Команда не может быть выполнена для указанного объекта!
		|Выберите строку с типом распоряжения ""Поступление товаров и услуг"".'");
		ПоказатьПредупреждение(Неопределено, ТекстПредупреждения);
		Возврат;
		
	КонецЕсли;
	
	СтруктураЗаполнения = Новый Структура("ДокументОснование", ТекущиеДанные.Ссылка);
	ПараметрыЗаполнения = Новый Структура("Основание, ПерезаполнитьПоПриемке", СтруктураЗаполнения, Истина);
	ОткрытьФорму("Документ.АктОРасхожденияхПослеПриемки.ФормаОбъекта", ПараметрыЗаполнения, ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура СостояниеВыполнения(Команда)
	ТекущиеДанные = Элементы.СписокРаспоряженияНаОформление.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		
		ТекстПредупреждения = НСтр("ru = 'Команда не может быть выполнена для указанного объекта!'");
		ПоказатьПредупреждение(Неопределено, ТекстПредупреждения);
		Возврат;
		
	КонецЕсли;
	СписокДокументов = Новый СписокЗначений;
	СписокДокументов.Добавить(ТекущиеДанные.Ссылка);
	ОткрытьФорму("Отчет.СостояниеВыполненияДокументов.Форма.ФормаОтчета", Новый Структура("ВходящиеДокументы", СписокДокументов));
КонецПроцедуры

&НаКлиенте
Процедура СостояниеВыполненияПриемка(Команда)
	ТекущиеДанные = Элементы.СписокРаспоряженияНаПриемку.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено 
		ИЛИ ТипЗнч(ТекущиеДанные.Ссылка) = Тип("СправочникСсылка.СоглашенияСПоставщиками") Тогда
		
		ТекстПредупреждения = НСтр("ru = 'Команда не может быть выполнена для указанного объекта!'");
		ПоказатьПредупреждение(Неопределено, ТекстПредупреждения);
		Возврат;
		
	КонецЕсли;
	СписокДокументов = Новый СписокЗначений;
	СписокДокументов.Добавить(ТекущиеДанные.Ссылка);
	ОткрытьФорму("Отчет.СостояниеВыполненияДокументов.Форма.ФормаОтчета", Новый Структура("ВходящиеДокументы", СписокДокументов));
КонецПроцедуры

&НаКлиенте
Процедура ОформитьПоПриемке(Команда)
	
	ТекущиеДанные = Элементы.СписокРаспоряженияНаПриемку.ТекущиеДанные;
	
	Если Не ОбщегоНазначенияУТКЛиент.ВыбраныДокументыКОформлению(ТекущиеДанные,ПараметрыЖурнала("Накладные")) Тогда
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные.СостояниеОрдера = 1 Тогда
		ТекстПредупреждения = НСтр("ru = 'Перезаполнение по приемке не требуется, так как нет ни одного ордера.'");
		ПоказатьПредупреждение(Неопределено, ТекстПредупреждения);
		Возврат
	КонецЕсли;
	
	Если ТипЗнч(ТекущиеДанные.Ссылка) = Тип("СправочникСсылка.СоглашенияСПоставщиками")
		ИЛИ ТипЗнч(ТекущиеДанные.Ссылка) = Тип("ДокументСсылка.ЗаказПоставщику") Тогда
		
		Если ОпределитьНаличиеОформленныхНакладных(ТекущиеДанные.Ссылка, ТекущиеДанные.Склад) Тогда
			ОткрытьФормуПереоформлениеНакладных(ТекущиеДанные.Ссылка, ТекущиеДанные.Склад);
		Иначе
			Основание = Новый Структура("ДокументОснование, Склад", ТекущиеДанные.Ссылка, ТекущиеДанные.Склад);
			ПараметрыЗаполнения = Новый Структура("Основание, ЗаполнятьПоОрдеру", Основание, Истина);
			ОткрытьФорму("Документ.ПоступлениеТоваровУслуг.ФормаОбъекта", ПараметрыЗаполнения, ЭтаФорма);
		КонецЕсли;
		
	КонецЕсли;
	
	Если ТипЗнч(ТекущиеДанные.Ссылка) = Тип("ДокументСсылка.ПоступлениеТоваровУслуг") Тогда
		ПараметрыЗаполнения = Новый Структура("Ключ, ЗаполнятьПоОрдеру", ТекущиеДанные.Ссылка, Истина);
		ОткрытьФорму("Документ.ПоступлениеТоваровУслуг.ФормаОбъекта", ПараметрыЗаполнения, ЭтаФорма);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()

	// Условное оформление динамического списка "СписокРаспоряженияНаОформление"
	СписокУсловноеОформление = СписокРаспоряженияНаОформление.КомпоновщикНастроек.Настройки.УсловноеОформление;
	СписокУсловноеОформление.Элементы.Очистить();
	
	// Документ имеет высокий приоритет
	Элемент = СписокУсловноеОформление.Элементы.Добавить();
	Элемент.Представление = НСтр("ru = 'Документ имеет высокий приоритет'");
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Приоритет");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Справочники.Приоритеты.ПолучитьВысшийПриоритет();
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ПометкаУдаления");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветФона", ЦветаСтиля.ВысокийПриоритетДокумента);
	
	// Документ имеет низкий приоритет
	Элемент = СписокУсловноеОформление.Элементы.Добавить();
	Элемент.Представление = НСтр("ru = 'Документ имеет низкий приоритет'");
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Приоритет");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Справочники.Приоритеты.ПолучитьНизшийПриоритет();
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ПометкаУдаления");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветФона", ЦветаСтиля.НизкийПриоритетДокумента);
	
	//
	СтандартныеПодсистемыСервер.УстановитьУсловноеОформлениеПоляДата(ЭтотОбъект, "СписокРаспоряженияНаОформление.Дата", "СписокРаспоряженияНаОформлениеДата");
	СтандартныеПодсистемыСервер.УстановитьУсловноеОформлениеПоляДата(ЭтотОбъект, "СписокРаспоряженияНаПриемку.Дата", "СписокРаспоряженияНаПриемкуДата");
	
КонецПроцедуры

#Область ШтрихкодыИТорговоеОборудование

&НаКлиенте
Функция СсылкаНаЭлементСпискаПоШтрихкоду(Штрихкод)
	
	Менеджеры = Новый Массив();
	Менеджеры.Добавить(ПредопределенноеЗначение("Документ.ПоступлениеТоваровУслуг.ПустаяСсылка"));
	Менеджеры.Добавить(ПредопределенноеЗначение("Документ.ЗаказПоставщику.ПустаяСсылка"));
	Возврат ШтрихкодированиеПечатныхФормКлиент.ПолучитьСсылкуПоШтрихкодуТабличногоДокумента(Штрихкод, Менеджеры);
	
КонецФункции

&НаКлиенте
Процедура ОбработатьШтрихкоды(Данные)
	
	МассивСсылок = СсылкаНаЭлементСпискаПоШтрихкоду(Данные.Штрихкод);
	Если МассивСсылок.Количество() > 0 Тогда
		
		Ссылка = МассивСсылок[0];
		Если ТипЗнч(Ссылка) = Тип("ДокументСсылка.ЗаказПоставщику") Тогда
			Элементы.СписокРаспоряженияНаОформление.ТекущаяСтрока = Ссылка;
			Элементы.Страницы.ТекущаяСтраница = Элементы.Страницы.ПодчиненныеЭлементы.СтраницаРаспоряженияНаОформление;
		КонецЕсли;
		
		ПоказатьЗначение(Неопределено, Ссылка);
		
	Иначе
		ШтрихкодированиеПечатныхФормКлиент.ОбъектНеНайден(Данные.Штрихкод);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ПриемкаТоваров

&НаСервере
Функция ОпределитьНаличиеОформленныхНакладных(РаспоряжениеСсылка, Склад)
	
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ЗаказыПоставщикамОстаткиИОбороты.ЗаказПоставщику КАК Заказ,
	|	ЗаказыПоставщикамОстаткиИОбороты.Регистратор КАК Накладная
	|ИЗ
	|	РегистрНакопления.ЗаказыПоставщикам.ОстаткиИОбороты(
	|			,
	|			,
	|			Регистратор,
	|			,
	|			Склад = &Склад И
	|			ЗаказПоставщику = &РаспоряжениеСсылка
	|				И Номенклатура.ТипНоменклатуры В (ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.Товар), 
	|					ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара))) КАК ЗаказыПоставщикамОстаткиИОбороты
	|ГДЕ
	|	ЗаказыПоставщикамОстаткиИОбороты.Регистратор ССЫЛКА Документ.ПоступлениеТоваровУслуг
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ДокументПоступленияТовары.Ссылка.Соглашение,
	|	ДокументПоступленияТовары.Ссылка
	|ИЗ
	|	Документ.ПоступлениеТоваровУслуг.Товары КАК ДокументПоступленияТовары
	|	
	|ГДЕ
	|	ДокументПоступленияТовары.Ссылка.Соглашение = &РаспоряжениеСсылка
	|	И ДокументПоступленияТовары.Склад = &Склад
	|	И ДокументПоступленияТовары.Ссылка.Проведен
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТоварыКОформлениюПоступленияОстатки.ДокументПоступления КАК ДокументПоступления,
	|	ТоварыКОформлениюПоступленияОстатки.КОформлениюОстаток КАК Количество
	|ИЗ
	|	РегистрНакопления.ТоварыКОформлениюПоступления.Остатки(,Склад = &Склад И ДокументПоступления = &РаспоряжениеСсылка) КАК ТоварыКОформлениюПоступленияОстатки
	|ГДЕ
	|	ТоварыКОформлениюПоступленияОстатки.КОформлениюОстаток<>0");
	
	Запрос.УстановитьПараметр("РаспоряжениеСсылка", РаспоряжениеСсылка);
	Запрос.УстановитьПараметр("Склад", Склад);
	УстановитьПривилегированныйРежим(Истина);
	РезультатыЗапроса = Запрос.ВыполнитьПакет();
	
	ОформленныеНакладные = РезультатыЗапроса[0].Выгрузить();
	
	АдресТаблицаНакладныхВоВременномХранилище = ПоместитьВоВременноеХранилище(ОформленныеНакладные);
	НастройкиФормыПереоформленияНакладных = НастройкиФормыПереоформленияНакладных(РаспоряжениеСсылка, Склад);
	Возврат НЕ РезультатыЗапроса[1].Пустой() И ОформленныеНакладные.Количество() > 0;
	
КонецФункции

&НаКлиенте
Процедура ОткрытьФормуПереоформлениеНакладных(РаспоряжениеСсылка, Склад)
	МассивСсылок = Новый Массив;
	МассивСсылок.Добавить(РаспоряжениеСсылка);
	
	РеквизитыШапки = Новый Структура();
	Если ТипЗнч(РаспоряжениеСсылка) = Тип("ДокументСсылка.ЗаказПоставщику") Тогда
		ЗакупкиВызовСервера.СформироватьДанныеЗаполненияПоступления(МассивСсылок, РеквизитыШапки);
	Иначе
		РеквизитыШапки = ЗакупкиВызовСервера.ПолучитьУсловияЗакупок(РаспоряжениеСсылка);
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("Заказы", МассивСсылок);
	ПараметрыФормы.Вставить("Склад", Склад);
	ПараметрыФормы.Вставить("РеквизитыШапки", РеквизитыШапки);
	ПараметрыФормы.Вставить("НастройкиФормы",НастройкиФормыПереоформленияНакладных);
	
	ОткрытьФорму("ОбщаяФорма.ПереоформлениеНакладныхПоРаспоряжениям", ПараметрыФормы);
	
КонецПроцедуры

&НаСервере
Функция НастройкиФормыПереоформленияНакладных(РаспоряжениеСсылка, Склад)
	
	НастройкиФормы = НакладныеСервер.НастройкиФормыПереоформленияНакладных();
	НастройкиФормы.Заголовок = НСтр("ru = 'Переоформление документов закупки по выбранным распоряжениям'");
	НастройкиФормы.ИмяФормыНакладной = "Документ.ПоступлениеТоваровУслуг.Форма.ФормаДокумента";
	НастройкиФормы.НакладнаяНаПриемку = Истина;
	НастройкиФормы.НакладнаяНаОтгрузку = Истина;
	НастройкиФормы.ИспользоватьНакладныеПоНесколькимЗаказам = ИспользоватьПоступлениеПоНесколькимЗаказам;
	Если ТипЗнч(РаспоряжениеСсылка) = Тип("СправочникСсылка.СоглашенияСПоставщиками") Тогда
		НастройкиФормы.ДанныеЗаполнения =  Новый Структура("ДокументОснование, Склад", РаспоряжениеСсылка, Склад);
	КонецЕсли;
	Возврат НастройкиФормы;
	
КонецФункции


#КонецОбласти

#Область Прочее

&НаСервере
Процедура ЗаполнитьСпискиВыбораПоСостояниям()
	
	СписокВыбора = Элементы.СостояниеОрдера.СписокВыбора;
	СписокВыбора.Очистить();
	СписокВыбора.Добавить("1", НСтр("ru='Не оформлены'"),               Ложь, БиблиотекаКартинок.СоздатьНакладную);
	СписокВыбора.Добавить("3", НСтр("ru='Не соответствуют накладным'"), Ложь, БиблиотекаКартинок.НесоответствиеОрдерНакладная);
	
	СписокВыбора = Элементы.СостояниеПоступления.СписокВыбора;
	СписокВыбора.Очистить();
	СписокВыбора.Добавить("1",НСтр("ru='Создать накладную'"),Ложь, БиблиотекаКартинок.СоздатьНакладную);
	СписокВыбора.Добавить("2",НСтр("ru='Дооформить накладную'"),Ложь, БиблиотекаКартинок.ДооформитьНакладную);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьТекущуюСтраницу()
	
	ИмяТекущейСтраницы = "";
	
	Если Параметры.Свойство("ИмяТекущейСтраницы", ИмяТекущейСтраницы) Тогда
		Если ЗначениеЗаполнено(ИмяТекущейСтраницы) Тогда
			ТекущийЭлемент = Элементы[ИмяТекущейСтраницы];
		КонецЕсли;
	Иначе
		Если Не Документы.ПоступлениеТоваровУслуг.ЕстьЗаказыКОформлению(Организация,Склад)
			И Документы.ПоступлениеТоваровУслуг.ЕстьРаспоряженияНаПриемку(Организация,Склад) Тогда
			ТекущийЭлемент = Элементы.СтраницаРаспоряженияНаПриемку;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуПоСкладу()
	
	ОтборСклады = СкладыСервер.СписокПодчиненныхСкладов(Склад);
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		СписокРаспоряженияНаОформление,
		"Склад",
		ОтборСклады,
		ВидСравненияКомпоновкиДанных.ВСписке,
		,
		ОтборСклады.Количество() > 0);
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		СписокРаспоряженияНаПриемку,
		"Склад",
		ОтборСклады,
		ВидСравненияКомпоновкиДанных.ВСписке,
		,
		ОтборСклады.Количество() > 0);
		
	ЕстьОрдерныйНаПоступлениеСклад = СкладыСервер.ЕстьОрдерныйНаПоступлениеСклад(Склад,ТекущаяДатаСеанса());
	ПравоНаЧтениеОстатковТоваровКПоступлению = ПравоДоступа("Чтение", Метаданные.РегистрыНакопления.ТоварыКОформлениюПоступления);
	ДоступностьПриемки = ЕстьОрдерныйНаПоступлениеСклад И ПравоНаЧтениеОстатковТоваровКПоступлению;
	
	Элементы.СостояниеОрдера.Видимость = ДоступностьПриемки;
	Элементы.СтраницаРаспоряженияНаПриемку.Видимость = ДоступностьПриемки;
	Элементы.СписокРаспоряженияНаОформлениеОформитьПоПриемке.Видимость = ДоступностьПриемки и ПравоДобавлятьПоступление;
	Если ДоступностьПриемки Тогда
		Элементы.СписокРаспоряженияНаПриемкуВалюта.Видимость = ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВалют");
	КонецЕсли;
	
	Если Не ЕстьОрдерныйНаПоступлениеСклад
		Или Не ИспользоватьЗаказыПоставщикам Тогда
		Элементы.Страницы.ОтображениеСтраниц = ОтображениеСтраницФормы.Нет;
	Иначе
		Элементы.Страницы.ОтображениеСтраниц = ОтображениеСтраницФормы.ЗакладкиСверху;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ПараметрыЖурнала(КлючНазначенияИспользования)
	
	СтруктураБыстрогоОтбора = Новый Структура;
	СтруктураБыстрогоОтбора.Вставить("Организация",Организация);
	СтруктураБыстрогоОтбора.Вставить("Склад",Склад);
	
	ПараметрыЖурнала = Новый Структура;
	ПараметрыЖурнала.Вставить("СтруктураБыстрогоОтбора",СтруктураБыстрогоОтбора);
	ПараметрыЖурнала.Вставить("ИмяРабочегоМеста","ЖурналДокументовЗакупки");
	ПараметрыЖурнала.Вставить("КлючНазначенияФормы",КлючНазначенияИспользования);
	ПараметрыЖурнала.Вставить("СинонимЖурнала",НСтр("ru = 'Документы закупки'"));
	
	Возврат ПараметрыЖурнала;
	
КонецФункции

#КонецОбласти

#КонецОбласти
