### Cloud-Storage
Crearemos un Bucket y usaremos algunos comandos para eliminar crear, eliminar y publicar un bucket,
#### Entraremos a la consola de GCP y a cloud shell o debe estar autenticando en su terminal de GCP.
```Bash
gcloud auth list 
```
dentro de la consola de Clud Shell podemos hacer un update.
```Bash
sudo apt update 
sudo apt upgrade -y 
```
clonaremos el repositorio de prueba para los datos que usaremos, puede usar cualquier otro repositorio.

```Bash
git clone -b master  https://github.com/nilofe/smp.git
```
pasaremos algunas variables de entorno, es opcional.
```Bash
PROJECT_ID=$(gcloud config get-value project)
BUCKET=${PROJECT_ID}-nombrebucket
```
Crearemos un bucket de clase multiregional.
```Bash
gsutil mb -c multi_regional gs://${BUCKET}
```
Subiremos nuestra carpeta clonada a nuestro bucket.
```Bash
gsutil -m cp -r smp gs://${BUCKET}
```
Listaremos nuestro archivos de nuestro bucket.
```Bash
gsutil ls gs://${BUCKET}/*
```
ahora haremos una prueba de sincronización de nuestro bucket, agilizaremos algunos cambios.
```Bash
cp smp/README-template.md smp/INFO.md
```
```Bash
rm smp/README-template.md
```
ahora sincronizaremos nuesra cambios locales con nuestro bucket.
```Bash
gsutil -m rsync -d -r smp gs://${BUCKET}/smp
```
listaremos el bucket para ver nuestro sincronización.
```Bash
gsutil ls gs://${BUCKET}/*
```
haremos publico nuestro bucket.
```Bash
gsutil -m acl set -R -a public-read gs://${BUCKET}
```
sacaremos la url de nuestro bucket publico.
```Bash
https://storage.googleapis.com/test-dev-54830-nombrebucket/smp/index.html
```
copiaremos un archivo en nuestro bucket con un tipo de clase distinta "Nearline".
```Bash
gsutil cp -s nearline smp/images/hh.png gs://${BUCKET} 
```
Revisaremos las clase de nuestro archivos.
```Bash
gsutil ls -Lr gs://${BUCKET} | more
```
Listo 
eliminaremos nuestro bucket, antes de eliminar nuestro bucket tenemos que eliminar todos los archivos de nuestro bucket. 
```Bash
gsutil rm -rf gs://${BUCKET}/*
```
ahora eliminaremos nuestro bucket.
```Bash
gsutil rb gs://${BUCKET}
```
