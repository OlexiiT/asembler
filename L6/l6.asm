TITLE Lab6
;------------------------------------------------------------------------
;	Лр-6
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

MODEL small			;Директива - тип моделі пам'яті		
STACK 256			;Директива - розмір стека

;---------------------Початок сегменту даних-----------------------------
DATASEG

	old_offset	dw 10h
	old_seg	dw ?
	
	msg db "Team 7:",10,13
		db "Tymoshenko,",10,13
		db "Tonkyi",10,13,'$'

	nubmer dw 57
		
;---------------------Початок сегменту коду------------------------------
CODESEG

Start:
M_Init
	
	mov di, [nubmer]
	
	call GetIntV

	mov [old_offset], bx
	mov [old_seg], es
	
	mov di, [nubmer]
	mov dx, offset func
	mov ax, seg func
	mov es, ax
	
	call SetIntV
	
	int 57
	
	mov di, [nubmer]
	mov dx, [old_offset]
	mov ax, [old_seg]
	
	mov es, ax
	call SetIntV
	xor al, al
	
M_Exit
	
;--------Встановлення нової функції обробки переривань-------------------
	PROC SetIntV
		cli											;Заборона апаратних переривань
		
		push ax
		push di
		push ds
		
		xor ax, ax									;Встановлюємо значення регістру рівним нулю
		mov ds, ax 	
		shl di, 2
		mov [ds:[di]], dx							;Встановлюємо зміщення у векторі переривання
		mov [ds:[di+2]], es							;Встановлюємо сегмент у векторі переривання
		
		pop ds
		pop di
		pop ax
		
		sti											;Дозвіл апаратних переривань
		ret
	ENDP SetIntV
	
;---------------------Обробник переривань--------------------------------
	PROC func
		mov ax, 03h
		int 10h										;Очищення екрану
		mov ah, 09h	
		mov dx, offset msg
		int 21h										;Вивід на екран повідомлення
		
		mov al, 20h
		out 20h, al
		iret										;Вихід з процедури обробника переривань
	ENDP func
	
;--------Отримання логічної адреси функції обробки переривань------------
	PROC GetIntV
		push ax
		push di
		
		xor ax, ax									;Встановлюємо значення регістру рівним нулю
		mov es, ax
		shl di, 2
		mov bx, [es:[di]]							;Записуємо зміщення процедури обробника переривань
		mov ax, [es:[di+2]]							;Записуємо сегмент процедури обробника переривань
		mov es, ax
		
		pop di
		pop ax
		ret
	ENDP GetIntV
	
END start
