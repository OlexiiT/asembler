TITLE Lab5
;------------------------------------------------------------------------
;	Лр-5
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
Stack 2048			;Директива - розмір стека

;--------------------------Макроси---------------------------------------
Macro M_Init								;Початок макросу
mov ax, @data								;ax <- @data
mov ds, ax									;ds <- ax
mov es, ax									;es <- ax
ENDM M_Init									;Кінець макросу

;---------------------Початок сегменту даних-----------------------------
DATASEG

	array2Db 	db 7, 8, 7, 8, 7, 8, 7, 8, 7, 8, 7, 8, 7, 8, 7, 8
				db 7, 7, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 7
				db 7, 3, 7, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 7
				db 7, 3, 3, 7, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 7
				db 7, 3, 3, 3, 7, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 7
				db 7, 3, 3, 3, 3, 7, 3, 3, 3, 3, 3, 3, 3, 3, 3, 7
				db 7, 3, 3, 3, 3, 3, 7, 3, 3, 3, 3, 3, 3, 3, 3, 7
				db 7, 3, 3, 3, 3, 3, 3, 7, 3, 3, 3, 3, 3, 3, 3, 7
				db 7, 3, 3, 3, 3, 3, 3, 3, 7, 3, 3, 3, 3, 3, 3, 7
				db 7, 3, 3, 3, 3, 3, 3, 3, 3, 7, 3, 3, 3, 3, 3, 7
				db 7, 3, 3, 3, 3, 3, 3, 3, 3, 3, 7, 3, 3, 3, 3, 7
				db 7, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 7, 3, 3, 3, 7
				db 7, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 7, 3, 3, 7
				db 7, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 7, 3, 7
				db 7, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 7, 7
				db 7, 8, 7, 8, 7, 8, 7, 8, 7, 8, 7, 8, 7, 8, 7, 8

	birthdays_array1 db "16072003"
	birthdays_array2 db "19092003"
				
	exCode db 0

;---------------------Початок сегменту коду------------------------------
CODESEG

Start:
M_Init

;---------------------Заповнення масиву датами народження----------------
	mov bx, 077h											;Підготовка регістрів до базової адресації
	mov si, 0h
	mov cx, 4
	w1:														;Заповнення масиву першою датою
		xor si, si											;Встановлюємо регістр рівним нулю
		mov al, [birthdays_array1+si]						;Записуємо першу цифру дати
		mov [array2Db+bx+si], al							;Записуємо цифру у масив
		inc si												;Збільшуємо лічильник на 1
		mov al, [birthdays_array1+si]						;Повторюємо до кінця рядочка..
		mov [array2Db+bx+si], al
		inc si
		mov al, [birthdays_array1+si]
		mov [array2Db+bx+si], al
		inc si
		mov al, [birthdays_array1+si]
		mov [array2Db+bx+si], al
		inc si
		mov al, [birthdays_array1+si]
		mov [array2Db+bx+si], al
		inc si
		mov al, [birthdays_array1+si]
		mov [array2Db+bx+si], al
		inc si
		mov al, [birthdays_array1+si]
		mov [array2Db+bx+si], al
		inc si
		mov al, [birthdays_array1+si]
		mov [array2Db+bx+si], al
		
		add bx, 20h
		loop w1

	mov bx, 087h											;Підготовка регістрів до базової адресації
	mov si, 0h
	mov cx, 4
	w2:														;Заповнення масиву другою датою
		xor si, si											;Встановлюємо регістр рівним нулю
		mov al, [birthdays_array2+si]						;Записуємо першу цифру дати
		mov [array2Db+bx+si], al							;Записуємо цифру у масив
		inc si												;Збільшуємо лічильник на 1
		mov al, [birthdays_array2+si]						;Повторюємо до кінця рядочка..
		mov [array2Db+bx+si], al
		inc si
		mov al, [birthdays_array2+si]
		mov [array2Db+bx+si], al
		inc si
		mov al, [birthdays_array2+si]
		mov [array2Db+bx+si], al
		inc si
		mov al, [birthdays_array2+si]
		mov [array2Db+bx+si], al
		inc si
		mov al, [birthdays_array2+si]
		mov [array2Db+bx+si], al
		inc si
		mov al, [birthdays_array2+si]
		mov [array2Db+bx+si], al
		inc si
		mov al, [birthdays_array2+si]
		mov [array2Db+bx+si], al
		
		add bx, 20h
		loop w2
		
;---------------------Сортування масиву----------------------------------
		mov cx, 255
		
		PROC sort
			loop1:
				mov bx, cx
				mov si, 0
			comp:
				mov al, [array2Db+si]
				mov dl, [array2Db+si+1]
				cmp al, dl
				jb noswap
				mov [array2Db+si], dl
				mov [array2Db+si+1], al
			noswap:
				inc si
				dec bx
				jnz comp
				loop loop1
			ret
		ENDP sort

;---------------------Завершення роботи програми-------------------------
Exit:
	mov ah, 04ch
	mov al, [exCode]
	int 21h
	
END Start
