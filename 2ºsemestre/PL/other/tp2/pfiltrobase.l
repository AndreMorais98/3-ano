%{
/* Declaracoes C diversas */
 int acum=0;
 int precototal=0;
 int quant=0;
 int preco=0;
 int total=0;
 char prod[60];
%}

Abrev ER
%%

^[a-zA-Z]+           {sprintf(prod,"%s",yytext);}
[0-9]+\ */\-         {quant=atoi(yytext);acum+=quant;}
\-[0-9]+/\ *€        {preco=atoi(yytext+1);
                      total=preco*quant;
                      precototal+=preco*quant;
                      printf("Vou gastar no %d no prod %s\n",total,prod);
                      }
.|\n                 {;}

%%

int yywrap()
{ return(1); }

int main()
{ yylex();printf("Acum:%d\nPreco total:%d\n",acum,precototal);return 0; }
