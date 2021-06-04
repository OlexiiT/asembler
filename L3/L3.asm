TITLE Vihidni kod 2.1
;----------------I.ЗАГОЛОВОК ПРОГРАМИ------------------------
IDEAL
MODEL SMALL
STACK 512
;----------------------------II.МАКРОСИ---------------------------------------- 	 	
; Складний макрос для ініціалізації 
MACRO M_Init	;Початок макросу 
mov	ax, @data	; ax <- @data
mov	ds, ax	    ; ds <- ax
mov	es, ax	    ; es <- ax 
ENDM M_Init

;--------------------III.ПОЧАТОК СЕГМЕНТУ ДАНИХ--------------
DATASEG
;Оголошення двовимірного експериментального масиву 16х16 
array2Db 	db 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h
			db 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h
			db 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h
			db 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h
			db 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h
			db 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h
			db 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h
			db 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h
			db 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h
			db 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h
			db 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h
			db 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h
			db 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h
			db 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h
			db 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h
			db 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h, 3h
    
exCode db 0;

;-----------------------VI. ПОЧАТОК СЕГМЕНТУ КОДУ-------------------------------
CODESEG

Start:	
M_Init
    mov ah, [array2Db] ; Запис масиву у старші біти регістру ah
    mov bx, 00h
    mov [bx], ah

;Базово-індексна адресація 

	mov al, 'O'							;Записуємо до молодшої частини ax символ
	mov bx, 70h							;Готуємо базовий регістр, пересування по вертикалі
	mov si, 0fh							;Готуємо індексний регістр, пересування по горизонталі
	mov [array2Db+bx+si], al
	add bx, 10h
	dec si
	mov al, 'M'
	mov [array2Db+bx+si], al
	add bx, 10h
	dec si
	mov al, 'O'
	mov [array2Db+bx+si], al
	add bx, 10h
	dec si
	mov al, 'M'
	mov [array2Db+bx+si], al
	add bx, 10h
	dec si
	mov al, 'O'
	mov [array2Db+bx+si], al
	add bx, 10h
	dec si
	mov al, 'M'
	mov [array2Db+bx+si], al
	add bx, 10h
	dec si
	mov al, 'O'
	mov [array2Db+bx+si], al
	add bx, 10h
	dec si
	mov al, 'M'
	mov [array2Db+bx+si], al
	add bx, 10h
	dec si
	mov al, 'O'
	mov [array2Db+bx+si], al
	
Exit:
	mov ah, 04ch
	mov al, [exCode]
	int 21h
	
end Start