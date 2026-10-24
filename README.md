# Dardos con viento

Dardos de bar en el navegador: viento, alcohol que te hace temblar y ver doble, y sobres con dardos especiales (fuego, veneno, niebla, caparazones, rayos…). Se juega en PC y celular.

- **Contra Tano**: la máquina del bar.
- **Online de 2 a 6 jugadores**: uno crea una sala, comparte la invitación (o el código de 4 letras), y cuando están todos toca *Empezar*. El orden de tiro se sortea. Conexión directa entre navegadores (WebRTC con [PeerJS](https://peerjs.com)), sin servidor propio.

## Cómo se juega

1. Cada turno tomás un trago (+20% de alcohol) y abrís un sobre con 3 dardos al azar. Elegís uno para tus 3 tiros.
2. Apuntá, mantené apretado para calmar el pulso y soltá para fijar la mira.
3. Tocá de nuevo para frenar la barra de fuerza: en la zona blanca el tiro sale perfecto.
4. 5 rondas. Gana el que más puntos suma.

## Correrlo en tu compu

Es un sitio estático; cualquier servidor sirve:

```sh
python3 -m http.server 8000
# abrir http://localhost:8000
```

(Abrir el `index.html` con doble clic no anda bien porque el navegador bloquea la carga de sonidos.)

## Publicar en GitHub Pages

1. En el repo: **Settings → Pages**.
2. *Source*: **Deploy from a branch**, rama `main`, carpeta `/ (root)`.
3. En un minuto queda en `https://<usuario>.github.io/dardos-con-viento/`.

El botón **Copiar invitación** arma un link `…?sala=ABCD` que abre el juego directo en la sala.

## Publicar en itch.io

1. `./build-itch.sh` → genera `dist/dardos-con-viento-itch.zip`.
2. En itch.io: *Create new project* → *Kind of project*: **HTML** → subí el zip y marcá *This file will be played in the browser*.
3. Tamaño sugerido del visor: 1280×800, con **Mobile friendly** y el botón de pantalla completa activados.

En itch el juego corre dentro de un iframe, así que la invitación copia un link a la versión de **GitHub Pages** con la sala ya puesta (`…/dardos-con-viento/?sala=ABCD`). Por eso conviene tener Pages activado aunque publiques en itch.

## Cómo funciona el online

- El que crea la sala registra el id `dcv-CODIGO` en el servidor público gratuito de PeerJS, que solo sirve para que los navegadores se encuentren. Después todo viaja directo entre ellos.
- El anfitrión hace de centro: cada jugador le manda su dardo elegido, la mira en vivo y dónde cae cada dardo (con una semilla de azar), y el anfitrión lo reenvía al resto. Todos simulan la partida igual, así que ven exactamente el mismo resultado (rebotes, trébol, etc.).
- Con más de 2 jugadores, las cartas que afectan "al rival" (niebla, cervecero, veneno, fuego, caparazón) afectan a todos los demás.
- Si alguien se va, la partida sigue sin él; si se va el anfitrión, la partida termina.
- Para probar con un servidor PeerJS propio: `?peer=host:puerto` en la URL.

Algunas redes muy cerradas (corporativas, ciertos datos móviles) pueden bloquear la conexión directa; en ese caso PeerJS intenta con su relay público.

## Estructura

```
index.html          juego completo (Phaser 3 + HUD + menú + red)
lib/                phaser.min.js 3.80.1 y peerjs.min.js 1.5.4
fonts/              Rajdhani y Russo One (OFL)
cartas/ dardos/ sobre/ sonidos/ vfx/ fx/ fondo/   arte y sonidos
build-itch.sh       zip para itch.io
```
