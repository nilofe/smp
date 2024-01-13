### test
## Script 1 - Bash
 ```Bash
#!/bin/bash

for input_dir in in/*; do
    if [ -d "$input_dir" ]; then
        output_dir="out/$(basename "$input_dir")"
        mkdir -p "$output_dir"

        for input_file in "$input_dir"/*; do
            if [ -f "$input_file" ]; then
                filename=$(basename "$input_file")
                filename_without_extension="${filename%.*}"
                output_file="$output_dir/list.txt"

                while IFS= read -r line; do
                    lowercase_line="${line,,}"
                    lowercase_filename="${filename_without_extension,,}"
                    echo "${lowercase_filename}-${lowercase_line}" >> "$output_file"
                done < "$input_file"
            fi
        done
    fi
done
 ```
## Documentación del Funcionamiento del Código
Este bucle  ```for``` itera a través de los directorios dentro de la carpeta ```in```. input_dir tomará el valor de cada directorio encontrado en ```in```.
```bash
#!/bin/bash
for input_dir in in/*; do
```
Esta línea verifica si el valor de  ```input_dir``` corresponde a un directorio utilizando la opción  ```-d``` del comando ```test``` tambien conocido como ```[```. Si es un directorio, ejecutará las instrucciones en el bloque condicional.
```bash
# bash
if [ -d "$input_dir" ]; then
```
Esta línea crea la ruta de salida correspondiente al directorio actual en ```out```. Utiliza el comando ```basename``` para obtener el nombre del directorio sin la ruta completa y luego lo concatena con ```out/```.
 ```Bash
  mkdir -p "$output_dir"
 ```
Este comando crea el directorio de salida ```($output_dir)``` utilizando la opción ```-p``` para crear también los directorios padres si no existen.
 ```Bash
 for input_file in "$input_dir"/*; do
 ```
Esta línea verifica si el valor de ```input_file``` corresponde a un archivo utilizando la opción ```-f``` del comando ```test```. Si es un archivo, ejecutará las instrucciones en el bloque condicional.
 ```Bash
if [ -f "$input_file" ]; then
```
Estas líneas obtienen el nombre del archivo  ```(filename)``` y el nombre del archivo sin extensión ```(filename_without_extension)```. El segundo se obtiene usando una expansión de parámetros para eliminar la extensión del archivo.
 ```Bash
filename=$(basename "$input_file")
filename_without_extension="${filename%.*}"
```
Esta línea crea la ruta al archivo de salida ```list.txt``` en el directorio de salida.
 ```Bash                
 output_file="$output_dir/list.txt"
 ```
Este tercer bucle  ```while``` lee cada línea del archivo de entrada. Utiliza  ```IFS= read -r line``` para leer las líneas, deshabilitando la interpretación de caracteres especiales y manteniendo los espacios iniciales y finales.
 ```Bash
while IFS= read -r line; do
```
Estas líneas convierten la línea actual y el nombre del archivo sin extensión a minúsculas utilizando la expansión de parámetros ```${variable,,}```.
 ```Bash
lowercase_line="${line,,}"
lowercase_filename="${filename_without_extension,,}"
```
Esta línea concatena el nombre del archivo y la línea en minúsculas, y luego guarda esta información en el archivo de salida.
 ```Bash
echo "${lowercase_filename}-${lowercase_line}" >> "$output_file"
```
Esta línea redirige la entrada del bucle desde el archivo de entrada ```($input_file)```. El bucle continuará leyendo cada línea del archivo hasta que se procesen todas.
 ```Bash
done < "$input_file"
```
Esta línea cierra la verificación si el elemento actual en el bucle de archivos es un archivo,```done```cierra el bucle que itera a través de los archivos en el directorio actual en ```in```.
```Bash
            fi
        done
    fi
done
```
