TITLE Lab2
IDEAL										;Директива - тип Асемблера
MODEL small									;Директива - тип моделі пам'яті
Stack 512									;Директива - розмір стеку
;-----------------------------Макроси-----------------------------
Macro M_Init								;Початок макросу
mov ax, @data								;ax <- @data
mov ds, ax									;ds <- ax
mov es, ax									;es <- ax
ENDM M_Init									;Кінець макросу
;-----------------------------Сегмент даних-----------------------------
DATASEG
exCode db 0
rect_line dw 0ea30h, 0ea30h, 0ea30h, 0ea30h, 0ea30h		;Рядок, що буде надруковано
 dw 0ea30h, 0ea30h, 0ea30h, 0ea30h, 0ea30h
 dw 0ea30h, 0ea30h, 0ea30h, 0ea30h, 0ea30h
 dw 0ea30h, 0ea30h, 0ea30h, 0ea30h, 0ea30h
rect_line_length = $-rect_line				;Довжина рядка
;-----------------------------Сегмент коду-----------------------------
CODESEG
Start:
M_Init

	mov dx, 1660							;1640 = 160 * 10 + 30 * 2 (Зміщення лівого верхнього кута у положення (30, 10))
	mov cx, 10								;Лічильник кількості ітерацій циклу
	
loopStart:									;Мітка циклу
	
	mov bx, cx								;bx <- cx
	mov ax, 0B800h							;Сегментна адреса відеопам'яті
	mov es, ax								;es <- ax
	
	mov di, dx								;Початок виведення на екран
	mov si, offset rect_line				;si <- rect_line
	mov cx, rect_line_length				;Число байтів
	cld
	rep movsb
	mov cx, bx								;cx <- bx
	add dx, 160								;Зміщення на наступний рядок
loop loopStart

Exit:
	mov ah, 04ch							
	mov al, [exCode]						;Отримання коду виходу
	int 21h									;Виклик функції DOS 4ch
END Start
