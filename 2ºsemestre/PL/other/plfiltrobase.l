%{
/* Declaracoes C diversas */
%}

Abrev ER

%%

. { ; }


%%

int yywrap(){
  return(1);
}

int main(){
  yylex();
  return 0;
}
