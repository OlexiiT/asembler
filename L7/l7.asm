TITLE Lab7
;------------------------------------------------------------------------
;	Лр-7
;------------------------------------------------------------------------
;	Архітектура комп'ютера
;	НТУУ "КПІ"
;	ФІОТ
;	1 курс
;	ІТ-01
;------------------------------------------------------------------------
;	Автори: Тимошенко О.О., Тонкий М.О.
;---------------------Заголовок програми---------------------------------
IDEAL				;Директива - тип асемблера tasm
MODEL small			;Директива - тип моделі пам'яті		
STACK 256			;Директива - розмір стека

;--------------------------Макроси---------------------------------------
Macro M_Init								;Початок макросу
mov ax, @data								;ax <- @data
mov ds, ax									;ds <- ax
mov es, ax									;es <- ax
ENDM M_Init									;Кінець макросу

Macro M_Exit								;Початок макросу
	mov ah, 04ch
	int 21h
ENDM M_Exit									;Кінець макросу


;---------------------Початок сегменту даних-----------------------------
DATASEG

	string db 254
	str_len db 0
	
	db 254 dup('*')
												;Повідомлення для виводу інформації
	newline db 13,10,'$'
	result db "Result: $"
	min_message db "The min value is: $"
	
	system_message_1 db 			"---Input command and press enter: ",'$'
	system_message_2 db 			"------Press any key to continue----",13,10,'$'
	
	display_message_start db 		"---Lab7 is running-----------------",13,10,'$'
	display_message_count db 		"------press l - for count----------",13,10,'$'
	display_message_beep db 		"------press Z - for beep-----------",13,10,'$'
	display_message_find db 		"------press t - for find min-------",13,10,'$'
	display_message_exit db 		"------press x - for exit-----------",13,10,'$'
	display_message_finish db 		"---Lab7 finished-------------------",13,10,'$'
	display_message_wait db 			"-----------------------------------",13,10,'$'
												;Числа необхідні для обчислення виразу
	a1 dw -2
	a2 dw 3
	a3 dw 1
	a4 dw 2
	a5 dw 3
												;Час звукового сигналу
	TIME EQU 3000

	array2Db 	db 2h, 2h, 9h, 9h, 5h, 5h, 3h, 8h, 4h, 7h, 2h, 5h, 6h, 4h, 6h, 8h
				db 2h, 2h, 6h, 9h, 8h, 9h, 9h, 6h, 7h, 7h, 2h, 7h, 6h, 3h, 9h, 7h
				db 2h, 3h, 6h, 8h, 2h, 3h, 5h, 3h, 9h, 5h, 4h, 6h, 9h, 8h, 3h, 3h
				db 3h, 5h, 4h, 4h, 3h, 5h, 8h, 5h, 2h, 9h, 2h, 4h, 2h, 9h, 2h, 9h
				db 5h, 3h, 6h, 5h, 2h, 9h, 8h, 9h, 9h, 6h, 2h, 7h, 6h, 4h, 2h, 6h
				db 2h, 6h, 4h, 8h, 8h, 6h, 9h, 5h, 4h, 4h, 6h, 4h, 4h, 3h, 5h, 7h
				db 9h, 9h, 7h, 9h, 5h, 6h, 9h, 5h, 4h, 4h, 4h, 5h, 4h, 3h, 7h, 4h
				db 6h, 9h, 5h, 6h, 8h, 7h, 6h, 3h, 2h, 9h, 3h, 4h, 5h, 2h, 6h, 5h
				db 3h, 6h, 4h, 9h, 6h, 5h, 3h, 9h, 2h, 2h, 3h, 7h, 3h, 2h, 4h, 3h
				db 5h, 6h, 2h, 9h, 3h, 5h, 6h, 9h, 6h, 8h, 6h, 4h, 8h, 3h, 7h, 5h
				db 9h, 2h, 4h, 4h, 3h, 6h, 3h, 3h, 4h, 9h, 5h, 3h, 2h, 6h, 6h, 5h
				db 7h, 9h, 4h, 9h, 6h, 8h, 4h, 7h, 2h, 8h, 7h, 4h, 8h, 3h, 5h, 5h
				db 4h, 5h, 3h, 2h, 5h, 5h, 9h, 2h, 4h, 4h, 2h, 7h, 4h, 8h, 6h, 7h
				db 3h, 3h, 2h, 3h, 4h, 4h, 3h, 2h, 6h, 8h, 6h, 7h, 2h, 9h, 8h, 4h
				db 4h, 6h, 4h, 4h, 7h, 9h, 4h, 8h, 3h, 5h, 4h, 6h, 8h, 8h, 8h, 8h
				db 9h, 4h, 4h, 9h, 8h, 4h, 9h, 3h, 9h, 8h, 5h, 8h, 5h, 8h, 8h, 5h
		
;---------------------Початок сегменту коду------------------------------
CODESEG													
Start:	
M_Init
												;Головний цикл, що виконується вродовж всього часу роботи програми
Main_cycle:
	call display_menu							;Виклик функції (процедури) для друкування меню
	
	call input									;Виклик функції, що приймає значення символа з клавіатури
	
	cmp ax, 06ch								;Порівнюємо значення введеного символа з літерою l
	je Count
	cmp ax, 05ah								;Порівнюємо значення введеного символа з літерою Z
	je Beep
	cmp ax, 74h									;Порівнюємо значення введеного символа з літерою t
	je Find
	cmp ax, 078h								;Порівнюємо значення введеного символа з літерою x
	je Exit										;Перехід до коду виходу з програми
	jmp Main_cycle								;Коли жодна буква не відповідає команді, повертаємося в початок циклу
	
Count:
	call calc									;Виклик функції, що виконує обчислення виразу
	jmp Main_cycle
	
Beep:
	mov dx, offset display_message_wait
	call display_foo
	call sound									;Виклик функції, що відтворює звуковий сигнал
	jmp Main_cycle
	
Find:
	call search									;Виклик функції, що шукає найменше значення у масиві
	jmp Main_cycle
	
Exit:
	mov dx, offset display_message_finish
	call display_foo
	mov ax, 04c00h
	int 21h
	
PROC search										;Функція пошуку найменшого значення у масиві
	mov al, [array2Db]
	mov cx, 255
	xor si, si
	loop1:										;У циклі порівнюємо кожне наступне значення з найменшим з попередніх
		inc si									;та якщо наступне - менше, перезаписуємо його
		mov ah, [array2Db+si]
		cmp al, ah
		jb outer
		
		mov al, ah
		
	outer:
		loop loop1
		
	mov dx, offset newline						;Переходимо на новий рядок
	call display_foo
		
	mov dx, offset min_message					;Виводимо повідомлення про результат
	call display_foo
		
	mov dl, al
	add dl, 30h
	mov ah, 02h
	int 21h
		
	mov dx, offset newline						;Переходимо на новий рядок
	call display_foo
		
	mov dx, offset system_message_2				;Виводимо повідомлення про очікування
	call display_foo
	
	mov ah, 08h									;Чекаємо натискання клавіші
	int 21h
	
	ret
ENDP search

PROC calc										;(((a1 - a2) + a3) / a4 * a5)      ;-2, 3, 1, 2, 3
	mov dx, offset newline						;Переносимо каретку на новий рядок
	call display_foo
	mov dx, offset result						;Виводимо на екран рядок
	call display_foo
	mov ax, [a1]								;ax  <-  a1   		(ax  <-  -2)
	mov cx, [a2]								;cx  <-  a2   		(ax  <-  3)
	sub ax, cx									;ax  <-  ax - cx   	(ax  <-  -2 - 3)
	mov cx, [a3]								;cx  <-  a3 	  	(ax  <-  1)
	add ax, cx									;ax  <-  ax + cx   	(ax  <-  -5 + 1)
	mov cx, [a4]								;cx  <-  a4   		(ax  <-  2)
	idiv cl										;al  <-  ax / cl 	(al  <-  -4 / 2)
	mov cx, [a5]								;cx  <-  a5   		(ax  <-  3)
	imul cl										;ax  <-  al * cl  	(ax  <-  -2 * 3)
	mov bx, ax									;bx  <-  ax
	neg bx										;bx  <-  -bx
	cmp ax, bx									;Порівнюємо значення ax і bx, таким чином дізнаємося знак результату
	jb print									
	
	mov ax, bx									;Якщо результат негативний записуємо у регістр ax модуль результату
	mov ah, '-'									;У старший біт записуємо знак "-"
	add al, 30h									;Щоб отримати з числа код числа (у ASCII) додаємо 30h
	
print:
	mov dl, ah									;Зберігаємо знак
	mov dh, al									;Зберігаємо число
	mov ah, 02h									;Виводимо на екран знак
	int 21h
	mov dl, dh									;Виводимо на екран число
	int 21h
	
	mov dx, offset newline						;Переносимо каретку на новий рядок
	call display_foo
	
	mov dx, offset system_message_2				;Виводимо повідомлення
	call display_foo
	
	mov ah, 08h									;Чекаємо натискання клавіші
	int 21h
	
	ret
ENDP calc
												;Функція, що створює затримку у часі
PROC wait_t										;за допомогою вкладених циклів
	push cx
	mov cx, TIME
	w1:											;Перший цикл
		push cx
		mov cx, TIME
		w2:										;Другий цикл
			loop w2
		pop cx
		loop w1
	pop cx
	ret
ENDP wait_t
												;Функція, що відтворює звуковий сигнал
PROC sound
	
	in al, 61h									;Одержуємо стан динаміка
	or al, 3									;Змінюємо стан на увімкнений
	out 61h, al									;Зберігаємо цей стан
	
	mov al, 10110110B							
	out 43h, al
	
	mov ax, 2700							 	;Встановлюємо частоту звука
	out 42h, al									;Вмикаємо звук
	
	call wait_t									;Викликаємо функцію затримки часу
	
	in al, 61h									;Одержуємо стан динаміка
	and al, 11111100B							;Змінюємо стан на вимкнений
	out 61h, al									;Зберігаємо цей стан
	ret											
ENDP sound
												;Функція виводу меню на екран користувача
PROC display_menu
	mov ax, 00003h								;Команда очищення екрану
	int 10h										;Переривання BIOS
	mov dx, offset display_message_start		;Виводимо основний текст
	call display_foo
	mov dx, offset display_message_count
	call display_foo
	mov dx, offset display_message_beep
	call display_foo
	mov dx, offset display_message_find
	call display_foo
	mov dx, offset display_message_exit
	call display_foo
	mov dx, offset system_message_1
	call display_foo
	ret
ENDP display_menu
												;Функція, що виводить текст на екран
PROC display_foo
	mov ah, 09h
	int 21h
	xor dx, dx
	ret
ENDP display_foo
												;Функція, котра приймає текст з консолі та записує першу літеру у регістр ax
PROC input
	mov ah, 0ah
	mov dx, offset string
	int 21h
	
	xor ax, ax
	mov bx, offset string
	mov ax, [bx+1]
	shr ax, 8
	ret
ENDP input
	
END Start
