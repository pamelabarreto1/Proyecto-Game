import wollok.game.*
import bombero.*
import civiles_y_fuego.*
import fondos.*
import logros.*


class AdministradorDeNivel {
    var property objetosPendientes = 0
    method limpiarYReiniciar() {
        game.clear()
        menu.iniciar()
    }

    method perderJuego() {
        game.clear() 
        game.addVisual(fondoGameOver) 
        
        keyboard.space().onPressDo({ 
            self.limpiarYReiniciar()
        })
    }

    method cumplirObjetivo() {
        if (objetosPendientes > 0) {
            objetosPendientes = objetosPendientes - 1
        }

        if (objetosPendientes == 0) {
            game.say(bombero, "¡Misión Cumplida! Ganaste.")

            gestorDeNivel.nivelActual().completar()
                
            game.schedule(2500, { self.limpiarYReiniciar() })
        }
    }
}

const administradorDeNivel = new AdministradorDeNivel(objetosPendientes = 13)

object gestorDeNivel {
    var property nivelActual = null
}

class Nivel {

    const property numeroDeNivel
    const property fondoNivel
    const property posicionBombero
    const property energiaBomberoInicial
    const property aguaBomberoInicial
    const property lago
    const property salida
    const property civiles
    const property fuegos
    const property posicionDeMuros


    method elementosInteractivos() {
        return civiles + fuegos + [lago, salida]
    }
    method cantidadDeObjetivos() {
        return civiles.size() + fuegos.size()
    }


    method iniciar() {
        gestorDeNivel.nivelActual(self)
        console.println(self.cantidadDeObjetivos())
        administradorDeNivel.objetosPendientes(self.cantidadDeObjetivos())

        game.addVisual(self.fondoNivel())
        self.posicionDeMuros().forEach({ p => game.addVisual(new MuroInvisible(position = p)) })

        bombero.prepararNivel(self.posicionBombero(), self.energiaBomberoInicial(), self.aguaBomberoInicial())

        game.addVisual(energiaBombero)
        game.addVisual(cantidadDeAguaBombero)

        self.elementosInteractivos().forEach({ elemento => game.addVisual(elemento) })
        game.addVisual(bombero)

        self.configurarTeclas()
        self.configurarColisiones()
    }

    method completar() {
        estadisticasDelJuego.completarNivel(self.numeroDeNivel())
        self.efectoAlGanar()
    }

    method efectoAlGanar()

    method configurarTeclas() {
        keyboard.w().onPressDo({ bombero.subir() })
        keyboard.s().onPressDo({ bombero.bajar() })
        keyboard.d().onPressDo({ bombero.derecha() })
        keyboard.a().onPressDo({ bombero.izquierda() })

        keyboard.up().onPressDo({ bombero.subir() })
        keyboard.down().onPressDo({ bombero.bajar() })
        keyboard.right().onPressDo({ bombero.derecha() })
        keyboard.left().onPressDo({ bombero.izquierda() })

        keyboard.backspace().onPressDo({ menu.volverAlMenu() })

        keyboard.p().onPressDo({ 
            console.println("game.addVisual(new Muro(position = game.at(" + bombero.position().x() + ", " + bombero.position().y() + ")))")
        })
    }

    method configurarColisiones() {
        game.onCollideDo(bombero, { objeto => objeto.interactuarCon(bombero) })
    }
}
class NivelFacil inherits Nivel {
    override method efectoAlGanar() {
        menu.nivelDificilDesbloqueado(true) 
        game.say(bombero, "¡Nivel 2 Desbloqueado! Volviendo al menú...")
    }
}
class NivelDificil inherits Nivel {
    override method efectoAlGanar() {
        game.say(bombero, "¡Ganaste el juego! Volviendo al menú...")
    }
}

const nivelFacil = new NivelFacil(
    numeroDeNivel = 1,
    fondoNivel = fondoNivel_1,
    posicionBombero = game.at(3, 13),
    energiaBomberoInicial = 250,
    aguaBomberoInicial = 0,
    lago = new Lago(position = game.at(5, 5)),
    salida = new Salida(position = game.at(1, 12)),
    civiles = [
        new Civil(position = game.at(2, 1), image = "civilPidiendoAyuda.png"),
        new Civil(position = game.at(11, 1), image = "civilArrodillado.png"),
        new Civil(position = game.at(11, 4), image = "civilArrodillado.png"),
        new Civil(position = game.at(11, 5), image = "civilAbrazandoRodilla.png"),
        new Civil(position = game.at(8, 11), image = "civilAsustado.png")
    ],
    fuegos = [
        new Fuego(position = game.at(2, 11), daño = 10),
        new Fuego(position = game.at(7, 11), daño = 10),
        new Fuego(position = game.at(8, 12), daño = 10),
        new Fuego(position = game.at(9, 13), daño = 10),
        new Fuego(position = game.at(13, 8), daño = 10),
        new Fuego(position = game.at(13, 7), daño = 10),
        new Fuego(position = game.at(10, 5), daño = 10),
        new Fuego(position = game.at(10, 4), daño = 10)
    ],
    posicionDeMuros = [
        game.at(0, 1), game.at(0, 2), game.at(0, 3), game.at(0, 4), game.at(0, 5), game.at(0, 6),
        game.at(0, 7), game.at(0, 8), game.at(0, 9), game.at(0, 10), game.at(0, 11), game.at(0, 12),
        game.at(0, 13), game.at(0, 14), game.at(0, 15), game.at(1, 0), game.at(1, 1), game.at(1, 2),
        game.at(1, 3), game.at(1, 4), game.at(1, 5), game.at(1, 6), game.at(1, 15), game.at(2, 0),
        game.at(2, 2), game.at(2, 3), game.at(2, 4), game.at(2, 5), game.at(2, 15), game.at(3, 0),
        game.at(3, 2), game.at(3, 3), game.at(3, 4), game.at(3, 5), game.at(3, 15), game.at(4, 0),
        game.at(4, 15), game.at(5, 0), game.at(5, 10), game.at(5, 15), game.at(6, 0), game.at(6, 9),
        game.at(6, 10), game.at(6, 15), game.at(7, 0), game.at(7, 15), game.at(8, 0), game.at(8, 15),
        game.at(9, 0), game.at(9, 7), game.at(9, 15), game.at(10, 0), game.at(10, 7), game.at(10, 9),
        game.at(10, 15), game.at(11, 0), game.at(11, 8), game.at(11, 9), game.at(11, 15), game.at(12, 0),
        game.at(12, 7), game.at(12, 12), game.at(12, 13), game.at(12, 15), game.at(13, 0), game.at(13, 1),
        game.at(13, 2), game.at(13, 12), game.at(13, 13), game.at(13, 15), game.at(14, 0), game.at(14, 1),
        game.at(14, 3), game.at(14, 7), game.at(14, 15), game.at(15, 0), game.at(15, 1), game.at(15, 2),
        game.at(15, 3), game.at(15, 4), game.at(15, 5), game.at(15, 6), game.at(15, 7), game.at(15, 8),
        game.at(15, 9), game.at(15, 10), game.at(15, 11), game.at(15, 12), game.at(15, 13), game.at(15, 14),
        game.at(15, 15)
    ]
)

const nivelDificil = new NivelDificil(
    numeroDeNivel = 2,
    fondoNivel = fondoNivel_2,
    posicionBombero = game.at(3, 14),
    energiaBomberoInicial = 160,
    aguaBomberoInicial = 0,
    lago = new Lago(position = game.at(5, 5)),
    salida = new Salida(position = game.at(3, 14)),
    civiles = [
        new Civil(position = game.at(1, 12), image = "civilAbrazandoRodilla.png"),
        new Civil(position = game.at(1, 4), image = "civilPidiendoAyuda.png"),
        new Civil(position = game.at(8, 1), image = "civilAsustado.png"),
        new Civil(position = game.at(9, 14), image = "civilArrodillado.png"),
        new Civil(position = game.at(14, 7), image = "civilArrodillado.png")
    ],
    fuegos = [
        new Fuego(position = game.at(2, 12), daño = 40),
        new Fuego(position = game.at(2, 4), daño = 40),
        new Fuego(position = game.at(2, 11), daño = 40),
        new Fuego(position = game.at(8, 2), daño = 40),
        new Fuego(position = game.at(8, 14), daño = 40),
        new Fuego(position = game.at(9, 13), daño = 40),
        new Fuego(position = game.at(13, 7), daño = 40),
        new Fuego(position = game.at(13, 8), daño = 40),
        new Fuego(position = game.at(14, 8), daño = 40)
    ],
    posicionDeMuros = [
        game.at(0,3), game.at(0,4), game.at(0,8), game.at(0,11), game.at(0,12), game.at(0,13),
        game.at(1,1), game.at(1,2), game.at(1,5), game.at(1,7), game.at(1,9), game.at(1,10), game.at(1,14), 
        game.at(2,0), game.at(2,5), game.at(2,7), game.at(2,14), game.at(3,0), game.at(3,5), game.at(3,6),
        game.at(3,7), game.at(3,10), game.at(3,15), game.at(4,0), game.at(4,9), game.at(4,11), game.at(4,15), 
        game.at(5,0), game.at(5,9), game.at(5,10), game.at(5,15), game.at(6,0), game.at(6,14), game.at(6,15), 
        game.at(7,0), game.at(7,9), game.at(7,10), game.at(7,14), game.at(7,15), game.at(8,0), game.at(8,9),
        game.at(8,10), game.at(8,15), game.at(9,0), game.at(9,6), game.at(9,7), game.at(9,12), game.at(9,15),
        game.at(10,0), game.at(10,6), game.at(10,7), game.at(10,9), game.at(10,10), game.at(10,11), game.at(10,13),
        game.at(10,14), game.at(11,0), game.at(11,9), game.at(12,1), game.at(12,2), game.at(12,9), 
        game.at(13,3), game.at(13,9), game.at(13,9), game.at(14,3), game.at(14,9), game.at(15,4), game.at(15,5),
        game.at(15,6), game.at(15,7), game.at(15,8)
    ]
)

object menu {
    var property opcionSeleccionada = 1 
    var property nivelDificilDesbloqueado = false 
    const musica = musicaVolume
    
    method iniciar() {
        self.opcionSeleccionada(1)
        if (!musica.inicio()) {
            musica.iniciar()
        }
        game.addVisual(fondoMenu)
        game.addVisual(titulo) 
        game.addVisual(cursorMenu) 
        game.addVisual(textoFacil) 
        game.addVisual(textoDificil)
        game.addVisual(textoControles)
        game.addVisual(trofeo)
        game.addVisual(musica)
        cursorMenu.position(game.at(3,7)) 

        keyboard.up().onPressDo { self.subir() }
        keyboard.down().onPressDo { self.bajar() }
        keyboard.w().onPressDo { self.subir() }
        keyboard.s().onPressDo { self.bajar() }
        keyboard.enter().onPressDo { self.seleccionar()} 
        keyboard.q().onPressDo { pestañaLogros.iniciar()} 
        keyboard.o().onPressDo { musica.toggle()} 
    }

    method subir() {
        if (opcionSeleccionada == 2) {
            opcionSeleccionada = 1
            cursorMenu.position(game.at(3,7)) 
        } else if (opcionSeleccionada == 3) {
            opcionSeleccionada = 2
            cursorMenu.position(game.at(3, 5)) 
        }
    }
    
    method bajar() {
        if (opcionSeleccionada == 1) {
            opcionSeleccionada = 2
            cursorMenu.position(game.at(3,5)) 
        } else if (opcionSeleccionada == 2) {
            opcionSeleccionada = 3
            cursorMenu.position(game.at(3, 3))
        }
    }

    method seleccionar() {
        if (not pestañaLogros.estaEnLogros()) {
            if (opcionSeleccionada == 1) {
                self.empezarNivel(nivelFacil)
            } 
            else if (opcionSeleccionada == 2 and nivelDificilDesbloqueado) {
                self.empezarNivel(nivelDificil)
            } 
            else if (opcionSeleccionada == 3) {
                self.mostrarControles() 
            }
        }
    }
   
    method mostrarControles() {
        game.clear()
        game.addVisual(fondoControles) 

        keyboard.space().onPressDo({ self.volverAlMenu() })
    }

    method empezarNivel(nivel) {
        game.clear()
        nivel.iniciar()
    }

    method volverAlMenu() {
        game.clear()
        self.iniciar()
    }

    method irALogros() {
        game.clear()
        pestañaLogros.iniciar()
    }
}


class Menu {
    const property image
    var property position
}

const titulo = new Menu(image = "TituloMenuEscalado2.png", position = game.at(4, 10))
const textoFacil = new Menu(image = "BotonFaciEscalado.png", position = game.at(4, 5))
const textoDificil = new Menu(image = "BotonDifiEscalado.png", position = game.at(4, 3))
const textoControles = new Menu(image = "controlesMenu.png", position = game.at(4, 1))
const cursorMenu = new Menu(image = "cursorEscalado.png", position = game.at(3, 7))

object musicaVolume {
    const position = game.at(13, 1)
    method position() = position
    const musica = game.sound("(GAME)hitslab-game-gaming-video-game-music-459876.mp3")

    var isPaused = true
    var inicio = false
    method isPaused() = isPaused
    method inicio() = inicio
    method image() = if (isPaused) "DesactivarSonido.png" else "ActivarSonido.png"
    method iniciar() {
        musica.play()
        isPaused = false
        inicio = true
    }
    method toggle() {
        if (isPaused) {
            console.println("PLAY")
            musica.resume()
            isPaused = false
        } else {
            console.println("PAUSE")
            musica.pause()
            isPaused = true
        }
    }
}

object pestañaLogros {
    var estaEnLogros = false
    method estaEnLogros() = estaEnLogros
    method cambiarEstaEnLogros(unbool) {
        estaEnLogros = unbool
    }
    const logro1 = new LogroNivel(position = game.at(2, 13), nivelObjetivo = 1)
    const logro2 = new LogroNivel(position = game.at(8, 13), nivelObjetivo = 2)
    const logro3 = new LogroRescates(position = game.at(2, 10), meta = 3)
    const logro4 = new LogroRescates(position = game.at(8, 10), meta = 20)
    const logro5 = new LogroIncendios(position = game.at(2, 7), meta = 5)
    const logro6 = new LogroIncendios(position = game.at(8, 7), meta = 15)
    
    method iniciar() {
        self.cambiarEstaEnLogros(true)
        game.addVisual(fondoLogros)

        game.addVisual(logro1)
        game.addVisual(logro2)
        game.addVisual(logro3)
        game.addVisual(logro4)
        game.addVisual(logro5)
        game.addVisual(logro6)

        keyboard.backspace().onPressDo({ menu.volverAlMenu() })
        keyboard.backspace().onPressDo({ self.cambiarEstaEnLogros(false) })
    }
}