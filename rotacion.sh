#!/bin/bash

# Función que rota un texto usando un cifrado César con un desplazamiento dado
rotate_text() {
  input_text="$1"
  shift="$2"
  output=""

  for (( i=0; i<${#input_text}; i++ )); do
    char="${input_text:i:1}"
    
    # Si es una letra mayúscula (A-Z)
    if [[ "$char" =~ [A-Z] ]]; then
      ascii=$(printf "%d" "'$char")
      rotated=$(($ascii + $shift))
      if [[ $rotated -gt 90 ]]; then
        rotated=$(($rotated - 26))
      fi
      output+=$(printf \\$(printf '%03o' $rotated))
    
    # Si es una letra minúscula (a-z)
    elif [[ "$char" =~ [a-z] ]]; then
      ascii=$(printf "%d" "'$char")
      rotated=$(($ascii + $shift))
      if [[ $rotated -gt 122 ]]; then
        rotated=$(($rotated - 26))
      fi
      output+=$(printf \\$(printf '%03o' $rotated))
    
    # Si no es letra, simplemente se añade el carácter original
    else
      output+="$char"
    fi
  done

  echo "$output"
}

# Pedir el texto al usuario
echo "Ingrese el texto para aplicar todas las rotaciones (1 a 30):"
read input_text

# Mostrar las 26 rotaciones
for (( i=1; i<=26; i++ )); do
  rotated_text=$(rotate_text "$input_text" "$i")
  echo "Rotación $i: $rotated_text"
done

