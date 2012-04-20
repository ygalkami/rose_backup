/**
 *	input handler - uses unbuffered input, line editing, buffers the input
 *	
 *	Project: xssh
 *	By: Jon Klein, David Pick, Tim Wentz
 **/

#include "input_handler.h"

/**
 *	Start a new buffered, line editing, input line
 *
**/
char * get() {
	struct termios tio_orig;
	struct termios tio_new;
 
	// set to cannotonical mode i.e. unbuffered
	tcgetattr(0, &tio_orig);
	tio_new = tio_orig;
	tio_new.c_lflag &= ~(ICANON|ECHO); /* Clear ICANON and ECHO. */
	tcsetattr(0,TCSANOW,&tio_new);

	// initialize line and char buffer
	line *l = (line *)malloc(sizeof(line));
	_newline(l, 500);

	printf("%s", l->buf);
	for(;;) {
		char c = getc(stdin);
		if(c==127) {
			_rmchar(l);
		}
		// enter key
		else if(c==10) {
			printf("\n");
			break;
		}
		// see if arrow key
		else if(c==27) {
			char c2 = getc(stdin);
			// arrow key
			if(c2==91) {
				char c3 = getc(stdin);
				// left arrow key
				if(c3==68) {
					if(l->curpos > 0) {
						printf("\033[1D");
						l->curpos--;
					}
				}
				// right arrow key
				else if(c3==67) {
					if(l->curpos < l->len) {
						printf("\033[1C");
						l->curpos++;
					}
				}
			}
			// not arrow key
			else {
				_pchar(c, l);
			}
		}
		// tab key
		else if(c==9){
			char *prefix = _getTabPrefix(l);
			if(strcmp(prefix, "abc")==0) {
				_pstr("123", l);
			}
			else if(strcmp(prefix, "in")==0) {
				_pstr("out", l);
			}
		}
		// any other key
		else{
			_pchar(c, l);
		}
	}

	// restore term to buffered input mode
	tcsetattr(0,TCSANOW,&tio_orig);

	// copy the input buffer
	char* temp = (char*)malloc(500*sizeof(char));
	strcpy(temp, l->buf);

	// free the buffer and return the resulting input string
	free(l->buf);
	free(l);
	return temp;
}

/**
 *	Remove a char from the current line buffer at the current cursor position
 *
**/
void _rmchar(line *l) {
	if(l->curpos > 0) {
		printf("\033[1D\033[s");
		if(l->len-l->curpos != 0) {
			strncpy((l->buf+l->curpos-1), l->buf+l->curpos, l->len-l->curpos);
		}
		*(l->buf+l->len-1) = '\0';
		l->len--;
		l->curpos--;
	
		printf("\033[K%s",l->buf+l->curpos);
		printf("\033[u");
	}
}

/**
 *	Prints a char to the current line buffer at the current cursor position
 *
**/
void _pchar(char c, line *l) {
	if(l->curpos==l->len) {
		printf("%c",c);
		*(l->buf+l->curpos) = c;
	}
	else {
		printf("%c\033[s%s",c, l->buf+l->curpos);
		char *temp = (char*)malloc((l->len-l->curpos)*sizeof(char));
		strncpy(temp, l->buf+l->curpos, l->len-l->curpos);
		strcpy(l->buf+l->curpos+1, temp);
		*(l->buf+l->curpos) = c;
		printf("\033[u");
	}
	l->curpos++;
	l->len++;
}

/**
 *	Prints a string to the current line buffer at the current cursor position
 *
**/
void _pstr(char *str, line *l) {
	if(l->curpos==l->len) {
		printf("%s",str);
		strcpy(l->buf+l->curpos, str);
	}
	else {
		printf("%s\033[s%s",str, l->buf+l->curpos);
		char *temp = (char*)malloc((l->len-l->curpos)*sizeof(char));
		strncpy(temp, l->buf+l->curpos, l->len-l->curpos);
		strcpy(l->buf+l->curpos, str);
		strcpy(l->buf+l->curpos+strlen(str), temp);
		printf("\033[u");
	}
	l->curpos = l->curpos+strlen(str);
	l->len = l->len+strlen(str);
	//printf("%s:%d:%d", l->buf, l->curpos, l->len);
}

/**
 *	Initializes the current line buffer
 *
**/
void _newline(line *l, int bufsize) {
	// initialize line and char buffer
	l->buf = (char *)calloc(bufsize, sizeof(char));
	l->curpos = 0;
	l->len = 0;
}

/**
 *	Tab completion prefix grabber
 *
**/
char* _getTabPrefix(line *l) {
	int i = l->curpos-1;
	if(i >= 0) {
		char tc = *(l->buf+i);
		while(tc != ' ' && tc != '/') {
			i--;
			tc = *(l->buf+i);
		}
		char *ret = (char*)malloc((l->curpos-i)*sizeof(char));
		strncpy(ret, l->buf+i+1, l->curpos-i-1);
		return ret;
	}
	return "";
}


