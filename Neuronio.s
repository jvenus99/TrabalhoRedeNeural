.data

# CARACTERES
caracterEspaco:
  .asciiz  " "

caracterLinha:
  .asciiz  "\n"

caracterMais:
  .asciiz  " + "

caracterIgual:
  .asciiz " = "

#Frases
fraseTreino:
  .asciiz  "Treinando! - "

fraseErro:
  .asciiz  "Erro = "

fraseResultado:
  .asciiz  "\nResultado - " 

# Dados
taxaAprendizado:
  .float   0.005

taxaErro:
  .float   1.1

pesoA:
  .float   0.0

pesoB:
  .float   0.9

.text
main:
  #Convertendo inteiro para float
  lwc1 $f5,taxaAprendizado
  lwc1 $f6,taxaErro
  lwc1 $f7,pesoA
  lwc1 $f8,pesoB

# INÍCIO do Primeiro FOR
treinoInicio:
  li $t0,1  
  j treinoCondicao    

treinoIncremento:   
  move $v0,$t0
  addiu $v0,$v0,1
  move $t0,$v0

treinoCondicao:
  move $v0,$t0
  slt $v0,$v0,12
  beq $v0,$zero,treinoFim

treino:
  #Carrega as entradas do treino ex: 1 + 1
  move $v0,$t0 
  mtc1 $v0,$f0  
  cvt.s.w $f0,$f0
  mov.s $f4,$f0    

  #Calcula a saída esperada
  mov.s $f0,$f4  
  add.s $f0,$f0,$f0 
  mov.s $f10,$f0

  # Calcula o erro (taxaErro)
  mov.s $f2,$f10  
  mov.s $f6,$f7
  mov.s $f0,$f8
  add.s $f0,$f6,$f0
  mov.s $f6,$f4
  mul.s $f0,$f0,$f6
  sub.s $f0,$f2,$f0
  mov.s $f6,$f0 


  #Imrpime na tela os dados do treino
  li $v0, 4 
  la $a0, caracterEspaco
  syscall

  li $v0, 4 
  la $a0, fraseTreino
  syscall

  li $v0, 4  
  la $a0, fraseErro
  syscall

  li $v0, 2 
  mov.s $f12, $f6
  syscall

  li $v0, 4   #
  la $a0, caracterLinha
  syscall

  #Atualiza os pesos
  #Peso A  
  mov.s $f2,$f6 
  mov.s $f0,$f5
  mul.s $f0,$f2,$f0
  mov.s $f2,$f4
  mul.s $f0,$f0,$f2
  mov.s $f2,$f7
  add.s $f0,$f0,$f2
  mov.s $f7,$f0

  #Peso B
  mov.s $f2,$f6  
  mov.s $f0,$f5
  mul.s $f0,$f2,$f0
  mov.s $f2,$f4
  mul.s $f0,$f0,$f2
  mov.s $f2,$f8
  add.s $f0,$f0,$f2
  mov.s $f8,$f0

  j  treinoIncremento 
treinoFim:

# Mostrar os resultados
resultadosInicio:
  li $t1,1 
  j  resultadosCondicao

resultadosIncremento:
  move $v0,$t1  
  addiu $v0,$v0,1
  move $t1,$v0

resultadosCondicao:
  move $v0,$t1  
  slt  $v0,$v0,11
  beq  $v0,$zero,fimGeral

resultados:
  #Inicia as entradas
  move $v0,$t1
  mtc1 $v0,$f0
  cvt.s.w $f0,$f0
  mov.s $f4,$f0

  #Calcula a soma de acordo com a formula
  mov.s $f2,$f4  
  mov.s $f0,$f7
  mul.s $f2,$f2,$f0
  mov.s $f0,$f8
  mul.s $f0,$f4,$f0
  add.s $f0,$f2,$f0
  mov.s $f9,$f0

#Imprime os resultados
printResultados:
  li $v0, 4  
  la $a0, fraseResultado
  syscall

  li $v0, 2 
  mov.s $f12, $f4
  syscall

  li $v0, 4
  la $a0, caracterMais
  syscall

  li $v0, 2 
  mov.s $f12, $f4
  syscall

  li $v0, 4  
  la $a0, caracterIgual  
  syscall

  li $v0, 2 
  mov.s $f12, $f9
  syscall

  li $v0, 4  
  la $a0, caracterLinha 
  syscall

  j  resultadosIncremento
# fim dos resultados
fimGeral:  
  jr $ra