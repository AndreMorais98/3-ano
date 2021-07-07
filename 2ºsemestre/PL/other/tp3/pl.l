%{
char* ele, *eu;
%}

Abrev ER

%%

^(?i:eu)=[^.]+          {ECHO;eu=strdup(yytext+3);}
^(?i:ele)=[^.]+         {ECHO;ele=strdup(yytext+4);}
^(?i:eu):               {printf("%s:",eu);}
^(?i:ele):              {printf("%s:",ele);}

%%

int yywrap(){
  return(1);
}

int main(){
  yylex();
  return 0;
}

