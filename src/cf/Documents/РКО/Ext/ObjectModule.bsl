﻿
Процедура ОбработкаПроведения(Отказ, Режим)

	// регистр ДенежныеСредстваНаличные Расход
	Движения.ДенежныеСредстваНаличные.Записывать = Истина;
	Для Каждого ТекСтрокаРасшифровкаПлатежа Из РасшифровкаПлатежа Цикл
		Движение = Движения.ДенежныеСредстваНаличные.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Организация = Организация;
		Движение.Валюта = Валюта;
		Движение.Сумма = ТекСтрокаРасшифровкаПлатежа.Сумма;
		Движение.СуммаРегл = ТекСтрокаРасшифровкаПлатежа.Сумма;
		Движение.СтатьяДвиженияДенежныхСредств = ТекСтрокаРасшифровкаПлатежа.СтатьяДвиженияДенежныхСредств;
	КонецЦикла;

КонецПроцедуры
